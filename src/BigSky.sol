// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Ship } from './ships/Ship.sol';
import "../lib/solmate/src/utils/FixedPointMathLib.sol";

contract BigSky {
  address immutable owner;

  uint72 internal constant PLAYERS_REQUIRED = 1;

  /*//////////////////////////////////////////////////////////////
                               EVENTS
  //////////////////////////////////////////////////////////////*/

  event ShipRegistered(uint256 indexed turn, Ship indexed ship);

  event GameStarted(State state);

  event StarLocations(StarData[] _stars);

  event TurnComplete(uint256 turn, ShipData ship, EnemyData[] enemies, StarData[] allStars);

  event StarCaptured(uint256 playerScore);

  /*//////////////////////////////////////////////////////////////
                            CONSTRUCTOR
  //////////////////////////////////////////////////////////////*/

  constructor(){
    owner = msg.sender;
  }
 
  /*//////////////////////////////////////////////////////////////
                              MODIFIERS
  //////////////////////////////////////////////////////////////*/

  modifier onlyOwner() {
    require(msg.sender == owner, 'NOT OWNER');

    _;
  }

  modifier onlyDuringGame() {
   require(state == State.ACTIVE, 'GAME NOT ACTIVE');
   
   _;
  }

  /*//////////////////////////////////////////////////////////////
                             GAME STATE
  //////////////////////////////////////////////////////////////*/

  enum State {
    WAITING,
    ACTIVE,
    DONE
  }
  State public state;

  uint72 public entropy; 

  uint72 public turn = 10;
  uint256 public playerScore; 

  /*//////////////////////////////////////////////////////////////
                               SHIP
  //////////////////////////////////////////////////////////////*/

  struct ShipData {
    uint256 positionX;
    uint256 positionY;
    Ship ship;
  }
  Ship[] public ships;

  // map ship contract to shipdata 
  mapping(Ship => ShipData) public getShipData;
  
  enum Actions {
    ACCELERATE,
    JUMP
  }

  struct EnemyData {
    uint256 positionX;
    uint256 positionY;
  }
  EnemyData[] public enemies; 
  
  struct StarData {
    uint256 positionX;
    uint256 positionY;
    bool isActive;
  }
  StarData[] public stars;

  /*//////////////////////////////////////////////////////////////
                               SETUP
  //////////////////////////////////////////////////////////////*/

  function startGame() public {
    state = State.ACTIVE;
    
    setEnemies();
    setStars();

    play(turn);
    emit GameStarted(state);
  }

  function registerPlayer(Ship ship) public {
    require(address(getShipData[ship].ship) == address(0), "DOUBLE_REGISTER");
    state = State.WAITING;
    
    uint256 x = getRandomX(entropy);
    uint256 y = getRandomY(entropy);

    getShipData[ship] = ShipData({positionX: x, positionY: y, ship: ship});
    ships.push(ship);

    entropy = uint72(block.timestamp);

    emit ShipRegistered(0, ship);
  }
  
  function setEnemies() internal {
    uint256 x;
    uint256 y;
    EnemyData memory newEnemy;

    for (uint256 i = 0; i < 3; i++) {
      x = getRandomX(i);
      y = getRandomY(i);
      newEnemy = EnemyData({positionX: x, positionY: y});
      enemies.push(newEnemy);
    }
  }
  
  function setStars() internal {
    uint256 x;
    uint256 y;
    StarData memory newStar;

    for (uint256 i = 0; i <= 15; i++) {
      x = getRandomX(i); 
      y = getRandomY(i);
      newStar = StarData({positionX: x, positionY: y, isActive: true});
      stars.push(newStar); 
    } 
    emit StarLocations(stars);
  }

  /*//////////////////////////////////////////////////////////////
                                GAME
  //////////////////////////////////////////////////////////////*/

  function play(uint256 _turns) internal onlyDuringGame {
    for(; _turns != 0; _turns--){
      Ship[] memory allShips = ships;
      EnemyData[] memory allEnemies = enemies;
      StarData[] memory allStars = stars;
      
      uint currentTurn = _turns;
      Ship currentShip = allShips[turn % PLAYERS_REQUIRED];
      ShipData memory playerShip = getShipData[currentShip];

      currentShip.takeYourTurn(playerShip, allStars);

      checkCollide(currentShip);

      emit TurnComplete(currentTurn, getShipData[currentShip], allEnemies, allStars);
    } 
  }

  function checkCollide(Ship _ship) internal onlyDuringGame {
    ShipData memory currentShip = getShipData[_ship];

    for (uint256 j = 0; j < stars.length; j++) {
      if (stars[j].positionX == currentShip.positionX && 
          stars[j].positionY == currentShip.positionY &&
          stars[j].isActive == true){
            playerScore += 5; 
            stars[j].isActive = false;
            emit StarCaptured(playerScore);
      }
    }
  } 
  
  function enemyMove(uint _seed) internal {
    uint256 rand = uint256(keccak256(abi.encodePacked(entropy * _seed))) % 4; 
    
    for(uint256 i = 0; i < enemies.length; i++){
      uint256 x = enemies[i].positionX;
      uint256 y = enemies[i].positionY;
      
      if(rand == 0){
        if(enemies[i].positionX < 18){
        enemies[i].positionX += 1;
        }
      } else if (rand == 1){
        if(enemies[i].positionX > 0){
        enemies[i].positionX -= 1;
        }
      } else if (rand == 2){
        if(enemies[i].positionY < 12){
        enemies[i].positionY += 1;
        }
      } else if (rand == 3){
        if(enemies[i].positionY > 0){
        enemies[i].positionY -= 1;
        }
      }
    }
  }

  /*//////////////////////////////////////////////////////////////
                            SHIP ACTIONS
  //////////////////////////////////////////////////////////////*/

  function playerMove(uint8 _move) external {

    ShipData storage ship = getShipData[Ship(msg.sender)]; 
      
      if(_move == 0){
        require(ship.positionY + 1 < 17, "error");
          ship.positionY += 1;
      } else 
      if(_move == 1){
        require((ship.positionY - 1) > 0, "error");
          ship.positionY -= 1;
      } else 
      if(_move == 2){
        require(ship.positionX - 1 > 0, "error");
          ship.positionX += 1;
      } else
      if(_move == 3){
      require(ship.positionX + 1 < 12, "error");
          ship.positionX -= 1;
      }
  }

  function playerJump(uint72 _gridX, uint72 _gridY) external {
    ShipData storage ship = getShipData[Ship(msg.sender)]; 

    require(_gridX < 12 && _gridX > 0, 'out or range');
    require(_gridY < 18 && _gridY > 0,'out of range');

    ship.positionX = _gridX;
    ship.positionY = _gridY;
  }
  
  /*//////////////////////////////////////////////////////////////
                               UTILS
  //////////////////////////////////////////////////////////////*/

  function getRandomX(uint _seed) internal view returns(uint256){
    return uint(keccak256(abi.encodePacked(entropy * _seed))) % 12;
  } 

  function getRandomY(uint _seed) internal view returns(uint256){
    return uint(keccak256(abi.encodePacked(entropy * _seed))) % 17;
  }

}

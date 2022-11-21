// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Ship } from './ships/Ship.sol';

contract BigSky {
  address immutable owner;

  uint72 internal constant PLAYERS_REQUIRED = 1;

  /*//////////////////////////////////////////////////////////////
                               EVENTS
  //////////////////////////////////////////////////////////////*/

  event ShipRegistered(uint256 indexed turn, Ship indexed ship);
  event GameStarted(State state);
  event PlayerMove(uint256 _positionX, uint256 _positionyY);

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

  uint72 public turn = 100;

  struct ShipData {
    uint256 positionX;
    uint256 positionY;
    Ship ship;
  }
  Ship[] public ships;

  mapping(Ship => ShipData) public getShipData;

  struct EnemyData {
    uint256 positionX;
    uint256 positionY;
  }
  EnemyData[] public enemies; 
  
  struct StarData {
    uint256 positionX;
    uint256 positionY;
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

    getShipData[ship] = ShipData({positionX: 0, positionY: 0, ship: ship});
    ships.push(ship);

    entropy = uint72(block.timestamp);

    emit ShipRegistered(0, ship);
  }
  
  function setEnemies() internal {
    uint256 x;
    uint256 y;
    EnemyData memory newEnemy;

    for (uint256 i = 0; i < 3; i++) {
      x = getRandomX();
      y = getRandomY();
      newEnemy = EnemyData({positionX: x, positionY: y});
      enemies.push(newEnemy);
    }
  }
  
  function setStars() internal {
    uint256 x;
    uint256 y;
    StarData memory newStar;

    for (uint256 i = 0; i <= 15; i++) {
      x = getRandomX(); 
      y = getRandomY();
      newStar = StarData({positionX: x, positionY: y});
      stars.push(); 
    } 
  }

  /*//////////////////////////////////////////////////////////////
                                GAME
  //////////////////////////////////////////////////////////////*/

  function play(uint256 _turns) internal onlyDuringGame {
    for(; _turns != 0; _turns--){
      Ship[] memory allShips = ships;
      EnemyData[] memory allEnemies = enemies;
      StarData[] memory allStars = stars;
      
      uint currentTurn = turn;
      Ship currentShip = allShips[turn % PLAYERS_REQUIRED];
    } 
  }

  /*//////////////////////////////////////////////////////////////
                               UTILS
  //////////////////////////////////////////////////////////////*/

  function getRandomX() internal view returns(uint256){
    return uint(keccak256(abi.encodePacked(entropy))) % 12;
  } 

  function getRandomY() internal view returns(uint256){
    return uint(keccak256(abi.encodePacked(entropy))) % 17;
  }

}

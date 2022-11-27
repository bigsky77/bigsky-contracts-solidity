// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Ship } from './ships/Ship.sol';
import "../lib/solmate/src/utils/SafeCastLib.sol";

contract BigSky {
  using SafeCastLib for uint256;
  
    using SafeCastLib for uint256;
  uint72 internal constant PLAYERS_REQUIRED = 1;
  mapping(address => uint256) public playerHighScore;

  /*//////////////////////////////////////////////////////////////
                               EVENTS
  //////////////////////////////////////////////////////////////*/

  event ShipRegistered(uint256 indexed turn, Ship indexed ship);

  event GameStarted(State state);

  event GameComplete(State state);

  event TurnComplete(uint256 turn, uint256 playerScore, ShipData ships, StarData[] allStars);

  event StarCaptured(uint256 playerScore);

  /*//////////////////////////////////////////////////////////////
                            CONSTRUCTOR
  //////////////////////////////////////////////////////////////*/

  
  /*//////////////////////////////////////////////////////////////
                              MODIFIERS
  //////////////////////////////////////////////////////////////*/

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

  uint72 public turn = 30;
  uint256 public playerScore; 

  /*//////////////////////////////////////////////////////////////
                               SHIP
  //////////////////////////////////////////////////////////////*/

  struct ShipData {
    uint256 positionX;
    uint256 positionY;
    uint256 balance;
    Ship ship;
  }
  Ship[] public ships;

  // map ship contract to shipdata 
  mapping(Ship => ShipData) public getShipData;

  struct StarData {
    uint256 positionX;
    uint256 positionY;
    bool isActive;
  }
  StarData[] public stars;

  /*//////////////////////////////////////////////////////////////
                               SETUP
  //////////////////////////////////////////////////////////////*/

  function startGame() internal {
    setStars();

    play(turn);
    emit GameStarted(state);
  }

  function launchShip(Ship ship) public {
//    require(address(getShipData[ship].ship) == address(0), "DOUBLE_REGISTER");
    
    entropy = uint72(block.timestamp);

    uint256 x = getRandomX(entropy);
    uint256 y = getRandomY(entropy);

    getShipData[ship] = ShipData({positionX: x, positionY: y, balance: 100, ship: ship});
    ships.push(ship);

    startGame();
  }
  
  function setStars() internal {
    uint256 x;
    uint256 y;
    StarData memory newStar;

    for (uint256 i = 0; i < 16; i++) {
      x = getRandomX(i); 
      y = getRandomY(i);
      newStar = StarData({positionX: x, positionY: y, isActive: true});
      stars.push(newStar); 
    } 
  }

  /*//////////////////////////////////////////////////////////////
                                GAME
  //////////////////////////////////////////////////////////////*/

  function play(uint256 _turns) internal {

    for(; _turns != 0; _turns--){
      Ship[] memory allShips = ships;
      StarData[] memory allStars = stars;
      
      uint currentTurn = _turns;
      Ship currentShip = allShips[ships.length - 1];
      ShipData memory playerShip = getShipData[currentShip];

      currentShip.takeYourTurn(playerShip, allStars);

      checkCollide(currentShip);

      emit TurnComplete(currentTurn, playerScore, getShipData[currentShip], allStars);
    } 

    if(playerScore > playerHighScore[msg.sender]){
      playerScore = playerHighScore[msg.sender];
    }

    emit GameComplete(state);
  }

  function checkCollide(Ship _ship) internal  {
    ShipData memory currentShip = getShipData[_ship];

    for (uint256 j = 0; j < stars.length; j++) {
      if (stars[j].positionX == currentShip.positionX && 
          stars[j].positionY == currentShip.positionY &&
          stars[j].isActive == true){
            currentShip.balance += 10;
            playerScore += 5; 
            stars[j].isActive = false;
            emit StarCaptured(playerScore);
      }
    }
  } 

  /*//////////////////////////////////////////////////////////////
                            SHIP ACTIONS
  //////////////////////////////////////////////////////////////*/

  function playerMove(uint8 _move) external {
    uint256 cost = 1;

    ShipData storage ship = getShipData[Ship(msg.sender)]; 
    ship.balance -= cost.safeCastTo32();
    ship.balance -= cost;

      if(_move == 0){
        if(ship.positionY + 1 > 12){
          ship.positionY = 0;
        } else {
          ship.positionY += 1;
        } 
      } 

      else 
      if(_move == 1){
        if((ship.positionY - 1) <= 1){
          ship.positionY = 12;
        } else {
          ship.positionY -= 1;
        } 
      } 
      
      else 
      if(_move == 2){
        if((ship.positionX + 1) > 17){
          ship.positionX = 0;
        } else {
          ship.positionX += 1;
        } 
      } 
      
      else 
      if(_move == 3){
        if((ship.positionX - 1) <= 1){
          ship.positionX = 17;
        } else {
          ship.positionX -= 1;
        } 
     } 
  }

  /*//////////////////////////////////////////////////////////////
                               UTILS
  //////////////////////////////////////////////////////////////*/

  function getRandomX(uint _seed) internal view returns(uint256){
    return uint(keccak256(abi.encodePacked(entropy * _seed))) % 17;
  } 

  function getRandomY(uint _seed) internal view returns(uint256){
    return uint(keccak256(abi.encodePacked(entropy * _seed))) % 12;
  }
  
}





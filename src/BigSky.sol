// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Ship } from './ships/Ship.sol';

contract BigSky {
  address immutable owner;

  /*//////////////////////////////////////////////////////////////
                               EVENTS
  //////////////////////////////////////////////////////////////*/

  event ShipRegistered(uint256 indexed turn, Ship indexed ship);
  event GameStart(bool _isStarted);
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

  /*//////////////////////////////////////////////////////////////
                             GAME STATE
  //////////////////////////////////////////////////////////////*/

  bool isStarted;

  uint72 public entropy; 

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
    isStarted = true;
    
    setEnemies();
    setStars();
    emit GameStart(isStarted);
  }

  function registerPlayer(Ship ship) public {
    require(address(getShipData[ship].ship) == address(0), "DOUBLE_REGISTER");

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

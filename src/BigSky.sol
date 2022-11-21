// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Ship } from './ships/Ship.sol';

contract BigSky {
  address immutable owner;

  /*//////////////////////////////////////////////////////////////
                               EVENTS
  //////////////////////////////////////////////////////////////*/

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

  enum ShipType{
    PLAYER,
    ENEMY,
    STAR
  } 

  ShipType ship_type; 

  struct ShipData {
    uint256 positionX;
    uint256 positionY;
    ShipType ship_type;
  }
  ShipData ship;

  /*//////////////////////////////////////////////////////////////
                               SETUP
  //////////////////////////////////////////////////////////////*/

  function startGame() public {
    isStarted = true;
    
    setPosition();
    emit GameStart(isStarted);
  }

  function setPosition() internal {
    uint256 x = 0;
    uint256 y = 0;
    ship = ShipData(x, y, ship_type); 

    emit PlayerMove(x, y);
  }

  /*//////////////////////////////////////////////////////////////
                                GAME
  //////////////////////////////////////////////////////////////*/

  function updatePosition(uint _x, uint _y) public {
    ship.positionX = _x;
    ship.positionY = _y;

    emit PlayerMove(_x, _y);
  }

  function getPosition() public view returns(ShipData memory _ship){
    return ship;
  }

}

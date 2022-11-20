// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BigSky {
  address immutable owner;

  event GameStart(bool _isStarted);

  constructor(){
    owner = msg.sender;
  }

  bool isStarted;

  modifier onlyOwner() {
    require(msg.sender == owner, 'NOT OWNER');

    _;
  }

  struct ShipData {
    uint256 positionX;
    uint256 positionY;
  }
  ShipData ship;

  function startGame() public {
    isStarted = true;
    
    emit GameStart(isStarted);
  }

  function setPosition() public {
    uint256 x = 0;
    uint256 y = 0;
    ship = ShipData(x, y); 
  }

  function updatePosition(uint _x, uint _y) public {
    ship.positionX = _x;
    ship.positionY = _y;
  }

  function getPosition() public view returns(ShipData memory _ship){
    return ship;
  }

}

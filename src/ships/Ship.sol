// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "../BigSky.sol";

contract Ship {
  BigSky internal immutable bigsky; 

  constructor(BigSky _bigsky) {
    bigsky = _bigsky;
  }

  function takeYourTurn(BigSky.ShipData memory yourShip, BigSky.StarData[] memory allStars) external virtual  {
    uint256 x = yourShip.positionX;
    uint256 y = yourShip.positionY;
    
    bigsky.playerMove(0);
    bigsky.playerMove(2); 
    
  }

}

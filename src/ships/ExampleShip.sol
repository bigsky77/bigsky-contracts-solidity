// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "../BigSky.sol";
import "./Ship.sol";

contract ExampleShip is Ship {

  constructor(BigSky _bigsky) Ship(bigsky){}

  function takeYourTurn(BigSky.ShipData memory yourShip, BigSky.StarData[] memory allStars) external override  {
    uint256 x = yourShip.positionX;
    uint256 y = yourShip.positionY;
    
    if(x < 18) bigsky.playerMove(0);
    if(x < 10) bigsky.playerMove(2); 
    
  }

}

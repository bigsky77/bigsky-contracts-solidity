// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "../BigSky.sol";

contract Ship {
  BigSky internal immutable bigsky; 

  constructor(BigSky _bigsky) {
    bigsky = _bigsky;
  }

  function takeYourTurn(BigSky.ShipData memory yourShip, BigSky.StarData[] memory allStars, BigSky.EnemyData[] memory allEnemies) external virtual  {
    uint8 nextMove = findNearestStar(allStars, yourShip);
    bigsky.playerMove(nextMove);    
  }

  function findNearestStar(BigSky.StarData[] memory allStars, BigSky.ShipData memory yourShip) internal view returns(uint8) {
   
  }

  
}



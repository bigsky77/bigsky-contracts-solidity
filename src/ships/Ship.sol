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
    for(uint256 j = 0; j < allStars.length; j++){
      if(allStars[j].positionX == yourShip.positionX){
        if(allStars[j].positionY > yourShip.positionY){
          uint256 distance = allStars[j].positionY - yourShip.positionY;
            if(distance < 3){
              return 0;
            }
        } else if(allStars[j].positionY < yourShip.positionY){
          uint256 distance = yourShip.positionY - allStars[j].positionY;
            if(distance < 3){
              return 1;
            }
        }
      } else if(allStars[j].positionY == yourShip.positionY) {
         if(allStars[j].positionX > yourShip.positionX){
          uint256 distance = allStars[j].positionX - yourShip.positionX;
            if(distance < 3){
              return 2;
            }
        } else if(allStars[j].positionY < yourShip.positionX){
          uint256 distance = yourShip.positionX - allStars[j].positionX;
            if(distance < 3){
              return 3;
            }
          }     
        } else {
          return 0;
        }
      }
    }
}



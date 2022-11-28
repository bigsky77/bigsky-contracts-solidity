// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BigSky.sol";
import "../src/ships/Ship.sol";
import "../src/ships/ExampleShip.sol";

contract BigSkyTest is Test {
    BigSky public bigsky;

    uint256 testNumber;
    address player;

    function setUp() public {
        bigsky = new BigSky();
    }
    
    function testGame() public {
        Ship ship = new Ship(bigsky);
        bigsky.launchShip(ship);

        Ship ship1 = new Ship(bigsky);
        bigsky.launchShip(ship1);
        
        Ship ship2 = new Ship(bigsky);
        bigsky.launchShip(ship2);
   }

    
}

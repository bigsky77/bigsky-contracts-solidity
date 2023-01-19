// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BigSky.sol";
import "../src/ships/Ship.sol";

contract BigSkyTest is Test {
    BigSky public bigsky;

    function setUp() public {
        bigsky = new BigSky();

    }
    
    function testGame() public {
        Ship ship = new Ship(bigsky);
        Ship ship2 = new Ship(bigsky);
        bigsky.launchShip(ship);
        bigsky.launchShip(ship2);
        bigsky.launchShip(ship2);
    }
}

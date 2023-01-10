// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BigSky.sol";
import "../src/ships/Ship.sol";
import "../src/ships/ExampleShip.sol";

contract BigSkyTest is Test {
    BigSky public bigsky;

    function setUp() public {
        bigsky = new BigSky();

    }
    
    function testGame() public {
        Ship ship1 = new Ship(bigsky);
        vm.label(address(ship1), "ship 1");

        Ship ship2 = new Ship(bigsky);
        vm.label(address(ship2), "ship 2");

        Ship ship3 = new Ship(bigsky);
        vm.label(address(ship3), "ship 3");

        bigsky.launchShip(ship1);
        bigsky.launchShip(ship2);
        bigsky.launchShip(ship3);

    }
}

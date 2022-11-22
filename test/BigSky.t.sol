// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BigSky.sol";
import "../src/ships/Ship.sol";

contract BigSkyTest is Test {
    BigSky public bigsky;
    Ship public ship;

    uint256 testNumber;
    address player;

    function setUp() public {
        bigsky = new BigSky();
        ship = new Ship(bigsky);
    }
    
    function testGame() public {
        bigsky.registerPlayer(ship);
        bigsky.startGame();
        BigSky.ShipData memory ship;
    }
}

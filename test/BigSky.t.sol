// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BigSky.sol";
import "../src/ships/Ship.sol";
import "../src/ships/ExampleShip.sol";

contract BigSkyTest is Test {
    BigSky public bigsky;

    address player;
    address player2;
    address player3;
    
    function setUp() public {
        bigsky = new BigSky();
        
        player = address(1);
        vm.label(address(player), 'player1');

        player2 = address(2);
        vm.label(address(player2), 'player2');

        player3 = address(3);
        vm.label(address(player3), 'player3');
    }
    
    function testGame() public {
      
      vm.startPrank(address(player));
        Ship ship = new Ship(bigsky);
        bigsky.launchShip(ship);
      vm.stopPrank();
      
      vm.startPrank(address(player2));
        Ship ship2 = new Ship(bigsky);
        bigsky.launchShip(ship2);
      vm.stopPrank();
   
      vm.startPrank(player3);
        Ship ship3 = new Ship(bigsky);
        bigsky.launchShip(ship3);
        
        Ship ship4 = new Ship(bigsky);
        bigsky.launchShip(ship4);
        
        Ship ship5 = new Ship(bigsky);
        bigsky.launchShip(ship5);
      vm.stopPrank();
   
    }

    
}

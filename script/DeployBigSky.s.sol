// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import "../src/BigSky.sol";
import "../src/ships/Ship.sol";
import "../src/ships/ExampleShip.sol";

contract DeployBigSky is Script {

    function run() public {
      vm.startBroadcast();

      BigSky bigsky = new BigSky();
      Ship ship = new Ship(bigsky);
      
    }
}

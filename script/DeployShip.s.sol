// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import "../src/BigSky.sol";
import "../src/ships/Ship.sol";

contract DeployShip is Script {

  function run() public {
    vm.startBroadcast();
  }

}

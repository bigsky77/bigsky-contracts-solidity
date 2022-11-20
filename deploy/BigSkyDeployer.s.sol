// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import "../src/BigSky.sol";

contract DeployBigSky is Script {
    function run() public {
        vm.startBroadcast();

        new BigSky();
    }
}

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
      
      vm.stopBroadcast();

      address player2 = vm.addr(0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d);
      vm.startBroadcast(0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d);
      
      Ship ship2 = new Ship(bigsky);
      Ship ship3 = new Ship(bigsky);
      
      bigsky.launchShip(ship2);
      bigsky.launchShip(ship3);

      vm.stopBroadcast();

      address player3 = vm.addr(0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a);
      vm.startBroadcast(0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a);
      
      Ship ship4 = new Ship(bigsky);
      Ship ship5 = new Ship(bigsky);
      
      bigsky.launchShip(ship4);
      bigsky.launchShip(ship5);
     
      vm.stopBroadcast();
      
      address player4 = vm.addr(0x7c852118294e51e653712a81e05800f419141751be58f605c371e15141b007a6);
      vm.startBroadcast(0x7c852118294e51e653712a81e05800f419141751be58f605c371e15141b007a6);
      
      Ship ship6 = new Ship(bigsky);
      Ship ship7 = new Ship(bigsky);
      
      bigsky.launchShip(ship6);
      bigsky.launchShip(ship7);
     
      vm.stopBroadcast();
      
      address player5 = vm.addr(0x47e179ec197488593b187f80a00eb0da91f1b9d0b13f8733639f19c30a34926a);
      vm.startBroadcast(0x47e179ec197488593b187f80a00eb0da91f1b9d0b13f8733639f19c30a34926a);
      
      Ship ship8 = new Ship(bigsky);
      Ship ship9 = new Ship(bigsky);
      
      bigsky.launchShip(ship8);
      bigsky.launchShip(ship9);
     
      vm.stopBroadcast();
    }
}

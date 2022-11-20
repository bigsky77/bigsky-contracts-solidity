// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BigSky {
  address immutable owner;

  constructor(){
    owner = msg.sender;
  }

  bool isStarted;

  modifier onlyOwner() {
    require(msg.sender == owner, 'NOT OWNER');

    _;
  }

  function startGame() public {
    isStarted = true;
  }

}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BigSky.sol";

contract BigSkyTest is Test {
    BigSky public bigsky;

    uint256 testNumber;
    address player;

    function setUp() public {
        bigsky = new BigSky();
    }
    
    function test_write() public {
    }
}

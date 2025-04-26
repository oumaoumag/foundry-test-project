// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter counter;

    function setUp() public {
        counter = new Counter(); // Create a new Counter contract for testing
    }

    function test_Increment() public {
        counter.inc(); // Call increment
        assertEq(counter.get(), 1); // Check if count is 1
    }

    function test_Decrement() public {
        counter.inc(); // Set count to 1
        counter.dec(); // Call decrement
        assertEq(counter.get(), 0); // Check if count is 0
    }

    function testFail_DecrementUnderflow() public {
        counter.dec(); // Should fail (count is 0)
    }
}
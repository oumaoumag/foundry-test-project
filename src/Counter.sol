//SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Counter {
    uint256 public count; // Stores the count (start at 0)

    function increment() external {
        count += 1;   // Increase count by 1
    }

    function decrement() external {
        count -= 1;   // Decrease count by 1
    }

    function getCount() external view returns (uint256) {
        return count; // Return current count
    }
}
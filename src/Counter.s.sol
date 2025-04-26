// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract DeployCounter is Script {
    function run() external {
        // Start broadcasting transactions using the private key
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // Deploy the Counter contract
        Counter counter = new Counter();
        // Stop broadcasting
        vm.stopBroadcast();
        // Log the deployed address
        console.log("Counter deployed at:", address(counter));
    }
}
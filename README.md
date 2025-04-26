# Beginner's Guide to Setting Up Foundry and Deploying a Counter Contract on Lisk Sepolia

This guide walks you through setting up Foundry and deploying a simple Counter smart contract on the Lisk Sepolia testnet. We'll follow best practices and keep things straightforward.

## Prerequisites

- MetaMask wallet installed and set up
- Basic terminal knowledge
- Internet connection
- Code editor (VS Code recommended)
- Rust installed (required for Foundry)

## Step 1: Install Foundry

1. Install Rust first:
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

2. Update your terminal to recognize Rust:
```bash
source $HOME/.cargo/env
```

3. Verify Rust installation:
```bash
rustc --version
```

4. Install Foundry:
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

5. Verify Foundry installation:
```bash
forge --version
cast --version
anvil --version
```

## Step 2: Create a New Foundry Project
Let’s set up a new project for our Counter contract.

1. Initialize a new project:
```bash
forge init foundry-test-project
cd foundry-test-project
```

This creates a structure like:
```plain
counter-project/
├── src/           # Your smart contracts go here
├── test/          # Tests for your contracts
├── script/        # Scripts to deploy contracts
├── lib/           # External libraries
├── foundry.toml   # Project settings
```

2. Explore the Project:

 + src/ is where we’ll write our Counter contract.
 + test/ is for testing to ensure our contract works.
 + script/ is for deploying the contract to Lisk Sepolia.

3. Install the standard library:
```bash
forge install foundry-rs/forge-std
```

## Step 3: Create the Counter Contract
Our `Counter` contract will store a number, let users increment or decrement it, and display the current value. Create a file called `Counter.sol` in the `src/` folder.

Open `src/Counter.sol` in your editor and add:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Counter {
    uint256 public count;

    // Function to get the current count
    function get() public view returns (uint256) {
        return count;
    }

    // Function to increment count by 1
    function inc() public {
        count += 1;
    }

    // Function to decrement count by 1
    function dec() public {
        // Prevent underflow
        require(count > 0, "Counter: cannot decrement below zero");
        count -= 1;
    }

    // Function to reset count to zero
    function reset() public {
        count = 0;
    }
}
```

**What’s Happening?**

- `count`: A public variable to store the number.
- `inc()`: Adds 1 to `count`.
- `dec()`: Subtracts 1, but checks if `count` is above 0.
- `get()`: Returns the current `count` without modifying the blockchain.

## Step 4: Create the Test File

Create `test/Counter.t.sol`:

```solidity
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
```

## Step 5: Create the Deployment Script

Create `src/Counter.s.sol`:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";
import {console} from "forge-std/console.sol";

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
```

## Step 6: Configure Foundry

Update `foundry.toml`:

```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
evm_version = "paris"
solc_version = "0.8.20"

[rpc_endpoints]
lisk_sepolia = "https://rpc.sepolia-api.lisk.com"
```

## Step 7: Set Up Environment Variables

1. Create `.env` file:
```bash
echo "PRIVATE_KEY=your_private_key_here" > .env
```

2. Add `.env` to `.gitignore`:
```bash
echo ".env" >> .gitignore
```

## Step 8: Build and Test

1. Compile contracts:
```bash
forge build
```

2. Run tests:
```bash
forge test -vv
```

## Step 9: Deploy to Lisk Sepolia

1. Source environment variables:
```bash
source .env
```

2. Deploy:
```bash
forge script src/Counter.s.sol:DeployCounter --rpc-url lisk_sepolia --broadcast
```

## Step 10: Interact with Your Contract

Replace `DEPLOYED_ADDRESS` with your contract's address:

1. Get count:
```bash
cast call DEPLOYED_ADDRESS "getCount()(uint256)" --rpc-url lisk_sepolia
```

2. Increment count:
```bash
cast send DEPLOYED_ADDRESS "increment()" --rpc-url lisk_sepolia --private-key $PRIVATE_KEY
```

## Troubleshooting

- If deployment fails:
  - Ensure you have Lisk Sepolia testnet ETH
  - Verify your private key is correct in `.env`
  - Check RPC URL in `foundry.toml`

- If compilation fails:
  - Check import statements
  - Verify solidity version compatibility
  - Run `forge build -vvv` for detailed errors

## Best Practices

- Never commit your `.env` file
- Always run tests before deployment
- Use testnet for development
- Keep your private key secure

## Next Steps

- Add more functionality to the Counter contract
- Implement frontend integration
- Explore Foundry's advanced testing features
- Learn about contract verification on Lisk Sepolia

## Resources

- [Foundry Book](https://book.getfoundry.sh/)
- [Lisk Documentation](https://lisk.com/documentation)
- [Solidity Documentation](https://docs.soliditylang.org/)

# Counter Smart Contract Project

A simple Ethereum smart contract project built with Foundry demonstrating a basic counter implementation.

## Quick Start

1. Install Foundry:
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

2. Clone and install dependencies:
```bash
git clone <your-repo-url>
cd counter-project
forge install
```

3. Build and test:
```bash
forge build
forge test
```

## Documentation

For a comprehensive guide on setting up, developing, and deploying this project, see [Beginner's Guide](article.md).

## Project Structure

```
counter-project/
├── src/
│   ├── Counter.sol        # Main contract
│   └── Counter.s.sol      # Deployment script
├── test/
│   └── Counter.t.sol      # Contract tests
├── lib/                   # Dependencies
├── foundry.toml           # Foundry configuration
└── .env                   # Environment variables (git-ignored)
```

## Key Features

- Increment/decrement functionality
- Underflow protection
- Event emissions
- Comprehensive test suite
- Deployment scripts

## Security Notes

- Never commit private keys or `.env` files
- Use separate wallets for testing and production
- Always test on testnet before mainnet
- See [article.md](article.md) for detailed security considerations

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## License

MIT License - see the LICENSE file for details.

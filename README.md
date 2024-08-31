# FundMe Smart Contract

**FundMe** is a smart contract built on the Ethereum blockchain that allows users to contribute Ether (ETH) towards a funding goal. The contract ensures contributions meet a minimum USD value using Chainlink's price feeds. It also supports efficient withdrawals by the contract owner with optimized gas usage.

## Table of Contents

1. [Overview](#overview)
2. [Features](#features)
3. [Project Structure](#project-structure)
4. [Usage](#usage)
5. [Testing](#testing)
6. [Deployment](#deployment)
7. [Contributing](#contributing)
8. [License](#license)

## Overview

The **FundMe** contract is designed for decentralized fundraising by allowing users to contribute ETH. The contract owner can withdraw the funds, and contributions are validated against a minimum USD amount using Chainlink's price feed oracles. The project is built to be secure, efficient, and easy to integrate into decentralized applications.

### Key Components

- **FundMe.sol**: Manages contributions, withdrawals, and owner-only functions.
- **PriceConverter.sol**: Converts ETH amounts to USD using Chainlink's price feed.
- **HelperConfig.sol**: Manages network-specific configurations for price feeds.
- **MockV3Aggregator.sol**: Simulates price feeds for local testing.

## Features

- **Decentralized Fundraising**: Multiple users can contribute ETH to the contract.
- **Minimum Contribution**: Validates that each contribution meets a minimum USD value using Chainlink.
- **Owner-Only Withdrawals**: Only the contract owner can withdraw the funds collected.
- **Gas-Optimized Withdrawals**: Includes a `cheaperWithdraw` function to minimize gas costs.
- **Fallback and Receive Functions**: Ensures the contract can handle direct ETH transfers.

## Project Structure

```plaintext
├── src
│   ├── FundMe.sol                 # Main contract for funding and withdrawals
│   ├── PriceConverter.sol         # Library for ETH to USD conversion
├── script
│   ├── DeployFundMe.s.sol         # Script for deploying the FundMe contract
│   ├── Interactions.s.sol         # Script for interacting with the contract (funding, withdrawing)
│   ├── HelperConfig.s.sol         # Configuration script for different networks
├── test
│   ├── FundMeTest.sol             # Unit tests for the FundMe contract
│   ├── FundMeTestintegration.sol  # Integration tests for FundMe
│   ├── mocks
│       └── MockV3Aggregator.sol   # Mock price feed contract for testing
└── .env                           # Environment variables (e.g., RPC URL, private key, API key)

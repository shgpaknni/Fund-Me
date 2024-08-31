# FundMe

**FundMe** is a smart contract project designed to demonstrate a decentralized funding mechanism on the Ethereum blockchain. The contract allows users to contribute Ether to a fund and includes features to check contributions and withdraw funds. This project utilizes Chainlink's price feeds for ETH/USD conversion and includes various testing scripts for validation.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Features](#features)
3. [Installation](#installation)
4. [Usage](#usage)
5. [Testing](#testing)
6. [Scripts](#scripts)
7. [Contributing](#contributing)
8. [License](#license)

## Project Overview

The FundMe contract enables users to:
- Contribute ETH to a fund.
- Check their contribution.
- Withdraw funds by the contract owner.

The project includes testing scripts using Foundry and interactions scripts for deployment and withdrawals.

## Features

- **Fund Contract**: Allows users to contribute ETH.
- **Price Conversion**: Uses Chainlink's price feed to convert ETH to USD.
- **Withdrawals**: Allows only the contract owner to withdraw funds.
- **Testing**: Includes unit and integration tests to ensure functionality.

## Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/shgpaknni/Fund-Me.git
   cd Fund-Me

require("@nomicfoundation/hardhat-toolbox");
const { vars } = require("hardhat/config");

const DEVNET_PRIVATE_KEY = process.env.DEVNET_PRIVATE_KEY;

module.exports = {
  solidity: {
    version: "0.8.24",  // Updated to match the contract's Solidity version
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    devnet: {
      url: 'http://localhost:8545',
      accounts: DEVNET_PRIVATE_KEY ? [`0x${DEVNET_PRIVATE_KEY}`] : [`0x${DEVNET_PRIVATE_KEY}`],
      chainId: 32382,
      gas: 'auto',
      gasPrice: 'auto',
    },
  },
};

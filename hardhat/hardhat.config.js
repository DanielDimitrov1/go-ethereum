require("@nomicfoundation/hardhat-toolbox");
const { vars } = require("hardhat/config");

const DEVNET_PRIVATE_KEY = process.env.DEVNET_PRIVATE_KEY

module.exports = {
  solidity: "0.8.13",
  networks: {
    devnet: {
      url: 'http://localhost:8545/${process.env.DEVNET_PRIVATE_KEY}',
      accounts: [DEVNET_PRIVATE_KEY]",
      chainId: "32382"
    },
  },
};

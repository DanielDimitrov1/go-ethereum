require("@nomicfoundation/hardhat-toolbox");
const { vars } = require("hardhat/config");

const DEVNET_PRIVATE_KEY = process.env.DEVNET_PRIVATE_KEY

module.exports = {
  solidity: "0.8.13",
  networks: {
    devnet: {
      url: 'http://geth:8551/${process.env.DEVNET_PRIVATE_KEY}',
      accounts: "remote",
      chainId: "32382"
    },
  },
};

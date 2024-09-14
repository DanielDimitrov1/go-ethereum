require("@nomicfoundation/hardhat-toolbox");
const { vars } = require("hardhat/config");

const DEVNET_PRIVATE_KEY = process.env.DEVNET_PRIVATE_KEY

module.exports = {
  solidity: "0.8.13",
  networks: {
    localhost: {
      url: `http://localhost:8545`,
      accounts: [DEVNET_PRIVATE_KEY],
    },
  },
};

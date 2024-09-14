require("@nomicfoundation/hardhat-toolbox");
const { vars } = require("hardhat/config");

const SEPOLIA_PRIVATE_KEY = vars.get("SEPOLIA_PRIVATE_KEY");

module.exports = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: `http://localhost:8545`,
      accounts: [SEPOLIA_PRIVATE_KEY],
    },
  },
};

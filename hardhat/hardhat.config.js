require("@nomicfoundation/hardhat-toolbox");
const { vars } = require("hardhat/config");

const SEPOLIA_PRIVATE_KEY = vars.get("2e0834786285daccd064ca17f1654f67b4aef298acbb82cef9ec422fb4975622");

module.exports = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: `http://localhost:8545`,
      accounts: [SEPOLIA_PRIVATE_KEY],
    },
  },
};

require("@nomicfoundation/hardhat-toolbox");
const { vars } = require("hardhat/config");

const DEVNET_PRIVATE_KEY = process.env.DEVNET_PRIVATE_KEY;

module.exports = {
  solidity: "0.8.24",
  networks: {
    devnet: {
      url: 'http://localhost:8545',  // The RPC URL
      accounts: DEVNET_PRIVATE_KEY ? [`0x${DEVNET_PRIVATE_KEY}`] : [], // Ensure the private key is prefixed with 0x and is properly passed
      chainId: 32382,  // Use number for chainId
      gas: 'auto',     // Optional: you can specify the gas limit
      gasPrice: 'auto' // Optional: use 'auto' for default gas price
    },
  },
};

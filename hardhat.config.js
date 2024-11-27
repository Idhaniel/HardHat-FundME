require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers")
require("dotenv").config()
require("hardhat-deploy")

/** @type import('hardhat/config').HardhatUserConfig */
const GOERLI_RPC_URL = process.env.GOERLI_RPC_URL

const GOERLI_PRIVATE_KEY = process.env.GOERLI_PRIVATE_KEY

const LOCALHOST_RPC_URL = process.env.LOCALHOST_RPC_URL

//const POLYGON_PRIVATE_KEY = process.env.POLYGON_PRIVATE_KEY

// const POLYGON_RPC_URL = process.env.POLYGON_PRIVATE_KEY

module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    goerli: {
      url: GOERLI_RPC_URL,
      accounts: [GOERLI_PRIVATE_KEY],
      chainId: 5
    },
    localhost: {
      url: LOCALHOST_RPC_URL,
      chainId: 31337
    },
    // polygon: {
    //   url: POLYGON_RPC_URL,
    //   accounts: [POLYGON_PRIVATE_KEY]
    // }

  },
  solidity: "0.8.17",
  namedAccounts: {
    deployer: {
      default: 0,
      localhost: 9
    }
  }
};

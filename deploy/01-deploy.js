const {network} = require("hardhat");
const {networkConfig} = require("../helper-hardhat-config")
console.log(network.config.chainId)
module.exports = async ({getNamedAccounts, deployments}) => {
    const {deploy, log} = deployments;
    const {deployer} = await getNamedAccounts();
    const chainId = network.config.chainId
    log("is the problem from here?")
    log(chainId)

    const ethUsdPriceFeedAddress = networkConfig[chainId]["ethUsdPriceFeed"]
    const fundMe = await deploy("FundMe", {
        from: deployer,
        args: [ethUsdPriceFeedAddress],
        log: true
    })
    log(`Deployed at ${fundMe.address}`)
}
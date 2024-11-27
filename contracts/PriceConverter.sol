// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(AggregatorV3Interface priceFeed) internal view returns(uint256){
        // AggregatorV3Interface price = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (
            /*uint80 roundId*/,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();

        return uint256(answer * 1e10);
    }
    function getConversionRate(uint256 _amount, AggregatorV3Interface priceFeed) internal view returns(uint256){
        uint256 rate = getPrice(priceFeed);
        return (rate * _amount) / 10e18;
    }
}
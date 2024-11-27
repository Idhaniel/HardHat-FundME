//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./PriceConverter.sol";

error Unauthorized();

contract FundMe {

    using PriceConverter for uint256;

    mapping (address => uint) public funderToFunded;
    uint256 public constant MINIMUM_USD = 50 * 10e18;
    address[] public funders;
    address public immutable i_owner;
    AggregatorV3Interface public priceFeed;

    constructor(address priceFeedAddress){
        priceFeed = AggregatorV3Interface(priceFeedAddress);
        i_owner = msg.sender;
    }

    function fund() public payable{
        require(msg.value.getConversionRate(priceFeed) >= MINIMUM_USD,"Insufficient funds");
        funderToFunded[msg.sender] += msg.value;
        funders.push(msg.sender);
    }

    modifier authorized {
        if(msg.sender != i_owner) revert Unauthorized();
        _;
    }

    function withdraw() public authorized{
        for (uint256 _index = 0; _index < funders.length; _index++) {
            funderToFunded[funders[_index]] = 0;
        }
        funders = new address[](0);
        (bool transaction,) = payable(msg.sender).call{value : address(this).balance}("");
        require(transaction, "Something went wrong with the transaction");
    }
    receive() external payable{
        fund();
    }
    fallback() external payable{
        fund();
    }
}

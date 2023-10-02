// SPDX-License-Identifier: MIT
//This is going to a library that we are going to attach to uint256

pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
library PriceConverter
{
     function getPrice() internal view returns(uint256){
        //ABI
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int price,,,)=priceFeed.latestRoundData();
        //ETH in terms of USD
        return uint256(price * 1e10);
    }
    function getConversionRate(uint ethAmount) internal  view returns ( uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd= (ethPrice * ethAmount)/1e18;
        return ethAmountInUsd;
    }


}
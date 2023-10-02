//Get funds from users
//withdraw funds
//set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe{

    uint256 public minimumUSD=50 *1e18;
    address[] public funders;
    mapping (address=>uint256) public addressToAmountFunded;

    function fund() public payable 
     {
        //Want to be able to set a minimum fund amount in USD
        require(getConversionRate(msg.value )>= minimumUSD,"Not enough fund");//1e18==1*10**18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]=msg.value;
    }
    function getPrice() public view returns(uint256){
        //ABI
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int price,,,)=priceFeed.latestRoundData();
        //ETH in terms of USD
        return uint256(price * 1e10);
    }
    function getConversionRate(uint ethAmount) public  view returns ( uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd= (ethPrice * ethAmount)/1e18;
        return ethAmountInUsd;
    }



}
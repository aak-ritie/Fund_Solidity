//Get funds from users
//withdraw funds
//set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint256;

    uint256 public minimumUSD=50 *1e18;
    address[] public funders;
    mapping (address=>uint256) public addressToAmountFunded;

    function fund() public payable 
     {
        
        //Want to be able to set a minimum fund amount in USD
        require(msg.value.getConversionRate()>= minimumUSD,"Not enough fund");//1e18==1*10**18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]=msg.value;
    }
    function withdraw() public {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++)
        {
            address funder =funders[funderIndex];
            addressToAmountFunded[funder]=0;
        }
        //Reset Array
        funders =new address[](0);
        //actually withdraw funds
        
        //transfer
        //payable(msg.sender).transfer(address(this).balance);
        //send
        // bool sendSucess= payable(msg.sender).send(address(this).balance);
        //require(sendSucess,"Send failed");
        //call
        (bool callSucess, )=payable (msg.sender).call{value:address(this).balance}("");
        require(callSucess,"Call failed");
    }
    

}
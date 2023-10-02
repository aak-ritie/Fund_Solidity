//Get funds from users
//withdraw funds
//set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe{

    uint256 public minimumUSD=50;

    function fund() public payable 
     {
        //Want to be able to set a minimum fund amount in USD
        require(msg.value >= minimumUSD,"Not enough fund");//1e18==1*10**18

    }
    function getPrice() public{
        //ABI
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
         
    }


}
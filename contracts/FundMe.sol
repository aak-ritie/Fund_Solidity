//Get funds from users
//withdraw funds
//set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

error NotOwner();



contract FundMe{
    using PriceConverter for uint256;

    uint256 public constant minimumUSD=50 *1e18;
    address[] public funders;
    mapping (address=>uint256) public addressToAmountFunded;
    //Constructor will get called when we deploy the contract 
    
    address public immutable i_owner;

    constructor()
    {
         i_owner=msg.sender;
    }

    function fund() public payable 
     {
        
        //Want to be able to set a minimum fund amount in USD
        require(msg.value.getConversionRate()>= minimumUSD,"Not enough fund");//1e18==1*10**18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]=msg.value;
    }

    //onlyi_owner modifier is applied to withdraw function
    function withdraw() public onlyi_owner {


        
        //require(msg.sender == i_owner ,"Sender is not i_owner");
        
        
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

//Creating modifier
 modifier  onlyi_owner {
    //require(msg.sender == i_owner ,"Sender is not i_owner");
    if(msg.sender!=i_owner)
    {
        revert NotOwner();
    }
    _;//This represent rest of the code
 }


receive() external payable {
    fund();
 }

 fallback() external payable {
    fund();
  }

}
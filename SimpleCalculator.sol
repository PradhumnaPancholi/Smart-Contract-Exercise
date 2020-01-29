pragma solidity 0.5.11;

contract SimpleCalculator{
    int counter;
    
    constructor() public{
        counter = 0;
    }
    
    function increament() public {
        counter += 1;
    }
    
    // not common in practical world but you can put a "fee" to call the function
    // function increament() payable public {
   //      require(msg.value > 0.1 ether);
    //      counter += 1;
    // }
    
    function decreament() public {
        counter -= 1;
    }
    
    // this func is just for example, and can be easily avoid by making the variable "counter" public
    //     1. solidity automatically provides with getter functions for public variables
    //     2. "view" means that the function doesn't modify any state/data in the blockchain.
    function getCounter() view public returns(int){
        return counter;
    }
    
}
pragma solidity 0.5.11;

contract Escrow{
    enum State{AWAITING_PAYMENT, AWAITING_DELIVERY, COMPLETE, REFUNDED}
    
    State public currentState;
    address payable public buyer;
    address payable public seller;
    address payable public arbitor;
    
    modifier buyerOnly(){
        require(msg.sender == buyer || msg.sender == arbitor);
        _;
    }
    modifier sellerOnly(){
        require(msg.sender == seller || msg.sender == arbitor);
        _;
    }
    modifier inState(State expectedState){
        require(currentState == expectedState);
        _;
    }
    constructor(address payable _buyer, address payable _seller, address payable _arbitor) public {
        buyer = _buyer;
        seller = _seller;
        arbitor = _arbitor;
    }
    function sendPayment() public payable buyerOnly inState(State.AWAITING_PAYMENT){
         currentState == State.AWAITING_DELIVERY;
    }
    function confirmDelivery() public payable buyerOnly inState(State.AWAITING_DELIVERY){
        seller.transfer(address(this).balance);
        currentState == State.COMPLETE;
    }
    function refundPayment() public payable sellerOnly inState(State.COMPLETE){
        buyer.transfer(address(this).balance);
        currentState == State.REFUNDED;
    }
}
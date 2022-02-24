//SPDX -License-Identifier : GPL-3.0
//AdarshChauarasia
pragma solidity >=0.5.0<0.9.0;

contract Lottery{
address payable public manager; //Manager Public 
address payable[] public participants;  // ParticipantsArray

constructor (){
    manager=payable(msg.sender); //Global Variable

}
//Receive is a type function which executes only once
receive()external payable{
require(msg.value==1 ether);
    participants.push(payable(msg.sender));
}

function getBalance() public view returns(uint){
    require(msg.sender==manager);
    return address(this).balance;
}

function random() public view returns(uint){
    return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));
}
function selectWinner() public{
    require(msg.sender==manager);
    require(participants.length>=3);
    uint r=random();
    address payable winner;
    uint index= r % participants.length;
    winner=participants[index];
    uint winningamount=getBalance()-0.5 ether;
    winner.transfer(winningamount);
    manager.transfer(getBalance());
    participants = new address payable[](0);
}
}

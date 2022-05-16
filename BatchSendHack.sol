pragma solidity 0.4.10;

contract Overflow{

    mapping (address => uint) balances;

    function contribute() payable{
        // 1 to 1 realationship(1 wei = 1 token)
        balances[msg.sender] = msg.value;
    }

    function getBalance() constant returns (uint){
        return balances[msg.sender];
    }

//["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
// "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"],
//0x8000000000000000000000000000000000000000000000000000000000000000
    function batchSend(address[] _receivers, uint _value){
        // this line overflows
        uint total = _receivers.length * _value;
        //this check will pass and will fail to capture the error
        require(balances[msg.sender] >= total);

        //subtract from sender
        balances[msg.sender] = balances[msg.sender] - total;
        //transfer tokens to recipient
        for(uint i = 0; i < _receivers.length; i++){
            balances[_receivers[i]] += _value;
        }
    }
}

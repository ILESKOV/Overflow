pragma solidity ^0.4.10;

import "./SafeMath.sol";

contract Overflow{

    mapping (address=>uint) balances;

    function contribute() payable{
        balances[msg.sender] = msg.value;
    }

    function getBalance() constant returns (uint){
        return balances[msg.sender];
    }

    function batchSend(address[] _receivers, uint _value){
        // this line overflows
        uint total = SafeMath.mul(_receivers.length, _value);
        require(balances[msg.sender]>=total);

        // subtract from sender
        balances[msg.sender] = SafeMath.sub(balances[msg.sender], total);

        for(uint i=0;i<_receivers.length;i++){
            balances[_receivers[i]] = SafeMath.add(balances[_receivers[i]], _value);
        }
    }

}






pragma solidity ^0.4.10;

library SafeMath {

  function mul(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a * b;
    assert(a == 0 || c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal constant returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    //assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal constant returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal constant returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

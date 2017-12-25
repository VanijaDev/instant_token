pragma solidity ^0.4.17;

import "./BasicToken.sol";
import "./ERC20.sol";

contract StandardToken is BasicToken, ERC20 {
  mapping (address => mapping (address => uint)) allowed;

  function transferFrom(address _from, address _to, uint _value) public onlyPayloadWithSize(3 * 32) {
    var _allowance = allowed[_from][msg.sender];
    require (_value <= _allowance);
    balances[_to] = balances[_to].add(_value);
    balances[_from] = balances[_from].sub(_value);
    allowed[_from][msg.sender] = _allowance.sub(_value);
    Transfer(_from, _to, _value);
  }
}
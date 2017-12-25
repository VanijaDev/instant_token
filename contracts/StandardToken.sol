pragma solidity ^0.4.17;

import "./BasicToken.sol";
import "./ERC20.sol";

contract StandardToken is BasicToken, ERC20 {
  mapping (address => mapping (address => uint)) allowed;

  function transferFrom(address _from, address _to, uint _value) public onlyPayloadWithSize(3 * 32) {
    var _allowance = allowed[_from][msg.sender];
//  no need in check _to & _value, because sub() handles it already.
    balances[_to] = balances[_to].add(_value);
    balances[_from] = balances[_from].sub(_value);
    allowed[_from][msg.sender] = _allowance.sub(_value);
    Transfer(_from, _to, _value);
  }

  function approve(address _spender, uint _value) public {
    //  To update value, user needs firstly to set to 0 for sprender.
    if ((_value != 0) && (allowed[msg.sender][_spender] != 0)) {
      revert();
    }
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
  }

  function allowance(address _owner, address _spender) public constant returns (uint remaining) {
    return allowed[_owner][_spender];
  }
}
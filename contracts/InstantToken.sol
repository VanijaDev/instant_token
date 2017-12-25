pragma solidity ^0.4.17;

import "./StandardToken.sol";
import "./Ownable.sol";

contract InstantToken is StandardToken, Ownable {
  string public name = "SkinCoin";
  string public symbol = "SKIN";
  uint public decimals = 18;


  // Constructor
  function InstantToken() public {
      totalSupply = 1000000000000000;
      balances[msg.sender] = totalSupply; // owner ownes all supply 
  }

  /**
   *  Burn amount of tokens
   */
  function burn(uint _value) public onlyOwner returns (bool) {
    balances[msg.sender] = balances[msg.sender].sub(_value);
    totalSupply = totalSupply.sub(_value);

    Transfer(msg.sender, 0x0, _value);
    return true;
  }

}
pragma solidity ^0.4.19;

import "@gnosis.pm/gnosis-core-contracts/contracts/Tokens/StandardToken.sol";


contract TokenOMG is StandardToken {
    string public constant symbol = "OMG";
    string public constant name = "OMG Test Token";
    uint8 public constant decimals = 18;

    function TokenOMG(
        uint amount
    )
        public
    {
        balances[msg.sender] = amount;
    }
}

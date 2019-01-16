pragma solidity ^0.5.2;

import "../interfaces/PriceOracleInterface.sol";
import "./AuctioneerManaged.sol";
import "./DxMath.sol";


contract EthOracle is AuctioneerManaged, DxMath {
    uint constant WAITING_PERIOD_CHANGE_ORACLE = 30 days;

    // Price Oracle interface
    PriceOracleInterface public ethUSDOracle;
    // Price Oracle interface proposals during update process
    PriceOracleInterface public newProposalEthUSDOracle;

    uint public oracleInterfaceCountdown;

    event NewOracleProposal(PriceOracleInterface priceOracleInterface);

    function initiateEthUsdOracleUpdate(PriceOracleInterface _ethUSDOracle) public onlyAuctioneer {
        require(address(_ethUSDOracle) != address(0), "The oracle address must be valid");
        newProposalEthUSDOracle = _ethUSDOracle;
        oracleInterfaceCountdown = add(block.timestamp, WAITING_PERIOD_CHANGE_ORACLE);
        emit NewOracleProposal(_ethUSDOracle);
    }

    function updateEthUSDOracle() public {
        require(address(newProposalEthUSDOracle) != address(0), "The new proposal must be a valid addres");
        require(
            oracleInterfaceCountdown < block.timestamp,
            "It's not possible to update the oracle during the waiting period"
        );
        ethUSDOracle = newProposalEthUSDOracle;
        newProposalEthUSDOracle = PriceOracleInterface(0);
    }
}

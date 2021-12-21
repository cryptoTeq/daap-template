pragma solidity >0.8.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/BetGaming.sol";

contract TestBetGaming {
    BetGaming _contract;
    uint256 public initialBalance = 10 ether;

    function beforeAll() public {
        _contract = new BetGaming();
    }

    function testCheckSuccess() public {
        uint256 _userGuess = 2;
        (uint256 uGuess, , ) = _contract.newGame(_userGuess);
        Assert.equal(uGuess, _userGuess, "***All good man");
    }
}

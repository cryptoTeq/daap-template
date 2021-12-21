// SPDX-License-Identifier: GPL-3.0
pragma solidity >0.8.0;

contract BetGaming {
    address public admin;
    enum GameStatus {
        Pending,
        UserWon,
        ContractWon,
        Even
    }
    event GameEnded(address player, uint256 prize, GameStatus status);

    constructor() {
        admin = msg.sender;
    }

    struct Game {
        uint256 opponentGuess;
        uint256 contractGuess;
        GameStatus status;
        // uint wins;
        // uint losses;
    }

    mapping(address => Game[]) public games;

    modifier hasBalance() {
        require(
            msg.sender.balance > msg.value,
            "{code: 1, message: 'Insufficient Fund'}"
        );
        _;
    }

    function guess() private view returns (uint256) {
        return (block.timestamp % 10);
    }

    function newGame(uint256 _oGuess)
        public
        payable
        hasBalance
        returns (
            uint256 usersGuess,
            uint256 contractGuess,
            GameStatus result
        )
    {
        uint256 _contractGuess = guess();
        GameStatus status = GameStatus.Pending;
        uint256 prize = 0;

        if (_oGuess > _contractGuess) {
            // user won
            status = GameStatus.UserWon;
            prize = msg.value * 2;
            address payable rec = payable(msg.sender);
            rec.transfer(prize);
        } else if (_oGuess == _contractGuess) {
            // even
            status = GameStatus.Even;
            prize = msg.value;
        } else {
            // contract won
            status = GameStatus.ContractWon;
        }

        Game memory _game = Game(_oGuess, _contractGuess, status);
        // games[msg.sender].push(_game);
        emit GameEnded(msg.sender, prize, status);
        return toTupple(_game);
    }

    function toTupple(Game memory game)
        private
        pure
        returns (
            uint256 usersGuess,
            uint256 contractGuess,
            GameStatus result
        )
    {
        {
            usersGuess = game.opponentGuess;
            contractGuess = game.contractGuess;
            result = game.status;
        }
    }
}

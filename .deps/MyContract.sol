// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import "hardhat/console.sol";

contract MyContract {
    uint256 number;

    function setNumber(uint256 _number) public {
        number = _number;
    }

    function getNumber() public view returns (uint256) {
        return number;
    }

    function getFixedNumber() private pure returns (uint256) {
        return 9;
    }

    function getFixedNumberInternal() internal pure returns (uint256) {
        return 7;
    }

    function payMeBackLess() external payable {
        console.log("msg.value", msg.value);
        require(msg.value >= 1 ether, "Must send at least 1 ETH");

        uint256 fixedNumber = getFixedNumber();
        uint256 ethRefund = msg.value / fixedNumber;
        payable(msg.sender).transfer(ethRefund);
    }

}

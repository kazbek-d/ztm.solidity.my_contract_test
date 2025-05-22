// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import "hardhat/console.sol";

contract Ex_01_Solidity_Fundamentals {
    function ExternalPayable(uint256 amount) external payable {
        console.log("msg.value", msg.value);
        console.log("amount", amount);

        if (amount == 9) {
            revert("We don't like 9");
        }

        uint256 payBack = (amount % 2 == 0) ? msg.value / 2 : msg.value;
        console.log("Transferring back", payBack);
        payable(msg.sender).transfer(payBack);
    }
}

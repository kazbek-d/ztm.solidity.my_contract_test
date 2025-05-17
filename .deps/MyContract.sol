// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract MyContract {
    uint number;

    function setNumber(uint _number) public {
        number = _number;
    }

    function getNumber() view public returns (uint) {
        return number;
    }
}
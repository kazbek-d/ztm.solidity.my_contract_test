// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import "hardhat/console.sol";

contract Erc20Token {
    string public constant name = "Erc20Token";
    string public constant symbol = "ERC20";
    uint8 public constant decimals = 18;
    uint256 internal _totalSupply = 1e17;
    mapping(address => uint256) public balancesOf;

    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(balancesOf[msg.sender] >= amount, "Not enough funds");
        balancesOf[msg.sender] -= amount;
        balancesOf[recipient] += amount;
        return true;
    }
}

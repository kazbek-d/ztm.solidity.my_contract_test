// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import "hardhat/console.sol";

contract Erc20Token {

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address spender, uint256 value);

    address public constant feeAddress = address(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);

    string public name; // Erc20Token
    string public symbol; // ERC20
    uint8 immutable public decimals; // 18

    uint256 internal _totalSupply;
    
    mapping(address => uint256) public balancesOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(string memory _name, string memory _symbol, uint8 _decimals) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
    }

    function _transfer(address from, address to, uint256 amount) private returns(bool) {
        require(balancesOf[from] >= amount, "ERC20: Insufficient sender balance");
        
        uint256 fee = amount / 100;

        emit Transfer(from, to, amount - fee);
        emit Transfer(from, feeAddress, fee);

        balancesOf[from] -= amount;
        balancesOf[to] += amount - fee;
        balancesOf[feeAddress] += fee;

        return true;
    }

    function transfer(address recipient, uint256 amount) external returns (bool) {
        return _transfer(msg.sender, recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns(bool) {
        require(allowance[sender][msg.sender] >= amount, "ERC20: Insufficient allowance");
        allowance[sender][msg.sender] -= amount;
        emit Approval(sender, msg.sender, allowance[sender][msg.sender]);
        return _transfer(sender, recipient, amount);
    }

    function approve (address spender, uint256 amount) external returns (bool){
        allowance[msg.sender][spender] += amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    } 

    function giveMeOneToken() public {
        balancesOf[msg.sender]+= 1e18;
    }
}

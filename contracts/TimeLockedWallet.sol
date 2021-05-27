// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TimeLockedWallet {
    address owner;
    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    receive() payable external {}
    function withdraw() onlyOwner public {
        payable(owner).transfer(address(this).balance);
    }
}
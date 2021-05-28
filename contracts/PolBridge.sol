// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './FakeUsdc.sol';

contract PolBridge {
    uint _reservation;
    FakeUsdc usdc = new FakeUsdc();
    function calc_fee(uint _amount) public pure returns (uint) {
        return (_amount * 4 / 10000) * 10 ** 6;
    }
    function deposit(uint _amount) public returns(bool) {
        usdc.transfer(address(this), _amount);
        return true;
    }

    function withdraw(uint _amount) public returns(bool) {
        usdc.safeTransfer(address(this), msg.sender, (_amount + calc_fee(_amount)));
        return true;
    }
}
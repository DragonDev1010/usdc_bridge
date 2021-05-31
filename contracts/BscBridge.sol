// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './FakeUsdc.sol';

contract BscBridge {
    uint _reservation;
    FakeUsdc usdc = new FakeUsdc();
    event Deposited (address _depositer, uint _amount);
    event Withdrawed (address _withdrawer, uint _amount);
    event Reserved (uint _balance);

    event TestEvent(address a, uint b);
    function test() public payable {
        (address sender, uint balance) = usdc.test();
        emit TestEvent(sender, balance);
    }

    function calc_fee(uint _amount) public pure returns (uint) {
        return (_amount * 10 ** 6 * 4 / 10000);
    }

    function deposit(uint _amount) public returns(bool) {
        // usdc.transfer(address(this), _amount);
        usdc.safeTransfer(msg.sender, address(this), _amount);

        emit Deposited(msg.sender, _amount);
        return true;
    }

    function withdraw(uint _amount) public returns(bool) {
        usdc.safeTransfer(address(this), msg.sender, (_amount + calc_fee(_amount)));
        return true;
    }

    function set_reservation (uint _amount) public returns (bool) {
        usdc.transfer(address(this), _amount);
        _reservation += _amount;
        emit Reserved( _reservation);
        return true;
    }

    function get_reservation () public view returns (uint) {
        return _reservation;
    }
}
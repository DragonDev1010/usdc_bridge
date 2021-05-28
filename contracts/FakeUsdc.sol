// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FakeUsdc {
    uint _total;
    mapping(address => uint) _balance;

    event Sold(address _receiver, uint _balance);
    event Transfered(address _from, uint from_balance, address _to, uint to_balance);
    event SafeTransfered(address _from, uint from_balance, address _to, uint to_balance);
    constructor() {
        _total = 100000;
        _balance[address(0)] = _total;
    }
    function sell(uint _amount) public returns (address) {
        _balance[address(0)] -= _amount;
        _balance[msg.sender] += _amount;
        emit Sold(msg.sender, _balance[msg.sender]);
        return msg.sender;
    }
    function transfer(address _to, uint _amount) public returns(bool) {
        _balance[msg.sender] -= _amount;
        _balance[_to] += _amount;
        emit Transfered(msg.sender, _balance[msg.sender], _to, _balance[_to]);
        return true;
    }
    function safeTransfer (address _from, address _to, uint _amount) public returns (bool) {
        _balance[_from] -= _amount;
        _balance[_to] += _amount;
        emit SafeTransfered(_from, _balance[_from], _to, _balance[_to]);
        return true;
    }
    function balanceOf(address _addr) public view returns(uint) {
        return _balance[_addr];
    }
}
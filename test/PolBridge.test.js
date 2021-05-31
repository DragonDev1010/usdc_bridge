require('chai')
    .use(require('chai-as-promised'))
    .should()

const {assert} = require('chai')    

const PolBridge = artifacts.require('./PolBridge.sol')
const FakeUsdc = artifacts.require('./FakeUsdc.sol')

contract('PolBridge', (accounts) => {
    let pol, usdc, res
    let balance_0, balance_1, balance_2, balance_pol
    before(async() => {
        pol = await PolBridge.deployed()
        usdc = await FakeUsdc.deployed()
        res = await usdc.sell(2000, {from: accounts[0]})
        res = await usdc.sell(1000, {from: accounts[1]})
        res = await usdc.sell(1000, {from: accounts[2]})
        // res = await usdc.sell(1000, {from: pol.address})
        res = await usdc.transfer(pol.address, 1000, {from: accounts[0]})
    })
    describe('deployment', async() => {
        it('happy test', async() => {
            res = await pol.test()
            console.log(res.logs[0].args)
            console.log('pol address', pol.address)
            console.log('usdc address', usdc.address)
            balance_pol = await usdc.balanceOf(pol.address)
            console.log('pol balance', balance_pol)
        })
    })
})
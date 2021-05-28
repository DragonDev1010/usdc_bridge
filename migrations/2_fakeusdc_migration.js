const FakeUsdc = artifacts.require("FakeUsdc");

module.exports = function (deployer) {
  deployer.deploy(FakeUsdc);
};
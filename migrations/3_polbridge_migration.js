const PolBridge = artifacts.require("PolBridge");

module.exports = function (deployer) {
  deployer.deploy(PolBridge);
};
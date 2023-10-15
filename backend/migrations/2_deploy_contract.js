const WolfOwnership = artifacts.require("WolfOwnership");

module.exports = function(deployer) {
  deployer.deploy(WolfOwnership)
};

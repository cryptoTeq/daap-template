const SimpleStorage = artifacts.require("./SimpleStorage.sol");
const BetGaming = artifacts.require("./BetGaming.sol");

module.exports = function (deployer) {
  deployer.deploy(SimpleStorage);
  deployer.deploy(BetGaming);
};

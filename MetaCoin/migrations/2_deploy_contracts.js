// File: 2_deploy_contracts.js

const RAGStorage = artifacts.require("RAGStorage");

module.exports = function (deployer) {
    deployer.deploy(RAGStorage);
};

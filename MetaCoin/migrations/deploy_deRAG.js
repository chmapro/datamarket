// deploy_deRAG.js
const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with account:", deployer.address);

  const DataContract = await ethers.getContractFactory("DataContract");
  const dataContract = await DataContract.deploy();
  console.log("DataContract deployed to:", dataContract.address);

  const NodeManager = await ethers.getContractFactory("NodeManager");
  const nodeManager = await NodeManager.deploy();
  console.log("NodeManager deployed to:", nodeManager.address);

  const Reputation = await ethers.getContractFactory("Reputation");
  const reputation = await Reputation.deploy();
  console.log("Reputation deployed to:", reputation.address);

  const Incentive = await ethers.getContractFactory("Incentive");
  const incentive = await Incentive.deploy();
  console.log("Incentive deployed to:", incentive.address);

  const AccessControl = await ethers.getContractFactory("AccessControl");
  const accessControl = await AccessControl.deploy();
  console.log("AccessControl deployed to:", accessControl.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
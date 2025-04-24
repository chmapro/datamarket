const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("DataContract Tests", function () {
  let dataContract;

  beforeEach(async () => {
    const DataContract = await ethers.getContractFactory("DataContract");
    dataContract = await DataContract.deploy();
  });

  it("should store and retrieve data correctly", async function () {
    await dataContract.storeData("0x01", "QmHash", "Sample metadata");
    const data = await dataContract.retrieveData("0x01");
    expect(data.ipfsHash).to.equal("QmHash");
    expect(data.metadata).to.equal("Sample metadata");
  });
});

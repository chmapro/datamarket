contract("Reputation", function () {
    let reputation;
  
    beforeEach(async () => {
      const Reputation = await ethers.getContractFactory("Reputation");
      reputation = await Reputation.deploy();
    });
  
    it("should correctly update and retrieve reputation", async function () {
      await reputation.updateReputation("0x123", true);
      expect(await reputation.getReputation("0x123")).to.equal(1);
    });
  });
  
  // Incentive.test.js
  contract("Incentive", function (accounts) {
    beforeEach(async () => {
      const Incentive = await ethers.getContractFactory("Incentive");
      incentive = await Incentive.deploy();
    });
  
    it("should reward nodes correctly", async function () {
      await incentive.rewardNode("0x123", { value: ethers.utils.parseEther("1") });
      expect(await incentive.rewards("0x123")).to.equal(ethers.utils.parseEther("1"));
    });
  });
  
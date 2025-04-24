// NodeManager.test.js
describe("NodeManager Contract", function () {
    let nodeManager;
  
    beforeEach(async function () {
      const NodeManager = await ethers.getContractFactory("NodeManager");
      nodeManager = await NodeManager.deploy();
    });
  
    it("should register and verify nodes correctly", async function () {
      await nodeManager.registerNode("0x123");
      expect(await nodeManager.isNodeRegistered("0x123")).to.equal(true);
    });
  });
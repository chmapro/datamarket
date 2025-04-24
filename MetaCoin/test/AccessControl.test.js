contract("AccessControl", () => {
    let accessControl;
  
    beforeEach(async () => {
      const AccessControl = await ethers.getContractFactory("AccessControl");
      accessControl = await AccessControl.deploy();
    });
  
    it("should manage access correctly", async function () {
      await accessControl.grantAccess("0x01", "0x123");
      expect(await accessControl.checkAccess("0x01", "0x123")).to.be.true;
      await accessControl.revokeAccess("0x01", "0x123");
      expect(await accessControl.checkAccess("0x01", "0x123")).to.be.false;
    });
  });

  
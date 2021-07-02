const { expect } = require("chai");

describe("Greeter", function() {
  let greeter;

  before(async ()=> {
    const Greeter = await ethers.getContractFactory("Greeter");
    greeter = await Greeter.deploy("Hello, world!");
    await greeter.deployed();
  })

  it("Should return 'Hello World'", async function() {
    expect(await greeter.greet()).to.equal("Hello, world!");
  })
  
  it("Should return the new greeting once it's changed", async function() {
    const setGreetingTx = await greeter.setGreeting("Hola, mundo!");
    
    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});

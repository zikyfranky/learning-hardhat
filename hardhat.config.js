require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-web3");
const hre = require("hardhat/config")

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

task("balance", "Returns address' native balance")
.addParam("address", "User address")
.setAction(
  async({address})=>{
    const _address = web3.utils.toChecksumAddress(address)
    const _balance = await web3.eth.getBalance(_address)
    const _displayableBalance = web3.utils.fromWei(_balance)
    console.log(`Balance:: ${_displayableBalance} ETH`);
  }
)

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
};


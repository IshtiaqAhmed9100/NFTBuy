const { ethers } = require("hardhat");
const { run } = require("hardhat");
async function verify(address, constructorArguments) {
    console.log(`verify  ${address} with arguments ${constructorArguments.join(',')}`)
    await run("verify:verify", {
        address,
        constructorArguments
    })
}
async function main() {
  let owner =  '0x12eF0F1C99D8FD50fFd37cCd12B09Ef7f1213269';
   
//   const NFTBuy = await ethers.deployContract( 'NFTBuy' , [owner]);

//     console.log("Deploying NFTBuy...");
//     await NFTBuy.waitForDeployment()

//     console.log("NFTBuy deployed to:", NFTBuy.target);

//     await new Promise(resolve => setTimeout(resolve, 10000));
    verify('0xA16eE1eF12Eb27d70340F5469E3560bD54c60BeD', [owner])
}
main()
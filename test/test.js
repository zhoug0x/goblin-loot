const { before } = require('mocha');
const { expect } = require('chai');
const { ethers } = require('hardhat');

const CONTRACT_NAME = 'GoblinLoot';

describe('Contract Test', () => {
	let contract, owner, nonOwner;

	// --------------------------------------------------------------------- setup
	before(async () => {
		// Get test wallets
		[owner, nonOwner] = await ethers.getSigners();

		// Deploy contract
		console.info(`\n🚧 deploying ${CONTRACT_NAME} contract...`);
		const contractFactory = await hre.ethers.getContractFactory(CONTRACT_NAME);
		contract = await contractFactory.deploy();
		console.log(
			`✔️ contract deployed!\n⛽ gas price: ${contract.deployTransaction.gasPrice}\n\n`
		);
	});

	// --------------------------------------------------------------------- tests

	

	// it('Should deploy with correct owner', async () => {
	// 	expect(await contract.owner()).to.equal(owner.address);
	// });

	// it('Should not update owner from unauthorized address', async () => {
	// 	await expect(contract.connect(nonOwner).setOwner(nonOwner.address)).to.be
	// 		.reverted;
	// });


});

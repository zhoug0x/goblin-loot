const { before } = require('mocha');
const { expect } = require('chai');
const { ethers } = require('hardhat');

const CONTRACT_NAME = 'GoblinLoot';

describe('Contract Test', () => {
	let contract, deployer;

	// --------------------------------------------------------------------- setup
	before(async () => {
		// Get test wallet
		[deployer] = await ethers.getSigners();

		// Deploy contract
		console.info(`\n🚧 deploying ${CONTRACT_NAME} contract...`);
		const contractFactory = await hre.ethers.getContractFactory(CONTRACT_NAME);
		contract = await contractFactory.deploy();
		console.log(
			`✔️ contract deployed!\n⛽ gas price: ${contract.deployTransaction.gasPrice}\n\n`
		);
	});

	// --------------------------------------------------------------------- tests

	it('Should batch mint on deployment', async () => {
		const userBalance = await contract.balanceOf(deployer.address);
		expect(userBalance.toNumber()).to.be.gt(0);
	});

	it('Should mint a loot sack', async () => {
		const userBalanceBefore = await contract.balanceOf(deployer.address);

		await expect(await contract.connect(deployer).mint())
			.to.emit(contract, 'Transfer')
			.withArgs(
				ethers.constants.AddressZero,
				deployer.address,
				await contract.totalSupply()
			);

		const userBalanceAfter = await contract.balanceOf(deployer.address);

		expect(userBalanceAfter.toNumber()).to.equal(
			userBalanceBefore.toNumber() + 1
		);
	});
});

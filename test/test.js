const { before } = require('mocha');
const { expect } = require('chai');
const { ethers } = require('hardhat');

const CONTRACT_NAME = 'GoblinLoot';

describe('Contract Test', () => {
	let contract, deployer, rando;

	// --------------------------------------------------------------------- setup
	before(async () => {
		// Get test wallet
		[deployer, rando] = await ethers.getSigners();

		// Deploy contract
		console.info(`\n🚧 deploying ${CONTRACT_NAME} contract...`);
		const contractFactory = await hre.ethers.getContractFactory(CONTRACT_NAME);
		contract = await contractFactory.deploy();
		console.log(
			`✔️ contract deployed!\n⛽ gas price: ${contract.deployTransaction.gasPrice}\n\n`
		);
	});

	// --------------------------------------------------------------------- tests
	it('Should fetch mint closing time', async () => {
		const closingTime = await contract.mintClosingTime();
		console.log({closes: closingTime.toNumber(), timeNow: Date.now()})
	});

	it('Should fetch sack URI', async () => {
		const totalSupply = await contract.totalSupply();
		await expect(contract.tokenURI(totalSupply.toNumber())).to.not.be.reverted;
	});

	it('Should revert if fetching non-existant sack URI', async () => {
		const totalSupply = await contract.totalSupply();
		await expect(contract.tokenURI(totalSupply.toNumber() + 1)).to.be.reverted;
	});

	it('Should batch mint on deployment', async () => {
		const userBalance = await contract.balanceOf(deployer.address);
		const totalSupply = await contract.totalSupply();
		expect(userBalance).to.be.eq(totalSupply);
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

	it('Should revert if burning unauthorized loot', async () => {
		await expect(contract.connect(rando).burn(1)).to.be.reverted;
	});

	it('Should burn a loot sack', async () => {
		await expect(contract.ownerOf(1)).to.not.be.reverted;
		await expect(contract.burn(1)).to.not.be.reverted;
		await expect(contract.ownerOf(1)).to.be.reverted;
	});

	it('Should burn a loot sack with approved address', async () => {
		contract.setApprovalForAll(rando.address, true);
		await expect(contract.connect(deployer).ownerOf(2)).to.not.be.reverted;
		await expect(contract.connect(deployer).burn(2)).to.not.be.reverted;
		await expect(contract.connect(deployer).ownerOf(2)).to.be.reverted;
	});
});

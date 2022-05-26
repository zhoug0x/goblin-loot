const { before } = require('mocha');
const { expect, assert } = require('chai');
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
	it('Should activate mint on deployment', async () => {
		expect(await contract.mintIsActive()).to.eq(true);
	});

	it('Should have mint closing time set', async () => {
		const currentTime = hre.ethers.BigNumber.from(
			Date.now().toString().slice(0, 10)
		);
		const closingTime = await contract.mintClosingTime();

		expect(closingTime).to.not.eq(0);
		expect(closingTime).to.be.gt(currentTime);
	});

	it('Should fetch sack URI', async () => {
		const totalSupply = await contract.totalSupply();
		await expect(contract.tokenURI(totalSupply.toNumber())).to.not.be.reverted;
	});

	it('Should revert if fetching non-existent sack URI', async () => {
		const totalSupply = await contract.totalSupply();
		await expect(contract.tokenURI(totalSupply.toNumber() + 1)).to.be.reverted;
	});

	it('Should mint a loot sack', async () => {
		const userBalanceBefore = await contract.balanceOf(deployer.address);

		await expect(await contract.connect(deployer).mint())
			.to.emit(contract, 'Transfer')
			.withArgs(
				hre.ethers.constants.AddressZero,
				deployer.address,
				await contract.totalSupply()
			);

		const userBalanceAfter = await contract.balanceOf(deployer.address);

		expect(userBalanceAfter.toNumber()).to.equal(
			userBalanceBefore.toNumber() + 1
		);
	});

	it('Should revert tip mint if no tip sent', async () => {
		await expect(contract.connect(rando).mintThreeWithATip()).to.be.reverted;
	});

	it('Should batch tip mint', async () => {
		await expect(
			await contract
				.connect(rando)
				.mintThreeWithATip({ value: hre.ethers.utils.parseEther('100') })
		)
			.to.emit(contract, 'Transfer')
			.withArgs(
				hre.ethers.constants.AddressZero,
				rando.address,
				await contract.totalSupply()
			);

		const contractBalance = await hre.ethers.provider.getBalance(
			contract.address
		);

		expect(contractBalance).to.equal(hre.ethers.utils.parseEther('100'));
	});

	it('Should not withdraw tips to an unauthorized address', async () => {
		await expect(contract.connect(rando).withdrawTips()).to.be.reverted;
	});

	it('Should withdraw tips to tip withdrawer address', async () => {
		const withdrawAddress = await contract.tipWithdrawer();
		const walletBalBefore = await hre.ethers.provider.getBalance(
			withdrawAddress
		);

		await contract.withdrawTips();
		const contractBalAfter = await hre.ethers.provider.getBalance(
			contract.address
		);
		const walletBalAfter = await hre.ethers.provider.getBalance(
			withdrawAddress
		);

		expect(contractBalAfter).to.equal(0);
		assert(
			walletBalAfter.gt(walletBalBefore),
			'Withdrawal wallet did not increase in balance after withdrawal'
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
}); // END

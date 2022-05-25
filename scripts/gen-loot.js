const hre = require('hardhat');
const { parse } = require('svgson');

const CONTRACT_NAME = 'GoblinLoot';

async function main() {
	[deployer] = await hre.ethers.getSigners();

	const contractFactory = await hre.ethers.getContractFactory(CONTRACT_NAME);
	const contract = await contractFactory.deploy();
	await contract.deployed();
	const deployerBalance = await contract.balanceOf(deployer.address);
	console.log('Contract deployed to: ', contract.address);
	console.log('Deployer wallet balance: ', deployerBalance.toNumber());

	// fetch & parse minted loots in deployer wallet
	const lootList = [];
	for (let i = 0; i < deployerBalance.toNumber(); i++) {
		const uri = await contract.tokenURI(i + 1);
		const jsonBytes = hre.ethers.utils.base64.decode(uri.split(',')[1]);
		const json = hre.ethers.utils.toUtf8String(jsonBytes);
		const obj = JSON.parse(json);
		const imgBytes = hre.ethers.utils.base64.decode(obj.image.split(',')[1]);
		const svg = hre.ethers.utils.toUtf8String(imgBytes);
		const svgJson = await parse(svg);
		const nodes = svgJson.children.map(x => x.children).slice(2);
		const output = nodes.map(x => x[0].value);
		lootList.push(output);
	}

	console.log(lootList);
}

main()
	.then(() => process.exit(0))
	.catch(error => {
		console.error(error);
		process.exit(1);
	});

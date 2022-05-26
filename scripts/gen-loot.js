const hre = require('hardhat');
const { parse } = require('svgson');

const CONTRACT_NAME = 'GoblinLoot';

async function main() {
	[deployer] = await hre.ethers.getSigners();

	const contractFactory = await hre.ethers.getContractFactory(CONTRACT_NAME);
	const contract = await contractFactory.deploy();
	await contract.deployed();
	const deployerBalance = await contract.balanceOf(deployer.address);

	// fetch & parse minted loots in deployer wallet
	const jsonList = [];
	const objList = [];
	const lootList = [];


	for (let i = 0; i < deployerBalance.toNumber(); i++) {
		const uri = await contract.tokenURI(i + 1);
		const jsonBytes = hre.ethers.utils.base64.decode(uri.split(',')[1]);

		const json = hre.ethers.utils.toUtf8String(jsonBytes);
		jsonList.push(json);

		// DEBUG JSON METADATA OUTPUT HERE
		// console.log(json)
		// return
		// ------
		
		const obj = JSON.parse(json);
		objList.push(obj);

		// DEBUG PARSED OBJECT HERE
		// console.log(obj)
		// return
		// ------

		const imgBase64 = obj.image.split(',')[1];
		const imgBytes = hre.ethers.utils.base64.decode(imgBase64);
		const svg = hre.ethers.utils.toUtf8String(imgBytes);
		const svgJson = await parse(svg);
		const nodes = svgJson.children.map(x => x.children).slice(2);
		const output = nodes.map(x => x[0].value);
		lootList.push(output);
	}

	console.log(jsonList);
	// console.log(objList);
	// console.log(lootList);
}

main()
	.then(() => process.exit(0))
	.catch(error => {
		console.error(error);
		process.exit(1);
	});

const hre = require('hardhat');

// The address of the deployed contract requiring verification
const CONTRACT_ADDRESS = '';

async function main() {
	if (!CONTRACT_ADDRESS) {
		throw new Error('Missing contract address for verification');
	}
	await hre.run('verify:verify', { address: CONTRACT_ADDRESS });
}

main()
	.then(() => process.exit(0))
	.catch(error => {
		console.error(error);
		process.exit(1);
	});

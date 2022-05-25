require('@nomiclabs/hardhat-waffle');
require('@nomiclabs/hardhat-etherscan');
require('hardhat-gas-reporter');
require('dotenv').config();

// --- settings ---
const COMPILER_VERSION = '0.8.13';
const OPTIMIZATION_RUNS = 500; // leave as 0 to disable optimization
const LOCALHOST_CHAIN_ID = 31337; // local blockchain instance chain ID (default is Metamask)
const REPORT_GAS = true;
const GAS_PRICE = 35; // set custom gas price in gwei, leave null to fetch market price
// ----------------

const API_KEY_ETHERSCAN = process.env.API_KEY_ETHERSCAN || null;
const API_KEY_COINMARKETCAP = process.env.API_KEY_COINMARKETCAP || null;
const PRIVATE_KEY_RINKEBY = process.env.PRIVATE_KEY_RINKEBY || null;
const PRIVATE_KEY_MAINNET = process.env.PRIVATE_KEY_MAINNET || null;
const NODE_URL_RINKEBY = process.env.NODE_URL_RINKEBY || null;
const NODE_URL_MAINNET = process.env.NODE_URL_MAINNET || null;

task('accounts', 'Prints the list of accounts', async (taskArgs, hre) => {
	const accounts = await hre.ethers.getSigners();
	for (const account of accounts) {
		console.log(account.address);
	}
});

let config = {
	solidity: {
		version: COMPILER_VERSION,
		settings: {
			optimizer: {
				enabled: OPTIMIZATION_RUNS > 0,
				runs: OPTIMIZATION_RUNS,
			},
		},
	},
	paths: {
		artifacts: './artifacts',
	},
	networks: {
		hardhat: {
			chainId: LOCALHOST_CHAIN_ID,
		},
	},
	defaultNetwork: 'hardhat',
};

if (API_KEY_ETHERSCAN) {
	config = {
		...config,
		etherscan: {
			apiKey: API_KEY_ETHERSCAN,
		},
	};
}

if (API_KEY_COINMARKETCAP) {
	config = {
		...config,
		gasReporter: {
			enabled: REPORT_GAS,
			coinmarketcap: API_KEY_COINMARKETCAP,
			currency: 'USD',
			gasPrice: GAS_PRICE,
		},
	};
}

if (PRIVATE_KEY_RINKEBY && NODE_URL_RINKEBY) {
	config = {
		...config,
		networks: {
			...config.networks,
			rinkeby: {
				url: NODE_URL_RINKEBY,
				accounts: [`0x${PRIVATE_KEY_RINKEBY}`],
			},
		},
	};
}

if (PRIVATE_KEY_MAINNET && NODE_URL_MAINNET) {
	config = {
		...config,
		networks: {
			...config.networks,
			mainnet: {
				url: NODE_URL_MAINNET,
				accounts: [`0x${PRIVATE_KEY_MAINNET}`],
			},
		},
	};
}

module.exports = { ...config };

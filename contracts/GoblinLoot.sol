//SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;

// xxx GOBLIN LOOT xxx

// TODO: !!! ctrl+F all the TODOs before deployment... !!!

// TODO: ascii art

import '@rari-capital/solmate/src/tokens/ERC721.sol';
import '@openzeppelin/contracts/security/ReentrancyGuard.sol';
import '@openzeppelin/contracts/utils/Strings.sol';
import '@openzeppelin/contracts/utils/Base64.sol';

contract GoblinLoot is ERC721, ReentrancyGuard {
	using Strings for uint256;

	uint256 public constant MAX_SUPPLY = 10000;
	uint256 public totalSupply;
	bool public mintIsActive;

	ERC721 internal goblintown =
		ERC721(0xbCe3781ae7Ca1a5e050Bd9C4c77369867eBc307e);

	// TODO: add 24h timer to disable mint (mint function has an auto switch, extend it to switch timer as well)

	// TODO: add creator addies

	// -------------------------------------------------------------------------------------------------- items
	string[] private weapons = [
		'club',
		'scythe',
		'sickle',
		'longspear',
		'shortspear',
		'quarterstaff',
		'sling',
		'slingshot',
		'short bow',
		'mace',
		'dagger',
		'totem',
		'wand',
		'pickaxe',
		'hatchet',
		'knife-on-a-stick',
		'splitting axe',
		'banner'
	];

	string[] private headGear = [
		'skull cap',
		'hood',
		'helmet',
		'crown',
		'hoop earring',
		'stud earring',
		'earring',
		'war bonnet',
		'kettle hat',
		'pot lid',
		'goggles',
		'monocle',
		'eyepatch'
	];

	string[] private bodyGear = [
		'husk',
		'cloak',
		'pauldrons',
		'loincloth',
		'robe',
		'rags',
		'harness',
		'tunic',
		'wrappings',
		'cuirass',
		'half-chest armor',
		'crop-top',
		'sash',
		'sashes',
		'toga',
		'belt',
		'vest',
		'cape'
	];

	string[] private handGear = [
		'hooks',
		'ring set',
		'gloves',
		'bracers',
		'gauntlets',
		'bangles',
		'knuckleguards',
		'bracelets',
		'claws',
		'handwraps',
		'mittens',
		'wristbands',
		'talons'
	];

	string[] private footGear = [
		'sandals',
		'boots',
		'footwraps',
		'greaves',
		'anklets',
		'shackles',
		'booties',
		'socks',
		'shinguards',
		'toe rings',
		'slippers',
		'shoes',
		'clogs'
	];

	string[] private necklaces = ['chain', 'amulet', 'pendant'];

	string[] private rings = [
		'gold ring',
		'silver ring',
		'bronze ring',
		'magic ring',
		'iron ring'
	];

	string[] private trinkets = [
		'potato',
		'jar',
		'tooth',
		'jawbone',
		'pickle',
		'ruby',
		'herb pouch',
		'dandelions',
		'sapphire',
		'diamond',
		'mushroom',
		'emerald',
		'sardines',
		'wineskin',
		'brush',
		'comb',
		'candle',
		'candlestick',
		'torch',
		'scratcher',
		'magnifying glass',
		'seeds',
		'beans',
		'thingamabob',
		'thingamajig',
		'shoehorn',
		'loose nails',
		'dice',
		'skull',
		'blueberries',
		'stein',
		'teapot',
		'egg',
		'meat',
		'scraper',
		'spoon',
		'chalk',
		'charcoal',
		'twigs',
		'sweets',
		'amethyst',
		'obsidian',
		'mallet',
		'pebbles',
		'spyglass',
		'grappling hook',
		'rope',
		'vial',
		'flask',
		'paintbrush',
		'lute',
		'drum',
		'tamborine',
		'bowl',
		'whistle',
		'goo',
		'rose',
		'seaweed',
		'fishing rod',
		'grindstone',
		'feathers',
		'pocketwatch',
		'compass',
		'scroll',
		'whip'
	];

	string[] private heavyMaterials = [
		'bone',
		'stone',
		'bronze',
		'wood',
		'rubber',
		'iron',
		'gold',
		'copper',
		'tin',
		'goblinsteel',
		'scrap',
		'reinforced'
	];

	string[] private lightMaterials = [
		'linen',
		'fur',
		'leather',
		'bark',
		'cotton',
		'cardboard',
		'hide',
		'scrap',
		'burlap',
		'goblinmail',
		'paper',
		'studded leather'
	];

	// -------------------------------------------------------------------------------------------------- prefix/suffix

	string[] private jewelryPrefixes = [
		'crude',
		'flawed',
		'rusty',
		'nice',
		'fine',
		'glowing',
		'tainted',
		'rare',
		'enchanted',
		'stolen'
	];

	string[] private prefixes = [
		'shimmering',
		'shiny',
		'slick',
		'polished',
		'damp',
		'blighty',
		'bloody',
		'thorny',
		'doomed',
		'gloomy',
		'grim',
		'oozy',
		'undead',
		'dead',
		'hairy',
		'mossy',
		'stinky',
		'dusty',
		'charred',
		'spiky',
		'cursed',
		'scaly',
		'ghoulish',
		'crusty',
		'skyborn',
		'damned',
		'briny',
		'dirty',
		'slimy',
		'muddy',
		'lucky',
		"thief's",
		"bandit's",
		"raider's",
		"miner's",
		"builder's"
	];

	string[] private suffixes = [
		'of RRRRRRAAAAAHHH',
		'of power',
		'of sneak',
		'of strike',
		'of smite',
		'of charm',
		'of trade',
		'of anger',
		'of rage',
		'of fury',
		'of ash',
		'of fear',
		'of havoc',
		'of rapture',
		'of terror',
		'of the mountains',
		'of the swamp',
		'of the bog',
		'of the rift',
		'of the sewers',
		'of the woods',
		'of the caves',
		'of the volcano',
		'of the grave'
	];

	// -------------------------------------------------------------------------------------------------- constructor
	constructor() ERC721('GoblinLoot', 'GLOOT') {
		mintIsActive = true;

		// TODO: batch mint reserves to team
		batchMint(msg.sender, 5);
	}

	// -------------------------------------------------------------------------------------------------- error handling
	error MintInactive();
	error NotEnoughLoot();
	error NotAuthorized();
	error NotMinted();

	// -------------------------------------------------------------------------------------------------- writes
	function batchMint(address _recipient, uint256 _amount) internal {
		if (_amount > MAX_SUPPLY - totalSupply) revert NotEnoughLoot();
		unchecked {
			for (uint256 i = 1; i < _amount + 1; ++i) {
				_safeMint(_recipient, totalSupply + i);
			}
			totalSupply += _amount;
		}
	}

	function mint() public nonReentrant {
		if (!mintIsActive) revert MintInactive();
		if (totalSupply == MAX_SUPPLY) revert NotEnoughLoot();

		unchecked {
			++totalSupply;
		}
		_safeMint(msg.sender, totalSupply);

		// if this mint is last of the supply, close mint
		// TODO: add timelock check
		if (totalSupply == MAX_SUPPLY) {
			mintIsActive = false;
		}
	}

	function burn(uint256 _tokenId) public nonReentrant {
		if (
			msg.sender != address(_ownerOf[_tokenId]) ||
			isApprovedForAll[_ownerOf[_tokenId]][msg.sender]
		) revert NotAuthorized();

		_burn(_tokenId);
	}

	// -------------------------------------------------------------------------------------------------- reads
	function random(string memory _input) internal pure returns (uint256) {
		return uint256(keccak256(abi.encodePacked('AUU', _input, 'UUGH')));
	}

	function stringsAreEqual(string memory _a, string memory _b)
		internal
		pure
		returns (bool)
	{
		return (keccak256(abi.encodePacked(_a)) == keccak256(abi.encodePacked(_b)));
	}

	function pluck(
		uint256 _tokenId,
		string memory _keyPrefix,
		string[] memory _sourceArray
	) internal view returns (string memory) {
		uint256 rand = random(
			string(abi.encodePacked(_keyPrefix, Strings.toString(_tokenId)))
		);
		string memory output = _sourceArray[rand % _sourceArray.length];

		// heavy material prefix
		if (
			stringsAreEqual(_keyPrefix, 'WEAPON') ||
			stringsAreEqual(_keyPrefix, 'HEAD') ||
			stringsAreEqual(_keyPrefix, 'HAND')
		) {
			output = string(
				abi.encodePacked(
					heavyMaterials[rand % heavyMaterials.length],
					' ',
					output
				)
			);
		}

		// light material prefix
		if (
			stringsAreEqual(_keyPrefix, 'BODY') || stringsAreEqual(_keyPrefix, 'FOOT')
		) {
			output = string(
				abi.encodePacked(
					lightMaterials[rand % lightMaterials.length],
					' ',
					output
				)
			);
		}

		// jewelry prefix
		if (
			stringsAreEqual(_keyPrefix, 'NECK') || stringsAreEqual(_keyPrefix, 'RING')
		) {
			output = string(
				abi.encodePacked(
					jewelryPrefixes[rand % jewelryPrefixes.length],
					' ',
					output
				)
			);
		}

		uint256 greatness = rand % 21;

		// no prefix/suffix for either trinkets or items less than the greatness floor
		if (
			greatness < 7 ||
			stringsAreEqual(_keyPrefix, 'TRINKET_ONE') ||
			stringsAreEqual(_keyPrefix, 'TRINKET_TWO')
		) {
			return output;
		}

		// both prefix & suffix
		if (greatness > 17) {
			return
				string(
					abi.encodePacked(
						prefixes[rand % prefixes.length],
						' ',
						output,
						' ',
						suffixes[rand % suffixes.length]
					)
				);
		}

		// prefix only
		if (greatness > 12) {
			return
				string(abi.encodePacked(prefixes[rand % prefixes.length], ' ', output));
		}

		// suffix only
		return
			string(abi.encodePacked(output, ' ', suffixes[rand % suffixes.length]));
	}

	function getWeapon(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, 'WEAPON', weapons);
	}

	function getHead(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, 'HEAD', headGear);
	}

	function getBody(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, 'BODY', bodyGear);
	}

	function getHand(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, 'HAND', handGear);
	}

	function getFoot(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, 'FOOT', footGear);
	}

	function getNeck(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, 'NECK', necklaces);
	}

	function getRing(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, 'RING', rings);
	}

	function getTrinketOne(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, 'TRINKET_ONE', trinkets);
	}

	function getTrinketTwo(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, 'TRINKET_TWO', trinkets);
	}

	function tokenURI(uint256 _tokenId)
		public
		view
		override
		returns (string memory)
	{
		if (_ownerOf[_tokenId] == address(0)) revert NotMinted();

		string[19] memory parts;
		parts[
			0
		] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: #AFB886; font-family: monospace; font-size: 16px; letter-spacing: -0.05em; }</style><rect width="100%" height="100%" fill="#242910" /><text x="10" y="20" class="base">';

		parts[1] = getWeapon(_tokenId);

		parts[2] = '</text><text x="10" y="40" class="base">';

		parts[3] = getHead(_tokenId);

		parts[4] = '</text><text x="10" y="60" class="base">';

		parts[5] = getBody(_tokenId);

		parts[6] = '</text><text x="10" y="80" class="base">';

		parts[7] = getHand(_tokenId);

		parts[8] = '</text><text x="10" y="100" class="base">';

		parts[9] = getFoot(_tokenId);

		parts[10] = '</text><text x="10" y="120" class="base">';

		parts[11] = getNeck(_tokenId);

		parts[12] = '</text><text x="10" y="140" class="base">';

		parts[13] = getRing(_tokenId);

		parts[14] = '</text><text x="10" y="160" class="base">';

		parts[15] = getTrinketOne(_tokenId);

		parts[16] = '</text><text x="10" y="180" class="base">';

		parts[17] = getTrinketTwo(_tokenId);

		parts[18] = '</text></svg>';

		string memory output = string(
			abi.encodePacked(
				parts[0],
				parts[1],
				parts[2],
				parts[3],
				parts[4],
				parts[5],
				parts[6],
				parts[7],
				parts[8]
			)
		);
		output = string(
			abi.encodePacked(
				output,
				parts[9],
				parts[10],
				parts[11],
				parts[12],
				parts[13],
				parts[14],
				parts[15],
				parts[16]
			)
		);
		output = string(abi.encodePacked(output, parts[17], parts[18]));

		// TODO: MAKE THIS DESCRIPTION GOBLIN-EY
		string memory json = Base64.encode(
			bytes(
				string(
					abi.encodePacked(
						'{"name": "sack #',
						Strings.toString(_tokenId),
						'", "description": "Loot is randomized adventurer gear generated and stored on chain. Stats, images, and other functionality are intentionally omitted for others to interpret. Feel free to use Loot in any way you want.", "image": "data:image/svg+xml;base64,',
						Base64.encode(bytes(output)),
						'"}'
					)
				)
			)
		);
		output = string(abi.encodePacked('data:application/json;base64,', json));

		return output;
	}

	function getSacksOwned(address _address)
		public
		view
		returns (uint256[] memory ownedIds)
	{
		uint256 balance = _balanceOf[_address];
		uint256 idCounter = 1;
		uint256 ownedCounter = 0;
		ownedIds = new uint256[](balance);

		while (ownedCounter < balance && idCounter < MAX_SUPPLY + 1) {
			address ownerAddress = _ownerOf[idCounter];
			if (ownerAddress == _address) {
				ownedIds[ownedCounter] = idCounter;
				ownedCounter++;
			}
			idCounter++;
		}
	}
}

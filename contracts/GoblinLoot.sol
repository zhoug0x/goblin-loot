//SPDX-License-Identifier: CC0-1.0
pragma solidity ^0.8.0;

//
// oooOooooo looka fren wats dis... shIneez?
// YUMMZ many manY shineEz, deez mine now teeheeE
// wat? wat it is?
// AAAAAAAUUUUUGGGHHHHH shineez on da blokcHin?
// waaaaaaaaitttt you wan sum?
// okieee fren, u use how uuu want teeheeE...
//
//
//
//   _,   _,  __  ,  ___,,  , ,    _,  _,  ___,
//  / _  / \,'|_) | ' |  |\ | |   / \,/ \,' |
// '\_|`'\_/ _|_)'|___|_,|'\|'|__'\_/'\_/   |
//   _|  '  '       '    '  `   ' '   '     '
//  '      '      '            '          '
//
//             _    |.-""-.)    /\
//            | \   /   .= \)  /  \
//            |  \ / =. --  \ /  ) |   '
//   '        \ ( \   o\/0   /     /
//             \_, '- /   \   ,___/
//               /    \__ /    \
//               \, ___/\___,  /    '
//        '       \  ----     /            '
//                 \         /
//    '             '--___--'
//                     [ ]             '
//            '       { }
//                     [ ]    '             '
//       '            { }
//                     [ ]           '
//
//
//
// inspired by goblintown, the loot project, settlements...
//
// a cc0 project from imp0ster, zhoug & jaythin staythin...
//
//                             ...enJoy... teEEhheeeEEEe...
//

import '@rari-capital/solmate/src/tokens/ERC721.sol';
import '@openzeppelin/contracts/utils/Strings.sol';
import '@openzeppelin/contracts/utils/Base64.sol';

contract GoblinLoot is ERC721 {
	using Strings for uint256;

	uint256 public constant MAX_SUPPLY = 5000;
	uint256 public constant MINT_DURATION = 48 hours;
	uint256 public totalSupply;
	uint256 public mintClosingTime;
	bool public mintIsActive;
	address public tipWithdrawer;

	address private imp0ster = 0x023006cED81c7Bf6D17A5bC1e1B40104114d0019;
	address private zhoug = 0xc99547f73B0Aa2C69E56849e8986137776D72474;

	// -------------------------------------------------------------------------------------------------- kOonstrukktorr
	constructor() ERC721('GoblinLoot', 'gObLooT') {
		tipWithdrawer = msg.sender;
		mintClosingTime = block.timestamp + MINT_DURATION;
		mintIsActive = true;
		_batchMint(imp0ster, 50);
		_batchMint(zhoug, 50);
	}

	// -------------------------------------------------------------------------------------------------- sLott KeYsss
	uint256 internal constant SLOT_WEAP = 1;
	uint256 internal constant SLOT_HEAD = 2;
	uint256 internal constant SLOT_BODY = 3;
	uint256 internal constant SLOT_HAND = 4;
	uint256 internal constant SLOT_FOOT = 5;
	uint256 internal constant SLOT_NECK = 6;
	uint256 internal constant SLOT_RING = 7;
	uint256 internal constant SLOT_TRI1 = 8;
	uint256 internal constant SLOT_TRI2 = 9;

	// -------------------------------------------------------------------------------------------------- matEriallss
	string[] internal heavyMaterials = [
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
		'scrap'
	];

	string[] internal lightMaterials = [
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
		'snakeskin '
	];

	// -------------------------------------------------------------------------------------------------- iTEMs
	string[] internal weapons = [
		'club',
		'scythe',
		'hammer',
		'sickle',
		'longspear',
		'shortspear',
		'staff',
		'slingshot',
		'shortbow',
		'longbow',
		'mace',
		'dagger',
		'totem',
		'wand',
		'pickaxe',
		'hatchet',
		'maul',
		'knife'
	];

	string[] internal headGear = [
		'cap',
		'hood',
		'helmet',
		'crown',
		'earring',
		'top hat',
		'bonnet',
		'kettle',
		'pot lid',
		'goggles',
		'monocle',
		'bowler',
		'eyepatch'
	];

	string[] internal bodyGear = [
		'husk',
		'cloak',
		'pads',
		'pauldrons',
		'waistcoat',
		'loincloth',
		'trousers',
		'robe',
		'rags',
		'harness',
		'tunic',
		'wrappings',
		'cuirass',
		'crop top',
		'sash',
		'toga',
		'belt',
		'vest',
		'cape'
	];

	string[] internal handGear = [
		'hooks',
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

	string[] internal footGear = [
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

	string[] internal necklaces = [
		'chain',
		'amulet',
		'locket',
		'pendant',
		'choker'
	];

	string[] internal rings = [
		'gold ring',
		'silver ring',
		'bronze ring',
		'iron ring'
	];

	string[] internal trinkets1 = [
		'pipe',
		'sundial',
		'clock',
		'bellows',
		'brush',
		'comb',
		'candle',
		'candlestick',
		'torch',
		'scratcher',
		'gaslamp',
		'shoehorn',
		'dice',
		'spoon',
		'periscope',
		'spyglass',
		'lute',
		'drum',
		'tamborine',
		'whistle',
		'pocketwatch',
		'compass',
		'whip'
	];

	string[] internal trinkets2 = [
		'potato',
		'pickle',
		'ruby',
		'herb pouch',
		'tooth',
		'jawbone',
		'dandelions',
		'sapphire',
		'diamond',
		'mushroom',
		'emerald',
		'sardines',
		'sulfur',
		'seeds',
		'beans',
		'quicksilver',
		'skull',
		'blueberries',
		'egg',
		'meat',
		'oil',
		'chalk',
		'charcoal',
		'twigs',
		'sweets',
		'amethyst',
		'obsidian',
		'pebbles',
		'goo',
		'rose',
		'seaweed',
		'feathers'
	];

	string[] internal trinkets3 = [
		'sailcloth',
		'cog',
		'rope',
		'vial',
		'flask',
		'jar',
		'gasket',
		'shears',
		'nails',
		'screws',
		'thread',
		'sewing needle',
		'mallet',
		'fishing rod',
		'grindstone',
		'bowl',
		'paintbrush',
		'scroll',
		'scraper',
		'???',
		'grappling hook',
		'sand',
		'stein',
		'teapot',
		'wineskin'
	];

	// -------------------------------------------------------------------------------------------------- preEefiX aN SUFfixxx
	string[] internal jewelryPrefixes = [
		'crude',
		'flawed',
		'rusty',
		'perfect',
		'fine',
		'flawless',
		'noble',
		'embossed',
		'tainted',
		'chipped',
		'worn',
		'sooty',
		'stolen'
	];

	string[] internal prefixes = [
		'sparkling',
		'shiny',
		'slick',
		'glowing',
		'polished',
		'damp',
		'blighty',
		'bloody',
		'thorny',
		'doomed',
		'gloomy',
		'grim',
		'makeshift',
		'noxious',
		'hairy',
		'mossy',
		'stinky',
		'dusty',
		'charred',
		'spiky',
		'cursed',
		'scaly',
		'crusty',
		'damned',
		'briny',
		'dirty',
		'slimy',
		'muddy',
		'lucky',
		"artificer's",
		"wayfarer's",
		"thief's",
		"captain's",
		"henchman's",
		"daredevil's",
		"bandit's",
		"inspector's",
		"raider's",
		"miner's",
		"builder's"
	];

	string[] internal suffixes = [
		'of RRRAAAAAHHH',
		'of AAAUUUGGHHH',
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
		'of the cliffs',
		'of the swamp',
		'of the bog',
		'of the rift',
		'of the sewers',
		'of the woods',
		'of the caves',
		'of the grave'
	];

	// -------------------------------------------------------------------------------------------------- eRRorzZ aaN modIffieerss
	error MintInactive();
	error NotEnoughLoot();
	error NotAuthorized();
	error NotMinted();

	modifier mintControl() {
		_;
		if (totalSupply == MAX_SUPPLY || block.timestamp > mintClosingTime) {
			mintIsActive = false;
		}
	}

	// -------------------------------------------------------------------------------------------------- wRiTez
	function _batchMint(address _recipient, uint256 _amount) private {
		unchecked {
			for (uint256 i = 1; i < _amount + 1; ++i) {
				_safeMint(_recipient, totalSupply + i);
			}
			totalSupply += _amount;
		}
	}

	function mint() public mintControl {
		if (!mintIsActive) revert MintInactive();
		if (totalSupply == MAX_SUPPLY) revert NotEnoughLoot();
		unchecked {
			++totalSupply;
		}
		_safeMint(msg.sender, totalSupply);
	}

	function mintThreeWithATip() public payable mintControl {
		if (!mintIsActive) revert MintInactive();
		if (totalSupply + 3 > MAX_SUPPLY) revert NotEnoughLoot();
		if (msg.value <= 0) revert NotAuthorized();
		_batchMint(msg.sender, 3);
	}

	function burn(uint256 _tokenId) public {
		if (
			msg.sender != address(_ownerOf[_tokenId]) ||
			isApprovedForAll[_ownerOf[_tokenId]][msg.sender]
		) revert NotAuthorized();
		_burn(_tokenId);
	}

	function updateTipWithdrawer(address _newWithdrawer) public {
		if (msg.sender != tipWithdrawer) revert NotAuthorized();
		tipWithdrawer = _newWithdrawer;
	}

	function withdrawTips() external payable {
		if (msg.sender != tipWithdrawer) revert NotAuthorized();
		(bool os, ) = payable(tipWithdrawer).call{value: address(this).balance}('');
		require(os);
	}

	// -------------------------------------------------------------------------------------------------- rEEdz
	function isHeavyMaterial(uint256 _key) internal pure returns (bool) {
		return (_key == SLOT_WEAP || _key == SLOT_HEAD || _key == SLOT_HAND);
	}

	function isLightMaterial(uint256 _key) internal pure returns (bool) {
		return (_key == SLOT_BODY || _key == SLOT_FOOT);
	}

	function isTrinket(uint256 _key) internal pure returns (bool) {
		return (_key == SLOT_TRI1 || _key == SLOT_TRI2);
	}

	function isJewelry(uint256 _key) internal pure returns (bool) {
		return (_key == SLOT_NECK || _key == SLOT_RING);
	}

	function random(uint256 _seedOne, uint256 _seedTwo)
		internal
		pure
		returns (uint256)
	{
		return
			uint256(
				keccak256(
					abi.encodePacked('AUuuU', _seedOne, 'UuUu', _seedTwo, 'uUgHH')
				)
			);
	}

	function join(string memory _itemOne, string memory _itemTwo)
		internal
		pure
		returns (string memory)
	{
		return string(abi.encodePacked(_itemOne, ' ', _itemTwo));
	}

	function pluck(
		uint256 _tokenId,
		uint256 _slotKey,
		string[] memory _sourceArray
	) internal view returns (string memory) {
		uint256 rand = random(_tokenId, _slotKey);
		uint256 AUUUGH = rand % 69;
		string memory output = _sourceArray[rand % _sourceArray.length];

		if (isHeavyMaterial(_slotKey)) {
			output = join(heavyMaterials[rand % heavyMaterials.length], output);
		}

		if (isLightMaterial(_slotKey)) {
			output = join(lightMaterials[rand % lightMaterials.length], output);
		}

		if (isJewelry(_slotKey)) {
			output = join(jewelryPrefixes[rand % jewelryPrefixes.length], output);
		}

		// no prefix or suffix
		if (AUUUGH < 23 || isTrinket(_slotKey)) {
			return output;
		}

		// both prefix & suffix
		if (AUUUGH > 55) {
			// if jewelry, apply only the suffix
			if (isJewelry(_slotKey)) {
				return join(output, suffixes[rand % suffixes.length]);
			}

			return
				join(
					join(prefixes[rand % prefixes.length], output),
					suffixes[rand % suffixes.length]
				);
		}

		// prefix only
		if (AUUUGH > 40 && !isJewelry(_slotKey)) {
			return join(prefixes[rand % prefixes.length], output);
		}

		// suffix only
		return join(output, suffixes[rand % suffixes.length]);
	}

	function getWeapon(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, SLOT_WEAP, weapons);
	}

	function getHead(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, SLOT_HEAD, headGear);
	}

	function getBody(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, SLOT_BODY, bodyGear);
	}

	function getHand(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, SLOT_HAND, handGear);
	}

	function getFoot(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, SLOT_FOOT, footGear);
	}

	function getNeck(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, SLOT_NECK, necklaces);
	}

	function getRing(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, SLOT_RING, rings);
	}

	function getTrinket1(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, SLOT_TRI1, trinkets1);
	}

	function getTrinket2(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, SLOT_TRI2, trinkets2);
	}

	function getTrinket3(uint256 _tokenId) public view returns (string memory) {
		return pluck(_tokenId, SLOT_TRI2, trinkets3);
	}

	function getShinee(uint256 _tokenId) public pure returns (uint256) {
		return (random(_tokenId, 420) % 10) + 1;
	}

	function buildSVG(uint256 _tokenId) internal view returns (string memory) {
		string[24] memory parts;
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
		parts[15] = getTrinket1(_tokenId);
		parts[16] = '</text><text x="10" y="180" class="base">';
		parts[17] = getTrinket2(_tokenId);
		parts[18] = '</text><text x="10" y="200" class="base">';
		parts[19] = getTrinket3(_tokenId);
		parts[
			20
		] = '</text><text x="10" y="220" class="base">---------------------';
		parts[21] = '</text><text x="10" y="240" class="base">';
		parts[22] = Strings.toString(getShinee(_tokenId));
		parts[23] = ' shinee</text></svg>';

		string memory svg = string(
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
		svg = string(
			abi.encodePacked(
				svg,
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
		return
			string(
				abi.encodePacked(
					svg,
					parts[17],
					parts[18],
					parts[19],
					parts[20],
					parts[21],
					parts[22],
					parts[23]
				)
			);
	}

	function buildAttr(string memory _traitType, string memory _value)
		internal
		pure
		returns (string memory)
	{
		return
			string(
				abi.encodePacked(
					'{"trait_type": "',
					_traitType,
					'", "value": "',
					_value,
					'"},'
				)
			);
	}

	function buildAttrList(uint256 _tokenId)
		internal
		view
		returns (string memory)
	{
		string[12] memory parts;
		parts[0] = '[';
		parts[1] = buildAttr('weapon', getWeapon(_tokenId));
		parts[2] = buildAttr('head', getHead(_tokenId));
		parts[3] = buildAttr('body', getBody(_tokenId));
		parts[4] = buildAttr('hand', getHand(_tokenId));
		parts[5] = buildAttr('foot', getFoot(_tokenId));
		parts[6] = buildAttr('neck', getNeck(_tokenId));
		parts[7] = buildAttr('ring', getRing(_tokenId));
		parts[8] = buildAttr('trinket_one', getTrinket1(_tokenId));
		parts[9] = buildAttr('trinket_two', getTrinket2(_tokenId));
		parts[10] = buildAttr('trinket_three', getTrinket3(_tokenId));
		parts[11] = string(
			abi.encodePacked(
				'{"trait_type": "shinee", "value": ',
				Strings.toString(getShinee(_tokenId)),
				', "max_value": 10}]'
			)
		);

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

		return string(abi.encodePacked(output, parts[9], parts[10], parts[11]));
	}

	function tokenURI(uint256 _tokenId)
		public
		view
		override
		returns (string memory)
	{
		if (_ownerOf[_tokenId] == address(0)) revert NotMinted();

		string memory json = Base64.encode(
			bytes(
				string(
					abi.encodePacked(
						'{"name": "sack #',
						Strings.toString(_tokenId),
						'", "description": "oooOooooo looka fren wats dis... shIneez?\\nYUMMZ\\n\\nmany manY shineEz, deez mine now teeheeE\\n\\nwat? wat it is?\\nAAAAAAAUUUUUGGGHHHHH shineez on da blokcHin?\\n\\nwaaaaaaaaitttt you wan sum?\\nokieee fren, u use how uuu want teeheeE", "image": "data:image/svg+xml;base64,',
						Base64.encode(bytes(buildSVG(_tokenId))),
						'", "attributes": ',
						buildAttrList(_tokenId),
						'}'
					)
				)
			)
		);

		string memory output = string(
			abi.encodePacked('data:application/json;base64,', json)
		);
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

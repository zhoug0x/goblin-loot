import React from 'react'
import styled from 'styled-components'

import { useWeb3Context } from '../context/Web3Context'
import { truncateEthAddress } from '../utils'

const Nav = styled.nav`
	display: flex;
	justify-content: center;
	align-items: center;
`

const NavBar = ({ onConnectClick }) => {
	const { web3IsAvailable, activeAccount } = useWeb3Context()

	const renderConnectWallet = () => {
		// TODO: write a nicer looking component for the below "no wallet" edge-case
		if (!web3IsAvailable) {
			return <div style={{ fontWeight: 'bold' }}>No wallet detected!</div>
		}

		if (!activeAccount) {
			return (
				<button role="button" onClick={onConnectClick}>
					Connect Wallet
				</button>
			)
		}

		return <div>Connected: {truncateEthAddress(activeAccount)}</div>
	}

	return <Nav>{renderConnectWallet()}</Nav>
}

export default NavBar

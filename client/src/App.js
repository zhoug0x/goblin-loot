import React, { useState } from 'react'
import styled from 'styled-components'

import { useWeb3Context } from './context/Web3Context'
import { Container } from './components/Shared'
import NavBar from './components/NavBar'
import Showcase from './components/Showcase'

const MainContainer = styled(Container)`
	display: flex;
	flex-direction: column;
	align-items: center;
	padding-bottom: 10rem;

	// Toggle these media queries for visual breakpoint indicators
	/* @media (min-width: ${({ theme }) => theme.breakpoint.sm}px) {
		outline: 5px solid red;
	}

	@media (min-width: ${({ theme }) => theme.breakpoint.md}px) {
		outline: 5px solid orange;
	}

	@media (min-width: ${({ theme }) => theme.breakpoint.lg}px) {
		outline: 5px solid gold;
	}

	@media (min-width: ${({ theme }) => theme.breakpoint.xl}px) {
		outline: 5px solid yellow;
	} */
`

const App = () => {
	const { connectWallet } = useWeb3Context()
	const [isLoading, setIsLoading] = useState(false)

	const onConnectClick = () => {
		setIsLoading(true)
		connectWallet().then(() => {
			setIsLoading(false)
		})
	}

	// TODO: create proper loading screen
	if (isLoading) {
		return (
			<div
				style={{
					fontSize: '4rem',
					fontWeight: 'bold',
					textAlign: 'center',
					marginTop: '16rem',
					letterSpacing: '-0.05em',
				}}
			>
				busy with wallet...
			</div>
		)
	}

	return (
		<MainContainer>
			<NavBar onConnectClick={onConnectClick} />
			<Showcase />
		</MainContainer>
	)
}

export default App

import React, { useState, useEffect } from 'react'
import { ethers } from 'ethers'

import { ETHERSCAN_LINK, OPENSEA_LINK } from '../../config'
import { truncateEthAddress } from '../../utils'
import { getContract } from '../../services/contract.service.js'
import { useWeb3Context } from '../../context/Web3Context'

import { ExtLink } from '../Shared'
import * as S from './styled'

const Showcase = () => {
	const { activeAccount, provider } = useWeb3Context()
	const [totalSupply, setTotalSupply] = useState()

	useEffect(() => {
		if (!!provider) {
			const contract = getContract(provider)

			contract
				.totalSupply()
				.then(result => {
					if (result) {
						setTotalSupply(result.toNumber())
					} else {
						console.log('no result from chain call')
					}
				})
				.catch(error => {
					console.error(error)
				})
		}
	}, [provider])

	return (
		<S.ShowcaseWrapper>
			<header>
				<h1>goblin loot</h1>
			</header>
			<div>
				{!!activeAccount && (
					<div>connected: {truncateEthAddress(activeAccount)}</div>
				)}
				<br />
				{!!totalSupply && <div>totalSupply: {totalSupply}</div>}
				<br />
				<ExtLink href={ETHERSCAN_LINK}>CONTRACT</ExtLink>
				{' | '}
				<ExtLink href={OPENSEA_LINK}>OPENSEA</ExtLink>
			</div>
		</S.ShowcaseWrapper>
	)
}

export default Showcase

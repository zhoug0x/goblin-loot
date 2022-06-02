import React, { useState, useEffect, createContext, useContext } from 'react'
import { ethers } from 'ethers'
import { CHAIN_ID } from '../config'

const Web3Context = createContext({})

export const useWeb3Context = () => useContext(Web3Context)

export const Web3Provider = ({ children }) => {
	const [web3IsAvailable, setWeb3IsAvailable] = useState(false)
	const [activeAccount, setActiveAccount] = useState()
	const [provider, setProvider] = useState()

	// Check if the browser supports wallet on-mount
	useEffect(() => {
		if (!!window && !!window.ethereum) {
			setWeb3IsAvailable(true)
		} else {
			alert('No wallet detected')
		}
	}, [])

	// Connect user wallet to site and fetch active account
	const connectWallet = async () => {
		if (web3IsAvailable) {
			try {
				// Check if user connected to either correct production or development network
				const clientChainId = parseInt(window.ethereum.networkVersion)

				if (clientChainId !== CHAIN_ID) {
					alert(`Invalid network - connect to ${CHAIN_ID}`)
					return
				}

				// Instantiate web3 provider
				const provider = new ethers.providers.Web3Provider(window.ethereum)
				setProvider(provider)

				// Request user accounts
				const accounts = await provider.send('eth_requestAccounts', [])

				// If accounts available, set first account as active & add wallet change event handlers
				if (accounts.length > 0) {
					setActiveAccount(accounts[0])
					window.ethereum.on('accountsChanged', () => window.location.reload())
					window.ethereum.on('chainChanged', () => window.location.reload())
				} else {
					alert('No valid Ethereum addresses found')
				}
			} catch (error) {
				console.error(error)
				alert('Error connecting! Are you logged into your wallet?')
			}
		}
	}

	return (
		<Web3Context.Provider
			value={{ web3IsAvailable, connectWallet, activeAccount, provider }}
		>
			{children}
		</Web3Context.Provider>
	)
}

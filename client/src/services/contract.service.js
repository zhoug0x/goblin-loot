import { ethers } from 'ethers'
import { CONTRACT_ADDRESS } from '../config'
import abi from '../config/abi.json'

/**
 * instantiates contract interface with given web3 provider
 * @param provider: Provider
 * @returns Contract
 */
export const getContract = provider => {
	return new ethers.Contract(CONTRACT_ADDRESS, abi, provider)
}

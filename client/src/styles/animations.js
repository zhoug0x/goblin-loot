import { keyframes } from 'styled-components'

export const animationFloat = intensity => keyframes`
	0% { transform: translateY(0); }
	50% { transform: translateY(${intensity}em); }
	100% { transform: translateY(0); }
`

export const animationWiggle = intensity => keyframes`
	0% { transform: rotate(${intensity}deg); }
	50% { transform: rotate(-${intensity}deg); }
	100% { transform: rotate(${intensity}deg); }
`

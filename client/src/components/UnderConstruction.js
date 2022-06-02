import styled, { keyframes } from 'styled-components'
import { TWITTER_LINK } from '../config'
import { ExtLink } from './Shared'

const RESPONSIVE_BREAKPOINT = '786px'

const wiggle = keyframes`
	0% { transform: rotate(5deg); }
	10% { transform: rotate(-2deg); }
	20% { transform: rotate(5deg); }
	30% { transform: rotate(-2deg); }
	50% { transform: rotate(5deg); }
	100% { transform: rotate(5deg); }
`

const float = keyframes`
	0% { transform: translateY(0); }
	50% { transform: translateY(0.5rem); }
	100% { transform: translateY(0); }
`

const UnderConstructionWrapper = styled.div`
	width: 100%;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	padding-bottom: 6rem;
`

const UnderConstructionContent = styled.div`
	position: relative;
`

const Eyes = styled.div`
	text-align: center;
	animation: ${wiggle} 1s ease-in-out;
	animation-iteration-count: infinite;
	font-size: 3rem;

	@media (min-width: ${RESPONSIVE_BREAKPOINT}) {
		display: block;
		position: absolute;
		top: 8rem;
		left: 36rem;
		font-size: 7rem;
	}
`

const TitleHeader = styled.h1`
	font-weight: bold;
	font-size: 5rem;
	text-align: center;
	letter-spacing: -0.075em;
	margin-bottom: 4rem;
	animation: ${float} 2s ease-in-out;
	animation-iteration-count: infinite;

	@media (min-width: ${RESPONSIVE_BREAKPOINT}) {
		font-size: 7rem;
		text-align: left;
		margin-bottom: 7rem;
	}
`

const SubHeader = styled.h2`
	font-weight: bold;
	font-size: 1.25rem;
	text-align: center;
	letter-spacing: -0.04em;
	margin-bottom: 2.5rem;

	@media (min-width: ${RESPONSIVE_BREAKPOINT}) {
		font-size: 2rem;
		text-align: left;
		margin-bottom: 4rem;
	}
`

const Links = styled.p`
	text-align: center;
	font-size: 0.9rem;
	margin-bottom: 1.25rem;

	@media (min-width: ${RESPONSIVE_BREAKPOINT}) {
		font-size: 1rem;
	}
`

const UnderConstruction = () => {
	return (
		<UnderConstructionWrapper>
			<UnderConstructionContent>
				<div style={{ transform: 'rotate(-5deg)' }}>
					<TitleHeader>goblin loot</TitleHeader>
				</div>
				<div style={{ transform: 'rotate(2.5deg)' }}>
					<SubHeader>🚧 just a sec, buidling! 🚧</SubHeader>
				</div>
				<div style={{ transform: 'rotate(-2.5deg)' }}>
					<Links>
						created by <ExtLink href={TWITTER_LINK}>zhoug</ExtLink>
					</Links>
				</div>
				<Eyes>👀</Eyes>
			</UnderConstructionContent>
		</UnderConstructionWrapper>
	)
}

export default UnderConstruction

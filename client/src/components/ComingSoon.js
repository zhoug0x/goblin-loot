import styled, { keyframes } from 'styled-components'
import { TWITTER_LINK, ETHERSCAN_LINK, OPENSEA_LINK } from '../config'
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

const ComingSoonWrapper = styled.div`
	width: 100%;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	padding-bottom: 8rem;
	font-size: 1rem;
`

const ComingSoonContent = styled.div`
	position: relative;
`

const TitleHeader = styled.h1`
	font-weight: bold;
	font-size: 6em;
	text-align: center;
	letter-spacing: -0.075em;
	margin-bottom: 0.25em;
	animation: ${float} 2s ease-in-out;
	animation-iteration-count: infinite;

	@media (min-width: ${RESPONSIVE_BREAKPOINT}) {
		font-size: 10em;
		margin-bottom: 0.25em;
	}
`

const SubHeader = styled.h2`
	font-weight: bold;
	font-size: 1.5em;
	text-align: center;
	letter-spacing: -0.04em;
	margin-bottom: 1.5em;

	@media (min-width: ${RESPONSIVE_BREAKPOINT}) {
		font-size: 2.5em;
		margin-bottom: 0.75em;
	}
`

const FollowLink = styled.p`
	text-align: center;
	font-size: 1.1em;
	margin-bottom: 3em;

	@media (min-width: ${RESPONSIVE_BREAKPOINT}) {
		font-size: 1.25em;
	}
`

const Swords = styled.div`
	transform: rotate(8deg);
	margin-bottom: 2.5em;

	& > div {
		text-align: center;
		animation: ${wiggle} 1s ease-in-out;
		animation-iteration-count: infinite;
		font-size: 5em;
	}
`

const Links = styled.div`
	text-align: center;
	font-weight: bold;
`

const ComingSoon = () => {
	return (
		<ComingSoonWrapper>
			<ComingSoonContent>
				<div style={{ transform: 'rotate(-5deg)' }}>
					<TitleHeader>gₒbₗᵢₙ ₗₒₒₜ</TitleHeader>
				</div>
				<div style={{ transform: 'rotate(2.5deg)' }}>
					<SubHeader>bᵤᵢdₗᵢₙg dₐ wₐbₛᵢₜₑ</SubHeader>
				</div>
				<div style={{ transform: 'rotate(-2.5deg)' }}>
					<FollowLink>
						<ExtLink href={TWITTER_LINK}>fₒₗₗₒw zₕₒᵤg fₑᵣ ᵤₚdₒₒₜₛ</ExtLink>
					</FollowLink>
				</div>
				<Swords>
					<div>⚔️</div>
				</Swords>
				<Links>
					<ExtLink href={ETHERSCAN_LINK}>contract</ExtLink> |{' '}
					<ExtLink href={OPENSEA_LINK}>opensea</ExtLink>
				</Links>
			</ComingSoonContent>
		</ComingSoonWrapper>
	)
}

export default ComingSoon

import styled from 'styled-components'

export const ExtLink = ({ children, ...props }) => (
	<a target="_blank" rel="noopener noreferrer" {...props}>
		{children}
	</a>
)

export const Container = styled.div`
	max-width: 100%;
	padding-right: 1rem;
	padding-left: 1rem;
	margin-right: auto;
	margin-left: auto;
	@media (min-width: ${({ theme }) => theme.breakpoint.sm}px) {
		max-width: ${({ theme }) => theme.breakpoint.sm * 0.94}px;
	}
	@media (min-width: ${({ theme }) => theme.breakpoint.md}px) {
		max-width: ${({ theme }) => theme.breakpoint.md * 0.94}px;
	}
	@media (min-width: ${({ theme }) => theme.breakpoint.lg}px) {
		max-width: ${({ theme }) => theme.breakpoint.lg * 0.94}px;
	}
	@media (min-width: ${({ theme }) => theme.breakpoint.xl}px) {
		max-width: ${({ theme }) => theme.breakpoint.xl * 0.94}px;
	}
`

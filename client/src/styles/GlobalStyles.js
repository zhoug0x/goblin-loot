import { createGlobalStyle } from 'styled-components'

export default createGlobalStyle`
	body {
		font-size: 16px;
		font-family: ${({ theme }) => theme.font.primary};
		color: ${({ theme }) => theme.color.text};
		background-color: ${({ theme }) => theme.color.background};
		font-smooth: never;
		-webkit-font-smoothing : none;

		// Increase global font size on larger viewports
		@media (min-width: ${({ theme }) => theme.breakpoint.sm}px) {
			font-size: 1.25em;
		}
	}

	a {
		cursor: pointer;
		color: ${({ theme }) => theme.color.link};
		&:visited {
			color: ${({ theme }) => theme.color.link};
		}
		&:hover {
			opacity: 0.85;
		}
	}

	// Always show up/down arrows for number inputs
	input[type=number]::-webkit-inner-spin-button {
    	opacity: 1;
	}
`

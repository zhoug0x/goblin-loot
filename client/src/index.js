import React from 'react'
import ReactDOM from 'react-dom'
import './styles/reset.css'
import StylesProvider from './styles/StylesProvider'
import { Web3Provider } from './context/Web3Context'
import App from './App'

ReactDOM.render(
	<React.StrictMode>
		<Web3Provider>
			<StylesProvider>
				<App />
			</StylesProvider>
		</Web3Provider>
	</React.StrictMode>,
	document.getElementById('root')
)


Introduction
Stablecoins are a type of cryptocurrency that seeks to maintain a stable value by pegging their market value to an external reference. This reference could be a fiat currency like the U.S. dollar, a commodity such as gold, or another financial instrument. The primary goal of stablecoins is to provide an alternative to the high volatility of popular cryptocurrencies like Bitcoin (BTC), which can make these digital assets less suitable for common transactions.


Problem Statement
The task was to design a stablecoin smart contract using Solidity, the ERC20 protocol, and the AggregatorV3 interface. The stablecoin must be pegged to a fiat currency and over-collateralized by 200%. For example, if a person deposits $100 worth of collateral, they will receive $50 worth of tokens. The stablecoin should maintain a constant value of 1 Token = 1 unit of fiat currency and be algorithmically stable, obeying the rules of the contract without any exceptions.


Utility of Stablecoins
1. Medium of Exchange
Stability: Unlike traditional cryptocurrencies, stablecoins maintain a consistent value, making them more practical for everyday transactions.
Global Transactions: They facilitate cross-border payments without the delays and costs associated with traditional banking systems.
Digital Commerce: Merchants can accept stablecoins without the fear of significant value fluctuations.
2. Store of Value
Inflation Protection: In countries with high inflation rates, stablecoins pegged to stronger currencies can act as a store of value, preserving purchasing power.
Accessibility: They provide an accessible store of value for people in regions with limited access to banking services.
3. Unit of Account
Pricing and Billing: Businesses and individuals can price goods and services in stablecoins, ensuring consistent value without needing constant price adjustments.
Financial Planning: Stablecoins offer a reliable unit of account for budgeting and financial planning, especially in volatile economic environments.
4. DeFi Integration
Lending and Borrowing: Stablecoins are widely used in decentralized finance (DeFi) platforms for lending and borrowing, providing a stable collateral and loan asset.
Yield Farming: Users can participate in yield farming and liquidity mining with stablecoins, earning returns without exposure to volatility.
Staking: Some platforms offer staking opportunities for stablecoins, providing passive income for holders.


Project Overview
The project required designing smart contracts that would:
Peg the stablecoin to a fiat currency.
Maintain over-collateralization by 200%.
Provide stable and secure transactions.
Solution Design


Functionalities
Deposit Collateral and Mint DUN: Users can deposit collateral in WETH or WBTC and mint DUN tokens.
Burn DUN and Redeem Collateral: Users can burn their DUN tokens to retrieve their collateral.
Liquidate Position: If a user's health factor falls below the threshold, their collateral can be liquidated.
Health Factor: The health factor of a user is calculated to ensure sufficient collateralization.


Smart Contracts

DUN.sol
DUN.sol is responsible for the core functionality of minting and burning stablecoins, adhering to the ERC20 protocol to ensure compatibility and reliability. 

Here’s a detailed breakdown of its functionalities:
Minting Tokens: This function allows for the creation of new DUN tokens. It checks that the user has deposited sufficient collateral to back the tokens being minted. The minting process ensures that for every DUN token created, there is an equivalent amount of collateral that is more than twice its value, ensuring over-collateralization.
Burning Tokens: This function allows users to burn their DUN tokens, effectively removing them from circulation. When tokens are burned, the corresponding amount of collateral is released back to the user. This process ensures that the supply of tokens remains backed by adequate collateral.
Collateral Management: The contract includes mechanisms to track and manage the collateral deposited by users, ensuring that all minted tokens are adequately backed and that the system remains solvent.


DUNcore.sol
DUNcore.sol serves as the backbone of the stablecoin ecosystem, managing more complex operations beyond basic minting and burning. 

Here’s a detailed breakdown of its functionalities:
Collateral Deposits: Users can deposit collateral in the form of WETH or WBTC. The contract ensures that the deposited collateral meets the necessary over-collateralization requirements before minting new DUN tokens.
Minting DUN Tokens: Upon depositing collateral, users can mint new DUN tokens. The contract calculates the amount of collateral required and verifies that the user’s position remains over-collateralized.
Burning DUN Tokens and Redeeming Collateral: Users can burn their DUN tokens to retrieve their collateral. The contract ensures that the user’s position remains over-collateralized even after redeeming collateral.
Liquidation Mechanism: If a user’s collateral falls below the required threshold, their position can be liquidated. This function allows other users to liquidate under-collateralized positions, ensuring the system remains solvent. The liquidator receives a bonus for performing this action.
Health Factor Calculation: The contract calculates the health factor of each user, which is the ratio of their collateral value to their debt. This ensures that all positions remain adequately collateralized.
Price Feeds: Integrates with Chainlink’s AggregatorV3 interface to fetch real-time price data for collateral assets. This ensures that all calculations are based on up-to-date and accurate market prices.


Deployment Script
The deployment script automates the process of deploying the smart contracts to a local blockchain environment. 

Here’s a detailed breakdown of its functionalities:
Initialization: Sets up the necessary parameters for the smart contracts, including token addresses and price feed addresses. This step ensures that the contracts have all the required information to function correctly.
Mock Tokens: Deploys instances of MockERC20 contracts to simulate WETH and WBTC tokens. These mock tokens are used for testing purposes, allowing the system to operate in a controlled environment.
Contract Deployment: Deploys the DUN and DUNcore contracts on a local blockchain, such as an Anvil chain. This step ensures that the contracts are correctly initialized and ready for interaction.

Testing
The test files verify the following functionalities:
Collateral Deposit and Minting: Ensures users can deposit collateral and mint DUN tokens.
Burning and Redemption: Ensures users can burn DUN tokens and redeem their collateral.
Health Factor Calculation: Verifies the correct calculation of the health factor.
Liquidation Process: Tests the liquidation process when a user's health factor falls below the threshold.


Real-World Applications
Our stablecoin design can contribute to solving real-world financial problems by:
Providing a stable and accessible digital currency.
Enhancing capital efficiency by allowing users to leverage their assets effectively.
Improving liquidity in the DeFi ecosystem.
Offering transparent and reliable financial solutions.

Conclusion
The DeFi Unchained project demonstrates the potential of stablecoins to address the inefficiencies of traditional finance. By leveraging blockchain technology, decentralized price feeds, and robust collateral management systems, we can create a more efficient, inclusive, and stable financial ecosystem.

Team Members
Khush Maheshwari
Pranav Krishna
Muskan
Feel free to reach out to us for any queries or further information.
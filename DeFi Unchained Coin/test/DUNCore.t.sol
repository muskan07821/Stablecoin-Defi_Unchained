// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import "../src/DUN.sol";
import {Stablecore} from "../src/DUNCore.sol";
import "../src/MOCKERC.sol";

contract MockAggregator {
    int256 private answer;

    constructor(int256 initialAnswer) {
        answer = initialAnswer;
    }

    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int256 price,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        )
    {
        return (0, answer, 0, 0, 0);
    }

    function updateAnswer(int256 newAnswer) external {
        answer = newAnswer;
    }
}

contract StablecoreTest is Test {
    DUN stableToken;
    CustomERC20 ethToken;
    CustomERC20 btcToken;
    Stablecore coreContract;
    MockAggregator ethPriceFeed;
    MockAggregator btcPriceFeed;

    address tester = address(1);

    function setUp() public {
        stableToken = new DUN();
        ethToken = new CustomERC20("Wrapped Ether", "WETH");
        btcToken = new CustomERC20("Wrapped Bitcoin", "WBTC");

        // Deploy mock price feed contracts
        ethPriceFeed = new MockAggregator(3000 * 10**8); // Initial price of $3000 for WETH
        btcPriceFeed = new MockAggregator(50000 * 10**8); // Initial price of $50000 for WBTC

        coreContract = new Stablecore(
            address(stableToken),
            address(ethToken),
            address(btcToken),
            address(ethPriceFeed),
            address(btcPriceFeed)
        );

        // Mint tokens to the tester for testing
        ethToken.mintTokens(tester, 1000 ether);
        btcToken.mintTokens(tester, 1000 ether);
        stableToken.mint(address(coreContract), 1000000 ether); // Mint stable tokens to the contract for testing
    }

    function testDepositAndMintStableTokens() public {
        vm.startPrank(tester);
        ethToken.approve(address(coreContract), 200 ether);
        coreContract.depositAndMint(address(ethToken), 200 ether, 300 ether);
        assertEq(stableToken.balanceOf(tester), 300 ether);
        vm.stopPrank();
    }

    function testBurnStableTokensAndRedeem() public {
        vm.startPrank(tester);
        ethToken.approve(address(coreContract), 150 ether);
        coreContract.depositAndMint(address(ethToken), 150 ether, 225 ether);
        stableToken.approve(address(coreContract), 225 ether); // Added stable token approval
        coreContract.burnAndRedeem(125 ether, address(ethToken), 75 ether);
        assertEq(stableToken.balanceOf(tester), 100 ether);
        assertEq(ethToken.balanceOf(tester), 925 ether);
        vm.stopPrank();
    }

    function testLiquidationProcess() public {
        address liquidator = address(2);
        vm.startPrank(tester);
        ethToken.approve(address(coreContract), 150 ether);
        coreContract.depositAndMint(address(ethToken), 150 ether, 120000 ether);
        vm.stopPrank();

        // Check health factor before price drop
        uint256 preDropHealthFactor = coreContract.getHealthFactor(tester);
        emit log_named_uint("Health Factor Before Price Drop", preDropHealthFactor);

        // Simulate price drop to make the position undercollateralized
        vm.startPrank(address(this)); // Prank as the contract deployer to call updateAnswer
        ethPriceFeed.updateAnswer(1000 * 10**8); // Price of WETH drops to $1000
        vm.stopPrank();

        // Check health factor after price drop
        uint256 postDropHealthFactor = coreContract.getHealthFactor(tester);
        emit log_named_uint("Health Factor After Price Drop", postDropHealthFactor);

        vm.startPrank(liquidator);
        coreContract.liquidateUser(tester, address(ethToken), 50000 ether);
        vm.stopPrank();
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import { Script } from "forge-std/Script.sol";
import {DUN} from "../src/DUN.sol";
import {Stablecore} from "../src/DUNCore.sol";
import {CustomERC20} from "../src/MOCKERC.sol";

contract DeployDSC is Script {

    uint privatekey = vm.envUint("PRIVATE_KEY");

    function run() external returns(DUN, Stablecore, address, address, address, address) {
        
        vm.startBroadcast(privatekey);
        CustomERC20 wethMock = new CustomERC20("Wrapped Ether", "WETH");
        CustomERC20 wbtcMock = new CustomERC20("Wrapped Bitcoin", "WBTC");
        
        address wethUsdPriceFeed = 0x5c9C449BbC9a6075A2c061dF312a35fd1E05fF22;
        address wbtcUsdPriceFeed = 0xfdFD9C85aD200c506Cf9e21F1FD8dd01932FBB23;

        DUN dun = new DUN();
        Stablecore stablecore = new Stablecore(address(dun), address(wethMock), address(wbtcMock), wethUsdPriceFeed, wbtcUsdPriceFeed);
        vm.stopBroadcast();

        return (dun, stablecore, address(wethMock), address(wbtcMock), wethUsdPriceFeed, wbtcUsdPriceFeed);
    }
}
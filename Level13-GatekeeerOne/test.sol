//SPDX-License-Identifier: MIT

//The aim of this test file is to find out a suitable gate_key for my player address.

pragma solidity ^0.6.0;

contract test {
    address player = 0xC7005fe8AF6ca11FcC0092D3C4C5C3D883eCE16c; // player address
    uint16 number = 57708; // value of uint16(player)
    bytes8 bytesNumber = 0x00000002540cc56c;
    bytes8 answer = 0x000000010000e16c; //This is the suitable gate_key for our solution. Logged it here to keep track.

    //returns uintn64 of a bytes8. Used to check conversions betweeen the two.
    function act() external view returns (uint64) {
        return uint64(bytesNumber);
    }

    //This is a demo of the checks we have to pass in gatekeeper.
    //Can be run on a VM in Remix and final check can be done on injected web3.
    //If this function returns true then we have found our gate_key.
    function enter(bytes8 _gateKey) public view returns (bool) {
        //For downwards integer typecasting it wraps around the maximum given by the lower integer for example-:
        //uint16(uint32 x) => can be resolved using x % 2^16 . For upwards integer typecast it can be achieved
        //by adding 0s to the left because it is stored in little endian format.
        require(
            //This is effectively uint(x) % 2^32 compared with uint(x) % 2^16;
            uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)),
            "GatekeeperOne: invalid gateThree part one"
        );
        require(
            //This expression is mostly true for all valid inputs except 0 and numbers less than 2^32.
            //Because uint(x) % 2^32 != uint(x) if uint(x) > 2^32. so key needs to be larger than 2^32
            uint32(uint64(_gateKey)) != uint64(_gateKey),
            "GatekeeperOne: invalid gateThree part two"
        );
        require(
            //This can help us figure out a possible key value.
            //We already have uint16(player) which is 57708 so to satisy this equation
            // uint32(uint64(x)) needs to be 57708
            // => uint64(x) % 2^32 = 57708
            // => x = 2^32 + 57708 is one of the values of x which satisfies this.
            //Store this value after typecasting to bytes8.
            uint32(uint64(_gateKey)) == uint16(player),
            "GatekeeperOne: invalid gateThree part three"
        );
        return true;
    }

    //returns bytes8 of a uint64, reverse of act. Used to check conversions betweeen the two.
    function act2(uint64 _number) external view returns (bytes8) {
        return bytes8(_number);
    }
}

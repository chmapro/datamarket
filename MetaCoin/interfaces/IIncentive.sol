// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// IIncentive.sol
interface IIncentive {
    function rewardNode(address node) external payable;
    function getPendingRewards(address node) external view returns (uint256);
    function claimRewards() external;
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// IReputation.sol
interface IReputation {
    function updateReputation(address node, bool isSuccess) external;
    function getReputation(address node) external view returns (uint256);
}


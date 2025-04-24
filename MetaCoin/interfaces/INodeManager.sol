// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// INodeManager.sol
interface INodeManager {
    function registerNode(address node, string memory nodeMetadata) external;
    function isNodeRegistered(address node) external view returns (bool);
    function removeNode(address node) external;
}


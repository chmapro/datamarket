// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// NodeManager.sol
contract NodeManager {
    mapping(address => bool) private nodes;

    function registerNode(address node, string memory metadata) public {
        nodes[node] = true;
    }

    function isNodeRegistered(address node) public view returns (bool) {
        return nodes[node];
    }
}
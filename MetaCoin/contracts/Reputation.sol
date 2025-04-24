// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Reputation.sol
contract Reputation {
    mapping(address => uint256) private reputations;

    function updateReputation(address node, bool success) public {
        if (success) {
            reputations[node] += 1;
        } else {
            reputations[node] -= 1;
        }
    }

    function getReputation(address node) public view returns (uint256) {
        return reputations[node];
    }
}

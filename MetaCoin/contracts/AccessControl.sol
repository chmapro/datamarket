// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// AccessControl.sol
contract AccessControl {
    mapping(bytes32 => mapping(address => bool)) private accessList;

    function grantAccess(bytes32 dataId, address user) public {
        accessList[dataId][user] = true;
    }

    function revokeAccess(bytes32 dataId, address user) public {
        accessList[dataId][user] = false;
    }

    function hasAccess(bytes32 dataId, address user) public view returns (bool) {
        return accessList[dataId][user];
    }
}

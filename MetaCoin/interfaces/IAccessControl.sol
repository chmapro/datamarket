// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// IAccessControl.sol
interface IAccessControl {
    function grantAccess(bytes32 dataId, address user) external;
    function revokeAccess(bytes32 dataId, address user) external;
    function hasAccess(bytes32 dataId, address user) external view returns (bool);
}
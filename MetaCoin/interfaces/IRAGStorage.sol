// File: IRAGStorage.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IRAGStorage {
    function storeData(string calldata _cid) external;
    function validateData(string calldata _cid) external;
    function isDataValidated(string calldata _cid) external view returns (bool);
    function getDataRecord(string calldata _cid) external view returns (address, uint256, bool);
}
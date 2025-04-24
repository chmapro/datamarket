// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// IDataContract.sol
interface IDataContract {
    struct DataRecord {
        string ipfsHash;
        string metadata;
        uint256 timestamp;
        address provider;
    }

    function storeData(bytes32 dataId, string memory ipfsHash, string memory metadata) external;
    function retrieveData(bytes32 dataId) external view returns (DataRecord memory);
}

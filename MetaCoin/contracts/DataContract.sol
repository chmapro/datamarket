// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// DataContract.sol
contract DataContract {
    struct Data {
        string ipfsHash;
        string metadata;
        uint256 timestamp;
        address provider;
    }

    mapping(bytes32 => Data) private dataStorage;

    function storeData(bytes32 dataId, string memory ipfsHash, string memory metadata) public {
        Data memory newData = Data({
            ipfsHash: ipfsHash,
            metadata: metadata,
            timestamp: block.timestamp,
            provider: msg.sender
        });
        dataStorage[dataId] = newData;
    }

    function retrieveData(bytes32 dataId) public view returns (Data memory) {
        return dataStorage[dataId];
    }
}


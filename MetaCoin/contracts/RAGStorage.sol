// File: RAGStorage.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RAGStorage {

    // Data storage structure
    struct DataRecord {
        string cid;          // IPFS Content Identifier (CID)
        address provider;    // Provider's address
        uint256 timestamp;   // Timestamp when data was stored
        bool validated;      // Validation status
    }

    // Storage of data records (CID to data record mapping)
    mapping(string => DataRecord) public dataRecords;

    // Events
    event DataStored(address indexed provider, string cid);
    event DataValidated(string indexed cid, bool validated);

    // Store IPFS data CID on blockchain
    function storeData(string calldata _cid) external {
        require(bytes(_cid).length > 0, "Invalid CID");
        require(dataRecords[_cid].timestamp == 0, "Data already stored");

        dataRecords[_cid] = DataRecord({
            cid: _cid,
            provider: msg.sender,
            timestamp: block.timestamp,
            validated: false
        });

        emit DataStored(msg.sender, _cid);
    }

    // Validate stored data CID
    function validateData(string calldata _cid) external {
        require(dataRecords[_cid].timestamp != 0, "Data not stored");
        require(!dataRecords[_cid].validated, "Already validated");

        dataRecords[_cid].validated = true;

        emit DataValidated(_cid, true);
    }

    // Check validation status of a data record
    function isDataValidated(string calldata _cid) external view returns (bool) {
        require(dataRecords[_cid].timestamp != 0, "Data record not found");
        return dataRecords[_cid].validated;
    }

    // Get details of a data record
    function getDataRecord(string calldata _cid) external view returns (address, uint256, bool) {
        DataRecord memory record = dataRecords[_cid];
        require(record.timestamp != 0, "Data record not found");
        return (record.provider, record.timestamp, record.validated);
    }
}

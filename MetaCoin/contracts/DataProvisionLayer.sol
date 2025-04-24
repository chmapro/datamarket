// File: DataProvisionLayer.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataProvisionLayer {

    // Data provider structure
    struct Provider {
        address providerAddress;
        uint256 reputation;
        bool isActive;
    }

    // Data storage structure
    struct DataRecord {
        string cid;          // IPFS Content Identifier (CID)
        address provider;    // Provider's address
        uint256 timestamp;   // Timestamp when data was stored
    }

    // Storage of providers
    mapping(address => Provider) public providers;

    // Storage of data records (CID to data record mapping)
    mapping(string => DataRecord) public dataRecords;

    // Events
    event ProviderRegistered(address indexed provider);
    event DataStored(address indexed provider, string cid);
    event ReputationUpdated(address indexed provider, uint256 newReputation);
    event DataValidated(string indexed cid, bool validated);

    // Register a new data provider
    function registerProvider() external {
        require(!providers[msg.sender].isActive, "Provider already registered");

        providers[msg.sender] = Provider({
            providerAddress: msg.sender,
            reputation: 1,
            isActive: true
        });

        emit ProviderRegistered(msg.sender);
    }

    // Store IPFS data CID on blockchain
    function storeData(string calldata _cid) external {
        require(providers[msg.sender].isActive, "Not a registered provider");
        require(bytes(_cid).length > 0, "Invalid CID");

        dataRecords[_cid] = DataRecord({
            cid: _cid,
            provider: msg.sender,
            timestamp: block.timestamp
        });

        emit DataStored(msg.sender, _cid);
    }

    // Update provider's reputation (Only contract owner or authorized entities)
    function updateReputation(address _provider, uint256 _newReputation) external {
        require(providers[_provider].isActive, "Provider not active");
        providers[_provider].reputation = _newReputation;

        emit ReputationUpdated(_provider, _newReputation);
    }

    // Get provider's reputation
    function getProviderReputation(address _provider) external view returns (uint256) {
        require(providers[_provider].isActive, "Provider not active");
        return providers[_provider].reputation;
    }

    // Get details of a data record
    function getDataRecord(string calldata _cid) external view returns (address, uint256) {
        DataRecord memory record = dataRecords[_cid];
        require(record.timestamp != 0, "Data record not found");
        return (record.provider, record.timestamp);
    }

    // Data validation mechanism
    mapping(string => mapping(address => bool)) public validations;
    mapping(string => uint256) public validationCounts;
    uint256 public validationThreshold = 3; // Number of validations required

    // Validate data CID
    function validateData(string calldata _cid) external {
        require(providers[msg.sender].isActive, "Not an active provider");
        require(!validations[_cid][msg.sender], "Already validated by this provider");

        validations[_cid][msg.sender] = true;
        validationCounts[_cid] += 1;

        if (validationCounts[_cid] >= validationThreshold) {
            emit DataValidated(_cid, true);
        }
    }

    // Check if data is validated
    function isDataValidated(string calldata _cid) external view returns (bool) {
        return validationCounts[_cid] >= validationThreshold;
    }
}

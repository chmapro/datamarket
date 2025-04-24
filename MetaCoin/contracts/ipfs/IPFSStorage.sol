// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IPFSStorage {
    // 结构体用于存储 IPFS 哈希和其提交者
    struct IPFSData {
        string ipfsHash; // IPFS 哈希（CID）
        address submitter;
        uint256 timestamp;
    }

    // 存储所有上传的 IPFS 数据
    mapping(uint256 => IPFSData) public dataStore;
    uint256 public dataCount = 0;

    // 事件：上传时触发
    event DataSubmitted(uint256 indexed id, string ipfsHash, address indexed submitter);

    // 提交 IPFS 哈希
    function submitIPFSHash(string memory _ipfsHash) public {
        dataStore[dataCount] = IPFSData(_ipfsHash, msg.sender, block.timestamp);
        emit DataSubmitted(dataCount, _ipfsHash, msg.sender);
        dataCount++;
    }

    // 验证是否某个 IPFS 哈希存在
    function verifyHash(string memory _ipfsHash) public view returns (bool found, uint256 id) {
        for (uint256 i = 0; i < dataCount; i++) {
            if (keccak256(abi.encodePacked(dataStore[i].ipfsHash)) == keccak256(abi.encodePacked(_ipfsHash))) {
                return (true, i);
            }
        }
        return (false, 0);
    }

    // 获取指定数据
    function getIPFSHash(uint256 _id) public view returns (string memory, address, uint256) {
        require(_id < dataCount, "Invalid ID");
        IPFSData memory data = dataStore[_id];
        return (data.ipfsHash, data.submitter, data.timestamp);
    }
}

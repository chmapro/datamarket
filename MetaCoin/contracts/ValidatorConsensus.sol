// File: ValidatorConsensus.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ValidatorConsensus {

    // 验证节点的结构
    struct Validator {
        address validatorAddress; // 验证节点地址
        uint256 reputation;       // 验证节点的信誉值
        bool isActive;            // 是否激活
    }

    // 数据点的验证状态结构
    struct ValidationStatus {
        uint256 votes;           // 获得的投票数
        bool isValidated;        // 是否通过验证
        mapping(address => bool) votedValidators; // 记录哪些节点投过票
    }

    // 验证节点映射 (address => Validator)
    mapping(address => Validator) public validators;

    // 数据CID验证状态映射 (cid => ValidationStatus)
    mapping(string => ValidationStatus) private validationStatuses;

    // 共识阈值
    uint256 public consensusThreshold;

    // 事件定义
    event ValidatorRegistered(address indexed validator);
    event ValidatorReputationUpdated(address indexed validator, uint256 newReputation);
    event DataVoteCast(address indexed validator, string indexed cid, uint256 votes);
    event DataValidated(string indexed cid);

    // 构造函数，设置初始共识阈值
    constructor(uint256 _threshold) {
        require(_threshold > 0, "Threshold must be greater than 0");
        consensusThreshold = _threshold;
    }

    // 注册验证节点
    function registerValidator() external {
        require(!validators[msg.sender].isActive, "Validator already registered");

        validators[msg.sender] = Validator({
            validatorAddress: msg.sender,
            reputation: 1,
            isActive: true
        });

        emit ValidatorRegistered(msg.sender);
    }

    // 更新验证节点信誉
    function updateValidatorReputation(address _validator, uint256 _newReputation) external {
        require(validators[_validator].isActive, "Validator not active");
        validators[_validator].reputation = _newReputation;

        emit ValidatorReputationUpdated(_validator, _newReputation);
    }

    // 验证节点对数据CID进行投票验证
    function voteDataValidation(string calldata _cid) external {
        require(validators[msg.sender].isActive, "Not an active validator");
        ValidationStatus storage status = validationStatuses[_cid];

        require(!status.votedValidators[msg.sender], "Already voted on this data");
        require(!status.isValidated, "Data already validated");

        // 记录该节点已投票
        status.votedValidators[msg.sender] = true;
        
        // 增加投票数，投票权重为节点信誉值
        status.votes += validators[msg.sender].reputation;

        emit DataVoteCast(msg.sender, _cid, status.votes);

        // 如果达到共识阈值，则数据被标记为通过验证
        if (status.votes >= consensusThreshold) {
            status.isValidated = true;
            emit DataValidated(_cid);
        }
    }

    // 查询数据CID是否被验证
    function isDataValidated(string calldata _cid) external view returns (bool) {
        return validationStatuses[_cid].isValidated;
    }

    // 查询某个CID当前的投票数
    function getDataVotes(string calldata _cid) external view returns (uint256) {
        return validationStatuses[_cid].votes;
    }

    // 查询某验证节点是否对CID进行过投票
    function hasValidatorVoted(string calldata _cid, address _validator) external view returns (bool) {
        return validationStatuses[_cid].votedValidators[_validator];
    }

    // 修改共识阈值（后续可考虑权限管理，仅Owner调用）
    function updateConsensusThreshold(uint256 _newThreshold) external {
        require(_newThreshold > 0, "Threshold must be greater than 0");
        consensusThreshold = _newThreshold;
    }
}

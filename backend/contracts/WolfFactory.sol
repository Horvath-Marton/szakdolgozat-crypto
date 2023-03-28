// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10 <0.9.0;


import "./Ownable.sol";

contract WolfFactory is Ownable {

    event NewWolf(uint wolfId, string name, string dna);

    uint dnaDigits = 32; 
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    uint bodyCnt = 7;
    uint eyeCnt = 7;
    uint earCnt = 7;
    uint mouthCnt = 7;
    string gen = "01";

    struct Wolf {
        string name;
        string dna;
        uint32 cdtime;
        bool isAdult;
        bool isBreedable;
        //uint price;    
    }

    Wolf[] public wolves;

    mapping (uint => address) public wolfToOwner;
    mapping (address => uint) ownerWolfCount;

    function _createWolf (string memory _name, string memory _dna) internal {
        wolves.push(Wolf(_name, _dna, uint32(block.timestamp + cooldownTime), false, false));
        uint id = wolves.length - 1;
        wolfToOwner[id] = msg.sender;
        ownerWolfCount[msg.sender]++;
        emit NewWolf(id, _name, _dna);
    }
    

    function setGenHigher(uint _body, uint _eye, uint _ear, uint _mouth, string memory _gen) external onlyOwner {
        bodyCnt = _body;
        eyeCnt = _eye;
        earCnt = _ear;
        mouthCnt = _mouth;
        gen = _gen;
    }

}
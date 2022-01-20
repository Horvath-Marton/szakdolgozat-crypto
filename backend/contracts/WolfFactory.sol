// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10 <0.9.0;


import "./ownable.sol";

contract WolfFactory is Ownable {

    event NewWolf(uint wolfId, string name, uint dna);

    uint dnaDigits = 32; 
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Wolf {
        string name;
        uint dna;
        uint cdtime;
        bool isAdult;
        bool isBreedable;
        //uint price;    
    }

    Wolf[] public wolves;

    mapping (uint => address) public wolfToOwner;
    mapping (address => uint) ownerWolfCount;

    function _createWolf (string memory _name, uint _dna) internal {
        wolves.push(Wolf(_name, _dna, uint32(block.timestamp + cooldownTime), false, false));
        uint id = wolves.length - 1;
        wolfToOwner[id] = msg.sender;
        ownerWolfCount[msg.sender]++;
        emit NewWolf(id, _name, _dna);
    }
    
    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomWolf(string memory _name) public {
        require(ownerWolfCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        _createWolf(_name, randDna);
    }

}
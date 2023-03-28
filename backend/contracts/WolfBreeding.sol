// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10 <0.9.0;

import "./WolfFactory.sol";

contract WolfBreeding is WolfFactory {


  function substring(string memory _str, uint _startIndex, uint _endIndex) public pure returns (string memory ) {
    bytes memory strBytes = bytes(_str);
    bytes memory result = new bytes(_endIndex-_startIndex);
    for(uint i = _startIndex; i < _endIndex; i++) {
        result[i-_startIndex] = strBytes[i];
    }
    return string(result);
  }

  function append(string memory _a, string memory _b, string memory _c, string memory _d,
                  string memory _e, string memory _f, string memory _g, string memory _h,
                  string memory _i, string memory _j, string memory _k, string memory _l, 
                  string memory _m, string memory _o, string memory _p, string memory _q) internal pure returns (string memory) {

    return string(abi.encodePacked(_a, _b, _c, _d, _e, _f, _g, _h, _i, _j, _k, _l, _m, _o, _p, _q));

  }

  function generateRandomNumber() public view returns (uint256) {
    uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 101;
    return randomNumber;
  }

  function generateRandomNumberForMutation() public view returns (uint256) {
    uint256 randomNumber = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender))) % 4;
    return randomNumber;
  }

  function uint2str(uint256 _i) internal pure returns (string memory str) {
    if (_i == 0) { return "0"; }
    uint256 j = _i;
    uint256 length;

    while (j != 0)
    {
      length++;
      j /= 10;
    }

    bytes memory bstr = new bytes(length);
    uint256 k = length;
    j = _i;

    while (j != 0)
    {
      bstr[--k] = bytes1(uint8(48 + j % 10));
      j /= 10;
    }

    str = string(bstr);
  } 

  function string2uint(string memory s) public pure returns (uint) {
        bytes memory b = bytes(s);
        uint result = 0;

        for (uint256 i = 0; i < b.length; i++) {
            uint256 c = uint256(uint8(b[i]));
            if (c >= 48 && c <= 57) {
                result = result * 10 + (c - 48);
            }
        }

        return result;
    }
    
  function _triggerCooldown(Wolf storage _wolf) internal {
    _wolf.cdtime = uint32(block.timestamp + cooldownTime);
  }

  function _isReady(Wolf storage _wolf) internal view returns (bool) {
      return (_wolf.cdtime <= block.timestamp);
  }

  function _createNewDNA(string memory _ourWolfDna, string memory _partnerWolfDna) private view returns (string memory ) {
    
    string memory mainBody = _random6Dna(substring(_ourWolfDna, 0, 2), substring(_partnerWolfDna, 0, 2),
               substring(_ourWolfDna, 2, 4), substring(_partnerWolfDna, 2, 4), 
               substring(_ourWolfDna, 4, 6), substring(_partnerWolfDna, 4, 6));
    string memory hiddenBody1 = _random6Dna(substring(_ourWolfDna, 0, 2), substring(_partnerWolfDna, 0, 2),
               substring(_ourWolfDna, 2, 4), substring(_partnerWolfDna, 2, 4), 
               substring(_ourWolfDna, 4, 6), substring(_partnerWolfDna, 4, 6));
    string memory hiddenBody2 = _random6Dna(substring(_ourWolfDna, 0, 2), substring(_partnerWolfDna, 0, 2),
               substring(_ourWolfDna, 2, 4), substring(_partnerWolfDna, 2, 4), 
               substring(_ourWolfDna, 4, 6), substring(_partnerWolfDna, 4, 6));

    string memory color1 = _random2Dna(substring(_ourWolfDna, 6, 8),substring(_partnerWolfDna, 6, 8));
    string memory color2 = _random2Dna(substring(_ourWolfDna, 8, 10),substring(_partnerWolfDna, 8, 10));

    string memory mainEye = _random6Dna(substring(_ourWolfDna, 10, 12), substring(_partnerWolfDna, 10, 12),
               substring(_ourWolfDna, 12, 14), substring(_partnerWolfDna, 12, 14), 
               substring(_ourWolfDna, 14, 16), substring(_partnerWolfDna, 14, 16));
    string memory hiddenEye1 = _random6Dna(substring(_ourWolfDna, 10, 12), substring(_partnerWolfDna, 10, 12),
               substring(_ourWolfDna, 12, 14), substring(_partnerWolfDna, 12, 14), 
               substring(_ourWolfDna, 14, 16), substring(_partnerWolfDna, 14, 16));
    string memory hiddenEye2 = _random6Dna(substring(_ourWolfDna, 10, 12), substring(_partnerWolfDna, 10, 12),
               substring(_ourWolfDna, 12, 14), substring(_partnerWolfDna, 12, 14), 
               substring(_ourWolfDna, 14, 16), substring(_partnerWolfDna, 14, 16));

    string memory colorEye = _random2Dna(substring(_ourWolfDna, 16, 18),substring(_partnerWolfDna, 16, 18));

    string memory mainEar = _random6Dna(substring(_ourWolfDna, 18, 20), substring(_partnerWolfDna, 18, 20),
               substring(_ourWolfDna, 20, 22), substring(_partnerWolfDna, 20, 22), 
               substring(_ourWolfDna, 22, 24), substring(_partnerWolfDna, 22, 24));
    string memory hiddenEar1 = _random6Dna(substring(_ourWolfDna, 18, 20), substring(_partnerWolfDna, 18, 20),
               substring(_ourWolfDna, 20, 22), substring(_partnerWolfDna, 20, 22), 
               substring(_ourWolfDna, 22, 24), substring(_partnerWolfDna, 22, 24));
    string memory hiddenEar2 = _random6Dna(substring(_ourWolfDna, 18, 20), substring(_partnerWolfDna, 18, 20),
               substring(_ourWolfDna, 20, 22), substring(_partnerWolfDna, 20, 22), 
               substring(_ourWolfDna, 22, 24), substring(_partnerWolfDna, 22, 24));

    string memory mainMouth = _random6Dna(substring(_ourWolfDna, 24, 26), substring(_partnerWolfDna, 24, 26),
               substring(_ourWolfDna, 26, 28), substring(_partnerWolfDna, 26, 28), 
               substring(_ourWolfDna, 28, 30), substring(_partnerWolfDna, 28, 30));
    string memory hiddenMouth1 = _random6Dna(substring(_ourWolfDna, 24, 26), substring(_partnerWolfDna, 24, 26),
               substring(_ourWolfDna, 26, 28), substring(_partnerWolfDna, 26, 28), 
               substring(_ourWolfDna, 28, 30), substring(_partnerWolfDna, 28, 30));
    string memory hiddenMouth2 = _random6Dna(substring(_ourWolfDna, 24, 26), substring(_partnerWolfDna, 24, 26),
               substring(_ourWolfDna, 26, 28), substring(_partnerWolfDna, 26, 28), 
               substring(_ourWolfDna, 28, 30), substring(_partnerWolfDna, 28, 30));

    string memory gen;

    if(string2uint(substring(_ourWolfDna, 30, 32)) < string2uint(substring(_partnerWolfDna, 30, 32))) {
      gen = substring(_ourWolfDna, 30, 32);
    } else {
      substring(_partnerWolfDna, 30, 32);
    }

    return append(mainBody, hiddenBody1, hiddenBody2,
                  color1, color2, 
                  mainEye, hiddenEye1, hiddenEye2, colorEye,
                  mainEar, hiddenEar1, hiddenEar2, mainMouth,
                  hiddenMouth1, hiddenMouth2, gen);
  }

  function _random6Dna(string memory _a, string memory _b, string memory _c, string memory _d, string memory _e, string memory _f) 
  private view returns (string memory ) { 
    uint rand = generateRandomNumber();
    if (rand <= 25) {
      return _a;
    } else if (rand <= 50) {
      return _b;
    } else if (rand <= 62) {
      return _c;
    } else if (rand <= 74) {
      return _d;
    } else if (rand <= 86) {
      return _e;
    } else if (rand <= 98) {
      return _f;
    } else {
      return uint2str(generateRandomNumberForMutation());
    }
  }

  function _random2Dna(string memory _a, string memory _b) private view returns (string memory ) { 
    uint rand = generateRandomNumber();
    if (rand <= 50) {
      return _a;
    } else {
      return _b;
    }
  }

  function breedWolves(uint _wolfId, string memory _partnerDna) internal  {
    require(msg.sender == wolfToOwner[_wolfId]);
    Wolf storage myWolf = wolves[_wolfId];
    require(_isReady(myWolf));
    string memory newDna= _createNewDNA(myWolf.dna, _partnerDna);
    _createWolf("NewWolf", newDna);
    _triggerCooldown(myWolf);
  }
  
  function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomWolf(string memory _name) public {
        require(ownerWolfCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
    }


}
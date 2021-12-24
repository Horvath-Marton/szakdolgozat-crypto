pragma solidity >=0.8.10 <0.9.0;

import "./WolfFactory.sol";

contract WolfBreeding is WolfFactory {
    
    function breedWolves(uint _wolfId, uint _partnerDna) public {
    require(msg.sender == wolfToOwner[_wolfId]);
    Wolf storage myWolf = wolves[_wolfId];
    _partnerDna = _partnerDna % dnaModulus;
    uint newDna = (myWolf.dna + _partnerDna) / 2;
    _createWolf("NewWolf", newDna);
  }
}
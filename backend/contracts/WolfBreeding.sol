// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10 <0.9.0;

import "./WolfFactory.sol";

contract WolfBreeding is WolfFactory {
    
  function _triggerCooldown(Wolf storage _wolf) internal {
    _wolf.cdtime = uint32(block.timestamp + cooldownTime);
  }

  function _isReady(Wolf storage _wolf) internal view returns (bool) {
      return (_wolf.cdtime <= block.timestamp);
  }

  function breedWolves(uint _wolfId, uint _partnerDna) internal  {
    require(msg.sender == wolfToOwner[_wolfId]);
    Wolf storage myWolf = wolves[_wolfId];
    require(_isReady(myWolf));
    _partnerDna = _partnerDna % dnaModulus;
    uint newDna = (myWolf.dna + _partnerDna) / 2;
    _createWolf("NewWolf", newDna);
    _triggerCooldown(myWolf);
  }


}
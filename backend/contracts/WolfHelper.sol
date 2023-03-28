// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10 <0.9.0;

import "./WolfBreeding.sol";

contract WolfHelper is WolfBreeding {

    uint growUpFee = 0.001 ether;
    
    function setGrowUpFee(uint _fee) external onlyOwner {
      growUpFee = _fee;
    }

    
    function withdraw() external onlyOwner {
    address payable _owner = payable(owner());
    _owner.transfer(address(this).balance);

    } 

    modifier isNotAdult(uint _wolfId) {
        require(wolves[_wolfId].isAdult == false);
        _;
    }


    function changeName(uint _wolfId, string calldata _newName) external isNotAdult(_wolfId){
        require(msg.sender == wolfToOwner[_wolfId]);
        wolves[_wolfId].name = _newName;
    }    
    
    function growUp(uint _wolfId) external isNotAdult(_wolfId) {
        require(msg.sender == wolfToOwner[_wolfId]);
        Wolf storage myWolf = wolves[_wolfId];
        require(_isReady(myWolf));
        wolves[_wolfId].isAdult = true;
    } 

    function growUpNow(uint _wolfId) external payable isNotAdult(_wolfId){
      require(msg.value == growUpFee);
      wolves[_wolfId].isAdult = true;
    }

    function setBreedable(uint _wolfId) external{
      require(msg.sender == wolfToOwner[_wolfId]);
      Wolf storage myWolf = wolves[_wolfId];
      require(_isReady(myWolf));
      wolves[_wolfId].isBreedable = !(wolves[_wolfId].isBreedable);
      _triggerCooldown(wolves[_wolfId]);
    }

    function getWolvesByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerWolfCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < wolves.length; i++) {
      if (wolfToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }
  
}
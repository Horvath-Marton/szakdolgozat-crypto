// SPDX-License-Identifier: MIT
pragma solidity >=0.8.10 <0.9.0;

import "./WolfHelper.sol";
import "./erc721.sol";

contract WolfOwnership is WolfHelper, ERC721 {

  mapping (uint => address) wolfApprovals;

  function balanceOf(address _owner) external view override returns (uint256) {
    return ownerWolfCount[_owner];
  }

  function ownerOf(uint256 _tokenId) external view override returns (address) {
    return wolfToOwner[_tokenId];
  }

    function _transfer(address _from, address _to, uint256 _tokenId) private {
    ownerWolfCount[_to]++;
    ownerWolfCount[_from]--;
    wolfToOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);
  }
  
  function transferFrom(address _from, address _to, uint256 _tokenId) external payable override {
    require (wolfToOwner[_tokenId] == msg.sender || wolfApprovals[_tokenId] == msg.sender);
    _transfer(_from, _to, _tokenId);
  }

  function approve(address _approved, uint256 _tokenId) external payable override{
    wolfApprovals[_tokenId] = _approved;
    emit Approval(msg.sender, _approved, _tokenId);
  }
}
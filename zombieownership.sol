pragma solidity >=0.4.22 <0.9.0;

import "./zombieattack.sol";
import "./erc721.sol";

contract ZombieOwnership is ZombieAttack, ERC721 {

//returns how many zombies held by user
  function balanceOf(address _owner) external view returns (uint256) {
    return ownerZombieCount[_owner];
  }

  function ownerOf(uint256 _tokenId) external view returns (address) {
    return zombieToOwner[_tokenId];
  }

  function transferFrom(address _from, address _to, uint256 _tokenId) external payable {

  }

  function approve(address _approved, uint256 _tokenId) external payable {

  }

}
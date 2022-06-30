pragma solidity >=0.4.22 <0.9.0;

import "./zombieattack.sol";
import "./erc721.sol";


//to allow zombies to be tranfered as tokens
//check token ownership
//transfer tokens to new owner
//verify token ownership before transacting
contract ZombieOwnership is ZombieAttack, ERC721 {

  // mapping for adding approved address
  mapping (uint => address) zombieApprovals;

  //returns how many zombies held by user
  function balanceOf(address _owner) external view returns (uint256) {
    return ownerZombieCount[_owner];
  }

  //returns the zombie address at index(for zombie index in mapping)
  function ownerOf(uint256 _tokenId) external view returns (address) {
    return zombieToOwner[_tokenId];
  }

  //this is how we transfer a token btwn users
  function _transfer(address _from, address _to, uint256 _tokenId) private {
    //update ZombieCount of the reciever
    ownerZombieCount[_to]++;
    //update ZombieCount of the sender
    ownerZombieCount[_from]--;
    //reassigning owner address in our zombieToOwner mapping
    zombieToOwner[_tokenId] = _to;
    //ERC721 standard event emitter
    emit Transfer(_from, _to, _tokenId);
  }

    function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
      //checks if sender is allowed to transfer token/zombie
    require (zombieToOwner[_tokenId] == msg.sender || zombieApprovals[_tokenId] == msg.sender);
    _transfer(_from, _to, _tokenId);
  }

  //this is how we approve a user to transfer a token
  //we add modifiers to make sure only the owner can approve
   function approve(address _approved, uint256 _tokenId) external payable  onlyOwnerOf(_tokenId){
    // add the approved address to the approved zombiesID => Address mapping
    zombieApprovals[_tokenId] = _approved;
     //Fire the Approval event here (ERC721 standard)
     emit Approval(msg.sender, _approved, _tokenId);
  }

}
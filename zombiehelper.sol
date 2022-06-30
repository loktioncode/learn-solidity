//making our own modifier that uses
//the zombie level property to restrict access to special abilities.

pragma solidity >=0.4.22 <0.9.0;

import "./advanced-zombie-feeding.sol";

contract ZombieHelper is ZombieFeeding {

    uint levelUpFee = 0.001 ether;

    //function to pay a fee to level up a zombie
    function levelUp(uint _zombieId) external payable {
        //checks if sent eth is enough
        require(msg.value == levelUpFee);
        zombies[_zombieId].level++;
    }

     // 1. Create withdraw function here
    function withdraw() external onlyOwner {
        address payable _owner = address(uint160(owner()));
        _owner.transfer(address(this).balance);
    }

  // 2. Create setLevelUpFee function here
  //for controlling the levelUpFee
    function setLevelUpFee(uint _fee) external onlyOwner {
        levelUpFee = _fee;
    }

    //checks if zombbie is above/higher than level
    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }
    
    //update name of zombie if level is 2
    //we use the modifier to do so
    //use onlyOwnerOf modifier to check owner of zombie
    function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) onlyOwnerOf(_zombieId) {
        // require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].name = _newName;
    }

    //use onlyOwnerOf modifier to check owner of zombie
    //we have two modifiers aboveLevel and onlyOwnerOf
    //aboveLevel is used to check if the zombie is above/higher than the level and update Zombie DNA
    function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) onlyOwnerOf(_zombieId) {
        // require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }
    
     function getZombiesByOwner(address _owner) external view returns(uint[] memory) {
        //memory array can not be resized 
        //so we get the count of zombies owner owns
        uint count = zombieToOwner.count(_owner);
        uint[] memory result = new uint[](count);

        //to track results array
        uint counter = 0;
        //loop thru all zombies array in ZombieFactory
        for (uint index = 0; index < zombies.length; index++){
            //if zombie owner is the same as _owner
            if (zombieToOwner[index] == _owner){
                //add zombie at position counter to result array
                result[counter] = index;
                //move index position to next in result array
                counter++;
            }
        }
        // Start here
        return result;
    }
}

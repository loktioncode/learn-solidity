pragma solidity >=0.5.0 <0.6.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
    // Start here
    uint randNonce = 0;

    //adding some randomness to our code to calculate battle outcome
    function randMod(uint _modulus) internal returns (uint) {
        randNonce++;
        return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
    }

    // 1. Define `_attack` function here
    //note use of ownerOf to check if the zombie we want to attack with is owned by the sender/user
  function attack(uint _zombieId, uint _targetId) external ownerOf(_zombieId) {
    //create storage pointer to easily access our zombies
    Zombie storage myZombie = zombies[_zombieId];
    Zombie storage enemyZombie = zombies[_targetId];
    //create a random number 
    uint rand = randMod(100);
  }
}

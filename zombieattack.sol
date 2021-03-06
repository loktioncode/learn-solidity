pragma solidity >=0.4.22 <0.9.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
    // Start here
    uint randNonce = 0;

    //adding some randomness to our code to calculate battle outcome
    function randMod(uint _modulus) internal returns (uint) {
        // randNonce++;
        randNonce = randNonce.add(1);
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

    //check if random number is less than 70, if so, myZombie wins
    if (rand <= attackVictoryProbability) {

      //increment myZombie's win/level count
      myZombie.winCount = myZombie.winCount.add(1);
      myZombie.level = myZombie.level.add(1);
      enemyZombie.lossCount = enemyZombie.lossCount.add(1);

      //when it wins it feeds and multiplies then coolsdown time by 1 day
      feedAndMultiply(_zombieId, enemyZombie.dna, "zombie");
    } else {
        //if it loses its loss count increments by 1
        //and enemy zombie wins 
        myZombie.lossCount = myZombie.lossCount.add(1);
        enemyZombie.winCount = enemyZombie.winCount.add(1);
   
      //cool down zombie after loss
      _triggerCooldown(myZombie);
    }
  }


}

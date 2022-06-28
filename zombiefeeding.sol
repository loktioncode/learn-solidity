pragma solidity >=0.5.0 <0.6.0;

// put import statement here
import "./zombiefactory.sol";

//accessing functions in other blockchain contracts
//we need an Interface to do so
contract KittyInterface {
    function getKitty(uint256 _id)
        external
        view
        returns (
            bool isGestating,
            bool isReady,
            uint256 cooldownIndex,
            uint256 nextActionAt,
            uint256 siringWithId,
            uint256 birthTime,
            uint256 matronId,
            uint256 sireId,
            uint256 generation,
            uint256 genes
        );
}

//INHERITANCE
//can access all public functions in zombie factory 2
contract ZombieFeeding is ZombieFactory {
    //we can use the external kitties contract using the address
    // of the contract we want to access
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    //initiate contract with address of external contract
    KittyInterface kittyContract = KittyInterface(ckAddress);

    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
        //verify zombie owner in mapping from parent zombiefactory2.sol
        //so we dnt feed on our own zombie
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        // start here
    }
}

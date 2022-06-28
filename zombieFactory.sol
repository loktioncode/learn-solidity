ragma solidity >=0.5.0 <0.6.0;
import "./ownable.sol";

contract ZombieFactory is Ownable {

    // declare our event
    //can be used to see if function fired by dapp
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie {
        string name;
        uint dna;
        //save gas
        uint32 level;
        uint32 readyTime;
    }

    Zombie[] public zombies;

    function _createZombie(string memory _name, uint _dna) private {
        //getting the position of the current added zombie
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // and fire it here
        emit NewZombie(id, _name, _dna)
    }

    function _generateRandomDna(string memory _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}

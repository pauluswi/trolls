pragma solidity ^0.4.25;

contract TrollFactory {

    event NewTroll(uint trollId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Troll {
        string name;
        uint dna;
    }

    Troll[] public trolls;

    mapping (uint => address) public trollToOwner;
    mapping (address => uint) ownerTrollCount;

    function _createTroll(string _name, uint _dna) internal {
        uint id = trolls.push(Troll(_name, _dna)) - 1;
        trollToOwner[id] = msg.sender;
        ownerTrollCount[msg.sender]++;
        emit NewTroll(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomTroll(string _name) public {
        require(ownerTrollCount[msg.sender] == 0);
        uint randDna = _generateRandomDna(_name);
        randDna = randDna - randDna % 100;
        _createTroll(_name, randDna);
    }

}

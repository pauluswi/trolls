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

    function _createTroll(string _name, uint _dna) private {
        uint id = trolls.push(Troll(_name, _dna)) - 1;
        emit NewTroll(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomTroll(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createTroll(_name, randDna);
    }

}

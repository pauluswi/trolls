pragma solidity ^0.4.25;
import "./trollfactory.sol";
contract KatzeInterface {
  function getKatze(uint256 _id) external view returns (
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
contract TrollFeeding is TrollFactory {

  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  KatzeInterface kittyContract = KatzeInterface(ckAddress);

  function feedAndMultiply(uint _trollId, uint _targetDna, string _species) public {
    require(msg.sender == trollToOwner[_trollId]);
    Troll storage myTroll = trolls[_trollId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myTroll.dna + _targetDna) / 2;
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("katze"))) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createTroll("NoName", newDna);
  }

  function feedOnKatze(uint _trollId, uint _katzeId) public {
    uint katzeDna;
    (,,,,,,,,,katzeDna) = katzeContract.getKatze(_katzeId);
    feedAndMultiply(_trollId, katzeDna, "katze");
  }

}

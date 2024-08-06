// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BatleTokenWar is ERC721 {

    struct BatleToken {
        string name;
        uint level;
        string img;
    }

    BatleToken[] public BatleTokens;
    address public gameOwner;

    constructor () ERC721 ("BatleTokenWar", "BTT") {

        gameOwner = msg.sender;

    } 

    modifier onlyOwnerOf(uint _monsterId) {

        require(ownerOf(_monsterId) == msg.sender,"Apenas o dono pode batalhar com este BatleToken");
        _;

    }

    function battle(uint _attackingBatleToken, uint _defendingBatleToken) public onlyOwnerOf(_attackingBatleToken) {
        BatleToken storage attacker = BatleTokens[_attackingBatleToken];
        BatleToken storage defender = BatleTokens[_defendingBatleToken];

         if (attacker.level >= defender.level) {
            attacker.level += 2;
            defender.level += 1;
        }else{
            attacker.level += 1;
            defender.level += 2;
        }
    }

    function createNewBatleToken(string memory _name, address _to, string memory _img) public {
        require(msg.sender == gameOwner, "Apenas o dono do jogo pode criar novos BatleTokens");
        uint id = BatleTokens.length;
        BatleTokens.push(BatleToken(_name, 1,_img));
        _safeMint(_to, id);
    }

}

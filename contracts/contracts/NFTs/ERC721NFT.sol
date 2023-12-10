// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract QuestNFT is ERC721, ERC721URIStorage, Ownable {
    uint256 private _tokenId;

    struct Question {
        string question;
        string answer;
    }

    mapping(uint256 => Question) public tokenIdQuiz;

    constructor(address initialOwner)
        ERC721("Quest Hoodie", "QH")
        Ownable(initialOwner) 
        {}

    function totalSupply() public view returns (uint256) {
        return _tokenId;
    }

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function safeMint(address to, string memory question, string memory answer) public onlyOwner {
        _tokenId++;
        _safeMint(to, _tokenId);
        _setTokenURI(_tokenId, "https://gateway.lighthouse.storage/ipfs/QmUrNyqCEa8nErStkPGp479AkZGeSMqJbjwDYhqF7YR6JN");
       
    }
}
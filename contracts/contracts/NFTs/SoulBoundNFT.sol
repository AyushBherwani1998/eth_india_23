// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SoulBoundNFT is ERC721, ERC721URIStorage, Ownable {
    uint256 private _tokenId;

    constructor(address initialOwner, string memory _tokenName, string memory _tokenSymbol)
        ERC721(_tokenName, _tokenSymbol)
        Ownable(initialOwner) 
        {}

     function _update(address to, uint256 tokenId, address auth)
        internal
        override virtual returns (address)
    {
        address from = _ownerOf(tokenId);
        require(from == address(0), "Token not transferable");
        super._update(to, tokenId, auth);
        return from;
    }

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

    function safeMint(address to, string memory uri) public onlyOwner {
        _tokenId++;
        _safeMint(to, _tokenId);
        _setTokenURI(_tokenId, uri);
    }
}
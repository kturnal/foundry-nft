// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721 {

    uint256 private s_tokenCounter;

    constructor() ERC721("Duckie", "DUCK") {
        s_tokenCounter = 0;
    }

    function mintNft() public {}

    //Universal Resource Identifier for the NFT. Basically, where all the required metadata is stored.
    function tokenURI(uint256 tokenId) public view override returns (string memory){
        
    }

}
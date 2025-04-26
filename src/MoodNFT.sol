// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {

    error MoodNft__CantSetMoodIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory happySvgImageUri, string memory sadSvgImageUri) ERC721("Mood NFT", "MN"){
        s_tokenCounter = 0;
        s_happySvgImageUri = happySvgImageUri;
        s_sadSvgImageUri = sadSvgImageUri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        if(getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender){
            revert MoodNft__CantSetMoodIfNotOwner();
        }

        if(s_tokenIdToMood[tokenId] == Mood.SAD){
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        } else {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory){
        // An example .json as tokenURI should look like this:
        // {"name": "Mood NFT"}
        // {"description": "Mood Reflecting NFT"}
        // {"attributes": [{"trait_type": "moodiness", "value": "100"}]}
        // {"image": "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAiIGhlaWdodD0iMTAwIj4KICAgIDxjaGF0dCBmaWxsPSJyZWQiIGQ9Ik0wIDBoMTAwdjEwMEgweiIvPgo8L3N2Zz4K"}

        string memory imageUri;

        if(s_tokenIdToMood[tokenId] == Mood.SAD){
            imageUri = s_sadSvgImageUri;
        } else {
            imageUri = s_happySvgImageUri;
        }

        return string(
            abi.encodePacked(_baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name: "',
                            name(),
                            '", description: "Mood Reflecting NFT", "attributes": [{"trait_type": "Moodiness", "value": 100}], "image":', imageUri,
                            '"}'
                        )
                    )
                )
            )
        );

        /*
        If you want to see the JSON in a more readable format, you can use the following code:
        string memory tokenMetadata2 = string.concat(
        "{\n",
        '  "name": "',     name(),    '",\n',
        '  "description": "Mood Reflecting NFT",\n',
        '  "attributes": [\n',
        '    { "trait_type": "Moodiness", "value": 100 }\n',
        '  ],\n',
        '  "image": "',    imageUri,  '"\n',
        "}"
        );
        */

    }
}
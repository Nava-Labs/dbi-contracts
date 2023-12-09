// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {Strings} from "openzeppelin-contracts/contracts/utils/Strings.sol";
import {ERC721A} from "erc721a/ERC721A.sol";
import {SignatureVerification} from "./utils/SignatureVerification.sol";

error Minted();

contract DBIPOAP is Ownable, ERC721A, SignatureVerification {
    using Strings for uint256;

    string public baseURI;

    constructor(string memory name, string memory symbol, string memory _uri) 
        ERC721A(name, symbol) 
        SignatureVerification("DBI", "1.0.0") 
    {
        baseURI = _uri;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function _startTokenId() internal pure override returns (uint256) {
        return 1;
    }

    function setBaseURI(string memory _uri) external onlyOwner {
        baseURI = _uri;
    }

    function tokenURI(uint256 tokenId) 
        public 
        view 
        override 
        returns (string memory) 
    {
        return bytes(_baseURI()).length != 0 ? string(abi.encodePacked(baseURI, _toString(tokenId), "")) : '';
    }

    function mint(bytes calldata signature) external payable isValidSigner(signature) {
        if (_numberMinted(msg.sender) > 0) {
            revert Minted();
        }
        _mint(msg.sender, 1);
    }
}

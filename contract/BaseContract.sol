// SPDX-License-Identifier: MIT
// BaseContract smart contract v1.0

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./IBaseContract.sol";

contract BaseContract is IBaseContract, ERC721, ERC721Enumerable, Pausable, Ownable, ERC721Burnable {
    using Counters for Counters.Counter;
    using SafeMath for uint256;

    Counters.Counter private _tokenIdCounter;

    string private _baseTokenURI;
    uint256 public _mintPrice = 0;
    uint256 public _discountMintPrice = 0;
    uint256 public _maxSupply = 0;
    uint256 public _maxMintAmount = 0;
    bool public _isPaused;
    
    constructor() ERC721("BaseContract", "BASE") {}

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        whenNotPaused
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    function renounceOwnership() public pure override {
        revert("Can't renouce ownership of this smart contract.");
    }

     // Only Owner Functions
    function setBaseURI(string memory newBaseTokenURI) public onlyOwner {
        _baseTokenURI = newBaseTokenURI;
    }

    function setMintPrice(uint256 newMintPrice) public onlyOwner {
        _mintPrice = newMintPrice;
    }

    function setMaxMintAmount(uint256 newMaxMintAmount) public onlyOwner {
        _maxMintAmount = newMaxMintAmount;
    }

    function setIsPaused(bool state) public onlyOwner {
        _isPaused = state;
    }

    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No ether left to withdraw");
        payable(msg.sender).transfer(balance);
    }

    function withdrawToken(address tokenContractAddress, uint256 amount) public onlyOwner {
        require(amount > 0, "Amount to withdraw must be greater than zero");
        IERC20 tokenContract = IERC20(tokenContractAddress);
        tokenContract.transfer(msg.sender, amount);
    }
}
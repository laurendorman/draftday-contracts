pragma solidity ^0.8.0;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract DraftDayNFT is ERC721URIStorage {
  // Magic given to us by OpenZeppelin to help us keep track of tokenIds.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  event DraftDayNFTMinted(address sender, uint256 tokenId);

  // We need to pass the name of our NFTs token and it's symbol.
  constructor() ERC721 ("Draft Day", "DRAFT") {
  }

  // A function our user will hit to get their NFT.
  function mint() public {
     // Get the current tokenId, this starts at 0.
    uint256 newItemId = _tokenIds.current();

     // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);

    // Set the NFTs data.
    _setTokenURI(newItemId, "data:application/json;base64,eyJuYW1lIjoiRHJhZnQgRGF5IiwiZGVzY3JpcHRpb24iOiJQbGF5IHRvIG1pbnQgeW91ciBmaXJzdCBORlQgYW5kIGJlIGRyYWZ0ZWQgaW50byB0aGUgYmlnIGxlYWd1ZS4iLCJpbWFnZSI6Imh0dHBzOi8vaGVhdGluZ3VwLmNvL2ltYWdlcy9waXhlbC1iYXNrZXRiYWxsLW9uLWZpcmUuZ2lmIiwiYXR0cmlidXRlcyI6W3sidHJhaXRfdHlwZSI6IkxldmVsIiwidmFsdWUiOiIxIn0seyJ0cmFpdF90eXBlIjoiQ29hY2giLCJ2YWx1ZSI6IkxhdXJlbiJ9XX0=");
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();

    // Emit Draft Day NFT
    emit DraftDayNFTMinted(msg.sender, newItemId);
  }
}
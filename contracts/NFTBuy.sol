// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {IERC20} from '@openzeppelin/contracts/token/ERC20/IERC20.sol';


contract NFTBuy is ERC721URIStorage, Ownable {
         event NftBought(address _seller, address _buyer, uint256 _price);

    
    constructor(address owner) Ownable(owner) ERC721("Quecko NFT", "QNft") {}

    uint256 public _tokenIds;
    mapping (uint256 => uint256) public tokenIdToPrice;
    mapping (uint256 => address) public tokenIdToTokenAddress;
   
    function mint( address recipient , string memory _tokenURI) public returns (uint256) {

        if (_tokenIds < 10) {

            _tokenIds += 1;

            uint256 newItemId = _tokenIds;

            _mint(recipient, newItemId);
            _setTokenURI(newItemId, _tokenURI);
            return newItemId;

        } else {
            revert("Token limit exceeded");
        }
    }

    function burn(uint256 _tokenId) public {
        _burn(_tokenId);
    }

     function buy(uint256 _tokenId) external payable {
        uint256 price = tokenIdToPrice[_tokenId];
        address seller = ownerOf(_tokenId);
        // address tokenAddress = tokenIdToTokenAddress[_tokenId];
            payable(seller).transfer(msg.value);
        
        _transfer(seller, msg.sender, _tokenId);
        tokenIdToPrice[_tokenId] = 0;
     

        emit NftBought(seller, msg.sender, msg.value);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/NFTMarketPlace.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MockNFT is ERC721 {
    constructor() ERC721("MockNFT", "MNFT") {}

    function mint(address to, uint256 tokenId) external {
        _mint(to, tokenId);
    }
}

contract NFTMarketplaceTest is Test {
    NFTMarketplace public marketplace;
    MockNFT public nft;
    address seller;
    address buyer;

    function setUp() public {
        seller = address(1);
        buyer = address(2);
        vm.prank(seller);
        marketplace = new NFTMarketplace();
        nft = new MockNFT();

        vm.prank(seller);
        nft.mint(seller, 1);

        vm.prank(seller);
        nft.setApprovalForAll(address(marketplace), true);
    }

    function testListNFT() public {
        vm.prank(seller);
        marketplace.listNFT(address(nft), 1, 1 ether);
        (address listedSeller, , , uint256 price, bool isActive) = marketplace.listings(1);
        assertEq(listedSeller, seller);
        assertEq(price, 1 ether);
        assertTrue(isActive);
    }

    function testBuyNFT() public {
        vm.prank(seller);
        marketplace.listNFT(address(nft), 1, 1 ether);

        vm.prank(buyer);
        vm.deal(buyer, 1 ether);
        vm.prank(buyer);
        marketplace.buyNFT{value: 1 ether}(1);

        assertEq(nft.ownerOf(1), buyer);
    }

    function testWithdrawFunds() public {
        vm.prank(seller);
        marketplace.listNFT(address(nft), 1, 1 ether);

        vm.prank(buyer);
        vm.deal(buyer, 1 ether);
        vm.prank(buyer);
        marketplace.buyNFT{value: 1 ether}(1);

        vm.prank(seller);
        marketplace.withdrawFunds();

        assertEq(seller.balance, 1 ether);
    }
}

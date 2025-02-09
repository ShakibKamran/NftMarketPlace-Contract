# NFT Marketplace

## Overview
The NFT Marketplace is a smart contract that allows users to list, buy, and auction NFTs on the Ethereum blockchain. It supports ERC-721 tokens and ensures security using OpenZeppelin's ReentrancyGuard and Ownable modules.

## Features
- **List NFTs**: Sellers can list their NFTs for sale.
- **Buy NFTs**: Buyers can purchase NFTs directly by paying the specified price.
- **Delist NFTs**: Sellers can remove their NFTs from the marketplace.
- **Auction NFTs**: Sellers can start an auction with a starting price and duration.
- **Bid on Auctions**: Users can place bids on listed auctions.
- **End Auctions**: Sellers or marketplace owners can end an auction, transferring the NFT to the highest bidder.
- **Withdraw Funds**: Sellers and bidders can withdraw their earnings securely.

## Smart Contract Details
- **Solidity Version**: 0.8.19
- **Dependencies**:
  - OpenZeppelin Contracts
  - ERC-721 Interface
  - ReentrancyGuard for security
  - Ownable for access control

## Deployment & Testing with Foundry

### Install Foundry
```sh
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### Compile the Contract
```sh
forge build
```

### Run Tests
```sh
forge test
```

### Deploy the Contract
```sh
forge script script/deploy.s.sol --broadcast --rpc-url <YOUR_RPC_URL>
```

## Smart Contract Functions
### 1. Listing NFTs
```solidity
function listNFT(address nftContract, uint256 tokenId, uint256 price) external;
```
- Requires approval for the marketplace to manage the NFT.

### 2. Buying NFTs
```solidity
function buyNFT(uint256 listingId) external payable;
```
- Transfers ownership of the NFT to the buyer.
- Payment is stored for the seller to withdraw.

### 3. Auctions
```solidity
function createAuction(address nftContract, uint256 tokenId, uint256 startPrice, uint256 duration) external;
function placeBid(uint256 auctionId) external payable;
function endAuction(uint256 auctionId) external;
```
- Auctions allow multiple users to bid before the end time.

### 4. Withdraw Funds
```solidity
function withdrawFunds() external;
```
- Users can withdraw their earnings from sales and auctions.

## Security Considerations
- **Reentrancy Protection**: Uses `ReentrancyGuard` to prevent reentrancy attacks.
- **Ownership Checks**: Ensures only NFT owners can list or auction their assets.
- **Secure Payments**: Funds are stored and can only be withdrawn by the rightful owner.

## License
This project is licensed under the MIT License.


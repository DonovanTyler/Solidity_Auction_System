pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract AuctionSystem {
    string itemName;
	uint256 currentPrice;
	uint256 finalPrice;
	string description;
	uint256 minimumPrice;
	uint256 bidTime;
	uint256 minimumIncrement;
	string currency;
	IERC721 nsfw;
    function openAuction (uint256 minPrice, uint256 time, IERC721 nft, string memory descrip, uint256 increment) public {
        minimumPrice = minPrice;
	    bidTime = time;
        nsfw = nft;
        description = descrip;
	    minimumIncrement = increment;
    }
}

contract Bidder {
address highestBidder;
string itemName;
uint256 popularity;
uint256 currentPrice;
uint256 timeLeft;
uint256 bidCount;
IERC721 item;
string description;
uint256 timeExtensions = 0;

function bid(uint256 amount) public {
    if(amount > currentPrice)
	{
		currentPrice = amount;
		if(timeLeft >= 10 && timeExtensions < 10)
		{
			timeLeft = 10;
			timeExtensions++;
		}
}
}


}


contract WinAuction {
    
    event Win(address winner, uint256 amount);

    IERC721 public nft;
    uint public nftId;

    address payable public seller;
    address public winner;

    constructor(
        address _nft,
        uint _nftId
    ) {
        seller = payable(msg.sender);
        nft = IERC721(_nft);
        nftId = _nftId;
    }
    modifier onlyWinner {
        require(msg.sender == winner);
        _;
    }
    // Winds the auction for the specified amount
    function win() external payable onlyWinner{
        nft.safeTransferFrom(seller, msg.sender, nftId);
        seller.transfer(msg.value);

        emit Win(msg.sender, msg.value);
    }
}
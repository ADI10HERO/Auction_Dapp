pragma solidity ^0.4.11;

contract Auction {
    address public manager;
    address public seller;
    uint public latestBid;
    address public latestBidder;

    constructor() public {
        manager = msg.sender; //addr of person calling the contract
        //addr r hexdec
    }
 
    function auction(uint bid) public {
        latestBid = bid * 1 ether; //1000000000000000000;
        seller = msg.sender;
    }
 
    function bid() public payable {
        require(msg.value > latestBid);

        if (latestBidder != 0x00) {
            latestBidder.transfer(latestBid);
        }
        latestBidder = msg.sender;
        latestBid = msg.value;
    }

    function finishAuction() restricted public {
        seller.transfer(address(this).balance);
    }

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
}
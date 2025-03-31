// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MovieTicketBooking {
    address public owner;
    
    struct Booking {
        string movieName;
        uint256 seatNumber;
        address bookedBy;
        uint256 pricePaid;
        bool isBooked;
    }

    struct Movie {
        string name;
        uint256 ticketPrice;
        bool isAvailable;
    }

    mapping(string => Movie) public movies; // movieName => Movie details
    mapping(string => mapping(uint256 => Booking)) public bookings; // movieName => (seatNumber => Booking)

    event TicketBooked(address indexed user, string movieName, uint256 seatNumber, uint256 pricePaid);
    event TicketCanceled(address indexed user, string movieName, uint256 seatNumber, uint256 refundAmount);
    event TicketPriceUpdated(string movieName, uint256 newPrice);
    event Withdrawn(address indexed owner, uint256 amount);
    event MovieAdded(string movieName, uint256 ticketPrice);
    event MovieRemoved(string movieName);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addMovie(string memory _movieName, uint256 _ticketPrice) external onlyOwner {
        require(!movies[_movieName].isAvailable, "Movie already exists");
        movies[_movieName] = Movie(_movieName, _ticketPrice, true);
        emit MovieAdded(_movieName, _ticketPrice);
    }

    function removeMovie(string memory _movieName) external onlyOwner {
        require(movies[_movieName].isAvailable, "Movie does not exist");
        movies[_movieName].isAvailable = false;
        emit MovieRemoved(_movieName);
    }

    function updateTicketPrice(string memory _movieName, uint256 _newPrice) external onlyOwner {
        require(movies[_movieName].isAvailable, "Movie does not exist");
        movies[_movieName].ticketPrice = _newPrice;
        emit TicketPriceUpdated(_movieName, _newPrice);
    }

    function bookTicket(string memory _movieName, uint256 _seatNumber) external payable {
        require(movies[_movieName].isAvailable, "Movie not available");
        require(msg.value == movies[_movieName].ticketPrice, "Incorrect ticket price");
        require(!bookings[_movieName][_seatNumber].isBooked, "Seat already booked");

        bookings[_movieName][_seatNumber] = Booking(_movieName, _seatNumber, msg.sender, msg.value, true);
        
        emit TicketBooked(msg.sender, _movieName, _seatNumber, msg.value);
    }

    function cancelTicket(string memory _movieName, uint256 _seatNumber) external {
        require(bookings[_movieName][_seatNumber].isBooked, "Seat not booked");
        require(bookings[_movieName][_seatNumber].bookedBy == msg.sender, "Not your ticket");

        uint256 refundAmount = bookings[_movieName][_seatNumber].pricePaid;
        bookings[_movieName][_seatNumber].isBooked = false;

        payable(msg.sender).transfer(refundAmount);

        emit TicketCanceled(msg.sender, _movieName, _seatNumber, refundAmount);
    }

    function getBookingDetails(string memory _movieName, uint256 _seatNumber) external view returns (Booking memory) {
        return bookings[_movieName][_seatNumber];
    }

    function withdrawFunds() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds available");

        payable(owner).transfer(balance);
        emit Withdrawn(owner, balance);
    }

    receive() external payable {}
}

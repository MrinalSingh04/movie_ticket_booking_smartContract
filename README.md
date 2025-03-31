# 🎟️ Movie Ticket Booking Smart Contract

## 📌 Overview

The **Movie Ticket Booking Smart Contract** is a decentralized solution for booking movie tickets on the Ethereum blockchain. This contract enables users to book seats for different movies, prevents double booking, allows ticket cancellations with refunds, and provides an efficient way for the owner to manage movies and ticket prices.

## ❓ Why This Contract?

Traditional movie booking systems often involve intermediaries, centralized databases, and transaction fees. This smart contract eliminates these issues by:

- ✅ **Providing Transparency**: All transactions and bookings are recorded on the blockchain.
- ✅ **Preventing Double Booking**: Once a seat is booked, it cannot be reserved again.
- ✅ **Ensuring Secure Payments**: Users pay directly via Ethereum, reducing fraud risks.
- ✅ **Allowing Refunds**: Users can cancel tickets and receive refunds automatically.
- ✅ **Decentralization**: No third-party involvement; the system is controlled by a smart contract.

## ✨ Features

✔ **Book Tickets**: Users can book seats for a movie by paying the required ticket price.
✔ **Cancel Tickets**: Users can cancel their tickets and receive a refund.
✔ **Dynamic Pricing**: The owner can set different prices for different movies.
✔ **Multiple Shows Management**: Admins can add and remove movies from the contract.
✔ **Secure Payments**: The contract ensures only correct payments are accepted.
✔ **Owner Controls**: The owner can withdraw ticket sales revenue at any time.

## ⚙ Smart Contract Functions

### 🔑 Owner Functions

1. **`addMovie(string memory _movieName, uint256 _ticketPrice)`**

   - 🎬 Adds a new movie with a specific ticket price.

2. **`removeMovie(string memory _movieName)`**

   - ❌ Removes an existing movie from the system.

3. **`updateTicketPrice(string memory _movieName, uint256 _newPrice)`**

   - 💲 Updates the ticket price for a movie.

4. **`withdrawFunds()`**
   - 💰 Allows the owner to withdraw contract earnings.

### 🎫 User Functions

1. **`bookTicket(string memory _movieName, uint256 _seatNumber)`**

   - 🛒 Books a ticket for a specified movie and seat number.

2. **`cancelTicket(string memory _movieName, uint256 _seatNumber)`**

   - 🔄 Cancels a booking and refunds the amount.

3. **`getBookingDetails(string memory _movieName, uint256 _seatNumber)`**
   - 🔍 Retrieves booking details for a specific movie and seat.

## 🚀 Deployment Steps

1. 🛠️ Deploy the contract on Ethereum (or a test network like Goerli, Sepolia, or Mumbai for Polygon).
2. 🎬 Call `addMovie()` to add movies and set prices.
3. 🎟️ Users can start booking seats using `bookTicket()`.
4. 🔄 If needed, users can cancel tickets with `cancelTicket()`.
5. 💰 The owner can update ticket prices and withdraw funds at any time.

## 📝 Example Usage

### 1️⃣ Deploy the Contract

Deploy the contract using Remix, Hardhat, or Foundry with an Ethereum wallet like MetaMask.

### 2️⃣ Add a Movie (Owner Only)

```solidity
addMovie("Avengers", 0.05 ether);
```

### 3️⃣ Book a Ticket

```solidity
bookTicket("Avengers", 10) // User sends 0.05 ETH to book seat 10
```

### 4️⃣ Cancel a Ticket

```solidity
cancelTicket("Avengers", 10) // User gets refunded
```

### 5️⃣ Withdraw Funds (Owner Only)

```solidity
withdrawFunds();
```

## 📜 License

This project is released under the **MIT License**.

---

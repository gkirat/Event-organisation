# Event Organization Smart Contract

This is a Solidity smart contract for event organization on the Ethereum blockchain. The contract allows event organizers to create events, sell tickets, and facilitates ticket transfers and reselling between users.

## Table of Contents

- [Overview](#overview)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Deployment](#deployment)
- [Contract Functions](#contract-functions)
  - [Create Event](#create-event)
  - [Buy Tickets](#buy-tickets)
  - [Transfer Tickets](#transfer-tickets)
  - [Resell Tickets](#resell-tickets)
  - [Buy Resell Tickets](#buy-resell-tickets)
- [Data Structures](#data-structures)
- [Important Considerations](#important-considerations)
- [License](#license)

## Overview

The `eventorganization` smart contract enables the creation and management of events on the Ethereum blockchain. Event organizers can create events with specific details such as event name, date, ticket price, and total ticket quantity. Users can buy tickets for these events, and tickets can also be transferred and resold among users. The contract ensures transparency and trust in event ticket transactions.

## Getting Started

### Prerequisites

To interact with the smart contract, you will need:

- An Ethereum wallet (e.g., MetaMask) connected to the Ethereum Mainnet or Testnet.
- Sufficient Ether to pay for ticket purchases and event creation fees.

### Deployment

1. Deploy the `eventorganization` smart contract to the Ethereum network using a Solidity-compatible development environment (e.g., Remix IDE, Truffle).
2. After deployment, the contract owner can create events using the `Createevent` function by providing event details such as name, date, ticket price, and total ticket quantity. The owner must also pay the required registration fee for event creation (currently set to 10000 wei).
3. Users can buy tickets for specific events using the `Buytickets` function, providing the event ID and the desired ticket quantity. The user must pay the exact ticket price (ticket price * quantity) in Ether.
4. Users can transfer their purchased tickets to other Ethereum addresses using the `Transfertickets` function.
5. Users can resell their purchased tickets by providing the resell price, event ID, and number of tickets they want to resell through the `ResellTic` function.
6. Other users can buy resold tickets from the `blacktic` marketplace using the `BuyresellTic` function, paying the specified resell price.

## Contract Functions

### Create Event

The `Createevent` function allows the contract owner to create new events. The function requires the event name, date, ticket price, and total ticket quantity as input parameters. The owner must also pay the registration fee to create the event.

### Buy Tickets

The `Buytickets` function enables users to purchase tickets for specific events. Users need to provide the event ID and the desired ticket quantity. The function checks for ticket availability, verifies the payment amount, and updates ticket ownership.

### Transfer Tickets

The `Transfertickets` function allows users to transfer their purchased tickets to other Ethereum addresses. Users need to provide the event ID, the number of tickets to transfer, and the recipient address.

### Resell Tickets

Users who want to resell their tickets can use the `ResellTic` function. The function requires the resell price, event ID, and the number of tickets to resell. Reselling is only allowed before the event date and within the limit of two tickets per address.

### Buy Resell Tickets

The `BuyresellTic` function enables users to buy tickets from the `blacktic` marketplace. Users must provide the event ID, the number of tickets they want to buy, and the address of the seller (ticket owner). The function verifies the payment amount, transfers Ether to the seller, and updates ticket ownership.

## Data Structures

The smart contract uses the following data structures:

- `Eventdetails`: Holds details of each event, including the event name, date, ticket price, and remaining tickets.

- `Info`: Represents reselling information, including the event ID, ticket owner address, resell price, and available tickets for reselling.

## Important Considerations

- The contract owner is responsible for creating events and collecting registration fees.
- Tickets can only be bought, transferred, and resold before the event date.
- The contract ensures that ticket transfers and resells are restricted within valid limits.
- The contract uses wei as the unit for Ether transactions, where 1 Ether = 10^18 wei.

## License

This smart contract is released under the MIT License. See the `LICENSE` file for more information.

# DBI Contracts Repository

## Introduction
This repository contains a collection of smart contracts designed for the DBI ecosystem. 
The contracts are built to handle organization registration, handling post-hack interaction such as the distribution of bounties and the process of refunds, NFT issuance for roles.

## Contracts

### DBI.sol
`DBI.sol` is the main contract in this repository. It includes key features such as:

- `addOrganization`: A function for registering organizations within the DBI platform.
- `createPost`: Handles the creation and management of posts on the blockchain.

### DBIPost.sol
`DBIPost.sol` focuses on handling posts on the blockchain and acts as a proof of post. Its key features include:

- `uploadReport`: Allows users to submit reports.
- `fulfill`: Enables hackers to return hacked funds and receive their bounty rewards. This function uses `FullMath` for precise calculation of reward distribution.

### DBIPoap.sol
`DBIPoap.sol` is NFTs as Proof of Attendance Protocols (POAPs) to users, signifying their roles within the DBI ecosystem.

### SignatureVerification.sol
This contract is used for handling authority checks and permissions for operations within the DBI contracts.

### FullMath.sol
`FullMath.sol` is a utility contract used primarily in the `fulfill` function of `DBIPost.sol`. It ensures precise calculations for the distribution of bounty rewards.

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

polygonMumbai: 
- DBI_CONTRACT: "0xB25D331Fb163BA43DdDA3df210074BdF2e37Df5c" 
- DBI_OFFICER: "0xfC37E5b52ef1Ec212fe83eee0bEBc323F03874Aa" 
- DBI_DEPUTY: "0x536414C98A26Dc703c071A06C4DB3c2d1121422B" 

  
arbitrumGoerli 
- DBI_CONTRACT: "0xfC37E5b52ef1Ec212fe83eee0bEBc323F03874Aa"
- DBI_OFFICER: "0xCA86f2Eb1005A041eF8dDFA9d78E00c227D01796"
- DBI_DEPUTY: "0xB25D331Fb163BA43DdDA3df210074BdF2e37Df5c" 

scrollSepolia 
- DBI_CONTRACT: "0xB25D331Fb163BA43DdDA3df210074BdF2e37Df5c"
- DBI_OFFICER: "0xCA86f2Eb1005A041eF8dDFA9d78E00c227D01796"
- DBI_DEPUTY: "0x09f224a05F0341465eb6040527891AF625f5049b"

baseGoerli 
- DBI_CONTRACT: "0xCA86f2Eb1005A041eF8dDFA9d78E00c227D01796"
- DBI_OFFICER: "0xbc9D910B8282C5409f4fDdcc1d66fC3C4288e360"
- DBI_DEPUTY: "0x09f224a05F0341465eb6040527891AF625f5049b"

mantleTestnet 
- DBI_CONTRACT: "0xCA86f2Eb1005A041eF8dDFA9d78E00c227D01796"
- DBI_OFFICER: "0xbc9D910B8282C5409f4fDdcc1d66fC3C4288e360"
- DBI_DEPUTY: "0x09f224a05F0341465eb6040527891AF625f5049b"

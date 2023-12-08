// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

error IndexOutOfBound();

contract DBI is Ownable {

    struct Organisation {
        string name;
        address token;
        address treasury;
        uint256 thresholdTokenAmount;
        string twitterName;
    }

    Organisation[] _organisations;

    event OrganisationCreated(Organisation orgs); 

    constructor() {}

    function addOrganisation(Organisation memory orgs) external {
        _organisations.push(orgs);

        emit OrganisationCreated(orgs);
    }

    function getAllOrgs() external view returns (Organisation[] memory orgs) {
        return _organisations;
    }

    function getOrgsDetailsById(uint256 index) external view returns (Organisation memory orgs) {
        if(index > _organisations.length) {
            revert IndexOutOfBound();            
        }
        return _organisations[index];
    }
    
}   

// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {DBIPost} from "./DBIPost.sol";

error IndexOutOfBound();
error UninitializedOrgs();
error NotEnoughTokenAmount();

contract DBI is Ownable {

    struct Organisation {
        string name;
        address token;
        address treasury;
        uint256 thresholdTokenAmount;
        string twitterName;
    }

    Organisation[] _organisations;

    mapping(uint256 => address[]) internal _posts; // orgsID => proof of post

    event OrganisationCreated(Organisation orgs); 
    event PostCreated(uint256 timestamp, address creator, address post, string postDetails); 

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

    function createPost(
        uint256 orgsId,
        address[] memory stolenToken, 
        uint256[] memory stolenTokenAmount, 
        uint256 deadline, 
        uint256 bountyRewardInBps,
        string memory postDetails
    ) external returns (address post) {    
        Organisation memory orgs = _organisations[orgsId];

        if (orgs.token == address(0)) {
            revert UninitializedOrgs();            
        }

        // only holder
        uint256 initiatorBalance = IERC20(orgs.token).balanceOf(msg.sender);
        if (initiatorBalance < orgs.thresholdTokenAmount) {
            revert NotEnoughTokenAmount();            
        }
        
        DBIPost _post = new DBIPost(
            orgsId, 
            orgs.name, 
            stolenToken, 
            stolenTokenAmount, 
            deadline, 
            orgs.treasury,
            bountyRewardInBps,
            postDetails
        );

        _posts[orgsId].push(address(_post));
        post = address(_post);

        emit PostCreated(block.timestamp, msg.sender, address(_post), postDetails); 
    }     
}   

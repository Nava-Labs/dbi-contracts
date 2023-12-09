// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {DBIPost} from "./DBIPost.sol";

error IndexOutOfBound();
error UninitializedOrgz();
error NotEnoughTokenAmount();

contract DBI is Ownable {

    struct Organization {
        string name;
        address token;
        address treasury;
        uint256 thresholdTokenAmount;
        string twitterName;
    }

    Organization[] _organizations;

    mapping(uint256 => address[]) internal _posts; // orgsID => proof of post

    event OrganizationCreated(Organization orgs); 
    event PostCreated(uint256 timestamp, address creator, address post, string postDetails); 

    constructor() {}

    function addOrganization(Organization memory orgs) external {
        _organizations.push(orgs);

        emit OrganizationCreated(orgs);
    }

    function getAllOrgs() external view returns (Organization[] memory orgs) {
        return _organizations;
    }

    function getOrgzDetailsById(uint256 index) external view returns (Organization memory orgz) {
        if(index > _organizations.length) {
            revert IndexOutOfBound();            
        }
        return _organizations[index];
    }

    function createPost(
        uint256 orgzId,
        address[] memory stolenToken, 
        uint256[] memory stolenTokenAmount, 
        uint256 deadline, 
        uint256 bountyRewardInBps,
        string memory postDetails
    ) external returns (address post) {    
        Organization memory orgz = _organizations[orgzId];

        if (orgz.token == address(0)) {
            revert UninitializedOrgz();            
        }

        // only holder
        uint256 initiatorBalance = IERC20(orgz.token).balanceOf(msg.sender);
        if (initiatorBalance < orgz.thresholdTokenAmount) {
            revert NotEnoughTokenAmount();            
        }
        
        DBIPost _post = new DBIPost(
            orgzId, 
            orgz.name, 
            stolenToken, 
            stolenTokenAmount, 
            deadline, 
            orgz.treasury,
            bountyRewardInBps,
            postDetails
        );

        _posts[orgzId].push(address(_post));
        post = address(_post);

        emit PostCreated(block.timestamp, msg.sender, address(_post), postDetails); 
    }     
}   

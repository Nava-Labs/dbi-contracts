// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {FullMath} from "./utils/FullMath.sol";

contract DBIPost {

    uint256 public immutable ORGS_ID;
    string public ORGS;
    address[] public stolenToken;
    uint256[] public stolenTokenAmount;
    uint256 public deadline;
    address public treasury;
    uint256 public bountyRewardInBps;
    string public postDetails;

    event BountySettlement(uint256 timestamp); 

    constructor(    
        uint256 orgsId,
        string memory name,
        address[] memory _stolenToken, 
        uint256[] memory _stolenTokenAmount, 
        uint256 _deadline, 
        address _treasury,
        uint256 _bountyRewardInBps,
        string memory _postDetails
    ) {
        ORGS_ID = orgsId;
        ORGS = name;
        stolenToken = _stolenToken;
        stolenTokenAmount = _stolenTokenAmount;
        deadline = _deadline;
        treasury = _treasury;
        bountyRewardInBps = _bountyRewardInBps;
        postDetails = _postDetails;
    }

    function fulfill() external {
        for (uint8 i = 0; i < stolenToken.length; i++) {
            uint256 bountyAmount = FullMath.mulDiv(
                bountyRewardInBps, 
                stolenTokenAmount[i], 
                10000
            );
            uint256 refundedAmount = stolenTokenAmount[i] - bountyAmount;
            IERC20(stolenToken[i]).transferFrom(msg.sender, treasury, refundedAmount);
        }

        emit BountySettlement(block.timestamp);
    }
        
}   

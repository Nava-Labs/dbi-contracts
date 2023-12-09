// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import {DBI} from "../src/DBI.sol";
import {DBIPost} from "../src/DBIPost.sol";
import {DBIPoap} from "../src/DBIPoap.sol";

contract DBIScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        DBI dbi = new DBI();

        console.log(
            "Factory contract deployed on with address: ",
            address(dbi)
        );

        vm.stopBroadcast();
    }

    function addOrganisation(
        address dbi, 
        string memory name,
        address token,
        address treasury,
        uint256 thresholdTokenAmount,
        string memory twitterName
    ) external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        DBI.Organization memory orgz = DBI.Organization({         
            name: name,
            token: token,
            treasury: treasury,
            thresholdTokenAmount: thresholdTokenAmount,
            twitterName: twitterName
        });
        
        DBI(dbi).addOrganization(orgz);

        vm.stopBroadcast();
    }

    function createPost(
        address dbi,
        uint256 orgsId,
        address[] memory stolenToken, 
        uint256[] memory stolenTokenAmount, 
        uint256 endTimestamp, 
        uint256 bountyOfferedInPercentage,
        string memory bountyDetails
    ) external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        DBI(dbi).createPost(
            orgsId, 
            stolenToken, 
            stolenTokenAmount,
            endTimestamp,
            bountyOfferedInPercentage,
            bountyDetails
        );

        vm.stopBroadcast();
    } 
}

contract DBIPostScript is Script {
    function run(
        uint256 orgsId,
        string memory name,
        address[] memory _stolenToken, 
        uint256[] memory _stolenTokenAmount, 
        uint256 _endTimestamp, 
        address _treasury,
        uint256 _bountyRewardInPercentage,
        string memory _postDetails
    ) external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        DBIPost _post = new DBIPost(
            orgsId, 
            name, 
            _stolenToken, 
            _stolenTokenAmount, 
            _endTimestamp, 
            _treasury, 
            _bountyRewardInPercentage, 
            _postDetails
        );

        console.log(
            "DBI Post contract deployed on with address: ",
            address(_post)
        );


        vm.stopBroadcast();
    }

    function fulfill(
        address post
    ) external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        DBIPost(post).fulfill();

        vm.stopBroadcast();
    } 

    function uploadReport(
        address post,
        string memory reportCID,
        bytes calldata signature
    ) external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        DBIPost(post).uploadReport(reportCID, signature);

        vm.stopBroadcast();
    } 
}

contract DBIPoapScript is Script {
    function run(
        string memory name,
        string memory symbol,
        string memory uri
    ) external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        DBIPoap poap = new DBIPoap(name, symbol, uri);

        console.log(
            "DBI Poap contract deployed on with address: ",
            address(poap)
        );


        vm.stopBroadcast();
    } 

    function mint(
        address poap,
        bytes calldata signature
    ) external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        DBIPoap(poap).mint(signature);

        vm.stopBroadcast();
    } 
    
}

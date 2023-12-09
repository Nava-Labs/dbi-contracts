// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {ECDSA, EIP712} from "@openzeppelin/contracts/utils/cryptography/EIP712.sol";

error InvalidSignature();

contract SignatureVerification is EIP712 {

    address constant _signerAddress = 0x5E61132B8883FD54Bf620ca7728c37360e3EB839;

    mapping(address => uint256) addressToNonce;

    constructor(    
        string memory signingDomainName,
        string memory signingDomainVersion
    ) EIP712(signingDomainName, signingDomainVersion) {}

    modifier isValidSigner(bytes calldata signature) {
        if(
          _signerAddress != _recoverToAddress(
            address(this), 
            msg.sender, 
            accountNonce(msg.sender),
            signature)
        ) {
            revert InvalidSignature();
        }
        addressToNonce[msg.sender]++;

        _;
    }

    function _hash(address contractAddress, address account, uint256 nonce) 
        internal 
        view 
        returns (bytes32) 
    {
        return
            _hashTypedDataV4(
                keccak256(
                    abi.encode(
                        keccak256(
                          "DBI(address contractAddress,address account,uint256 nonce)"
                        ),
                        contractAddress,
                        account,
                        nonce
                    )
                )
            );
    }

    function _recoverToAddress(
        address contractAddress, 
        address account, 
        uint256 nonce,
        bytes calldata signature
    ) 
        internal
        view 
        returns(address) 
    {
        return ECDSA.recover(_hash(contractAddress, account, nonce), signature);
    }

    function accountNonce(address accountAddress)
        public
        view
        returns (uint256)
    {
        return addressToNonce[accountAddress];
    }

    function checkRecoverAddress(
        address contractAddress, 
        address account,
        uint256 nonce,
        bytes calldata signature
    )
        public
        view
        returns (address)
    {
        return _recoverToAddress(contractAddress, account, nonce, signature);
    }    
}   

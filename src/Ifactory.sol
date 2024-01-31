// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

interface Ifactory {
    function AccountcontractState(address contractAccount) external view returns(bool);
}
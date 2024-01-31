// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

interface ICert {
    function Mintcert(address to, uint id, uint amount) external;
    function Burn(address from, uint id, uint amount) external;
    function balanceOf(address account, uint256 id) external view returns (uint256);
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "./UserAccount.sol";

contract AccountFactory {
    struct accounts{
        string _name;
        address accountAddress;
        uint certificateID;
    }
    address public owner;
    accounts[] Accounts;
    bool paused;
    mapping(address => address) SingleAccountAddress;
    mapping(address => bool) public accountStatus;
    mapping(address => bool) contractAccountStatus;
    uint certificateIDs;
    address public NftAddress;

    event accountCreated(string _name, address _accountAddress, uint certID);
    constructor(address _nftAddress) {
        owner = msg.sender;
        certificateIDs = 1;
        NftAddress = _nftAddress;
    }

    function CreateAccount(string memory name_, uint _duration) external {
        require(paused == false, 'Paused');
        require(accountStatus[msg.sender] == false, 'existing account');
        UserAccount account = new UserAccount(name_, msg.sender, _duration,certificateIDs, NftAddress, msg.sender);
        Accounts.push(accounts(name_, address(account), certificateIDs ));
        SingleAccountAddress[msg.sender] = address(account);
        accountStatus[msg.sender] = true;
        contractAccountStatus[address(account)] = true;
        emit accountCreated(name_,address(account), certificateIDs);
        certificateIDs++;
    }
    function pause() external{
        require(msg.sender == owner, 'Not authorized');
        paused = true;
    }
    function unpause() external {
        require(msg.sender == owner);
        paused = false;
    }
    function AllAccounts() public view returns(accounts[] memory) {
        return Accounts;
    }
    function SingleAccount(address account) public view returns (address) {
        return SingleAccountAddress[account];
    }
    function CreationStatus(address account) public view returns (bool) {
        return accountStatus[account];
    }
    function AccountcontractState(address contractAccount) external view returns(bool) {
        return contractAccountStatus[contractAccount];
    }
}

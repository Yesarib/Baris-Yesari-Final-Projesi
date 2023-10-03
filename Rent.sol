// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Rent{
    struct Renter {
        address renterAddress;
        string name;
    }
    enum RentType{
        Home,
        Shop
    }

    struct RentContract{
        RentType rentType;
        Renter renter;
        address owner;
        uint256 rentStartDate;
        uint256 rentFinishDate;
        bool isContiune;     
    }


    mapping(uint256 => RentContract) public contracts;
    uint256 public lastContractId;

    event StartRent(uint256 contractId, RentType rentType,Renter renter,address owner,uint256 rentStartDate, uint256 rentFinishDate);
    event FinishRent(uint256 contractId, address owner,uint256 rentStartDate, uint256 rentFinishDate);

    function startRent (RentType rentType, Renter memory renter, address owner, uint256 rentStartDate, uint256 rentFinishDate) public {
        lastContractId++;
        RentContract storage rentContract = contracts[lastContractId];
        rentContract.rentType = rentType;
        rentContract.renter.name = renter.name;
        rentContract.renter.renterAddress = renter.renterAddress;
        rentContract.owner = owner;
        rentContract.rentStartDate = rentStartDate;
        rentContract.rentFinishDate = rentFinishDate;
        rentContract.isContiune = true;

        emit StartRent(lastContractId, rentType, renter,owner, rentStartDate, rentFinishDate);
    }

    function finishRent(uint256 contractId, address owner,uint256 rentStartDate, uint256 rentFinishDate) public {
        RentContract storage finishRentContract = contracts[contractId];
        require(finishRentContract.isContiune, "This rent already finished");
        finishRentContract.isContiune = false;

        emit FinishRent(contractId, owner, rentStartDate, rentFinishDate);
    }


}

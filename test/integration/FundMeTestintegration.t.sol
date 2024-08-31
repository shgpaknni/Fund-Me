// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {Fundfundme, withdrawFundme} from "../../script/Interactions.s.sol";

contract FundMeTestintegration is Test {
    FundMe fundme;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant startingBalance = 10 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        DeployFundMe deploy = new DeployFundMe();
        fundme = deploy.run();
        vm.deal(USER, startingBalance);
    }

    function testUserCanFundInteraction() public {
        Fundfundme fundfundme = new Fundfundme();
        // vm.Prank(USER);
        // vm.deal(USER,1e18);
        fundfundme.fundfundme(address(fundme));
        // address funder = fundme.getfunders(0);
        // assertEq(funder, USER);
        withdrawFundme withdrawfundme = new withdrawFundme();
        withdrawfundme.withdrawfundme(address(fundme));
        assert(address(fundme).balance == 0);
    }
}

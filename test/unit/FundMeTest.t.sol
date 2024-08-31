// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundme;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant startingBalance = 10 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        // fundme = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployfundme = new DeployFundMe();
        fundme = deployfundme.run();
        vm.deal(USER, startingBalance);
    }

    function testMinimumDollarisFive() public {
        assertEq(fundme.MINIMUM_USD(), 5e18);
    }

    function testownerisMsgsender() public {
        assertEq(fundme.getOwner(), msg.sender);
    }

    function testpriceFeedVersionAcceurate() public {
        uint256 version = fundme.getVersion();
        assertEq(version, 4);
    }

    function testFundFailWithoutEnoughEth() public {
        vm.expectRevert();
        fundme.fund();
    }

    function testFundUpdateDataStricture() public {
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundme.getAddressToAmountFunded(USER);
        assertEq(amountFunded, SEND_VALUE);
    }

    function testToArrayOfFunders() public {
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();
        address funder = fundme.getfunders(0);
        assertEq(funder, USER);
    }

    modifier funded() {
        vm.prank(USER);
        fundme.fund{value: SEND_VALUE}();
        _;
    }

    function testOnltOwnerCanWithdraw() public funded {
        vm.prank(USER);

        vm.expectRevert();

        fundme.withdraw();
    }

    function testWithdrawWithASingleFunder() public funded {
        uint256 startingOwnerBalance = fundme.getOwner().balance;
        uint256 startingFundmeBalnce = address(fundme).balance;

        vm.prank(fundme.getOwner());
        fundme.withdraw();

        uint256 endingOwnerBalance = fundme.getOwner().balance;
        uint256 endingFundMeBalance = address(fundme).balance;
        assertEq(endingFundMeBalance, 0);
        assertEq(
            startingFundmeBalnce + startingOwnerBalance,
            endingOwnerBalance
        );
    }

    function testWithdrawFromMultipleFundscheaper() public funded {
        uint160 numberofFunders = 10;
        uint160 startingFunderIndex = 1;
        for (uint160 i = startingFunderIndex; i < numberofFunders; i++) {
            hoax(address(i), SEND_VALUE);
            fundme.fund{value: SEND_VALUE}();
        }
        uint256 startingOwnerBalance = fundme.getOwner().balance;
        uint256 startingFundmeBalnce = address(fundme).balance;
        vm.startPrank(fundme.getOwner());
        fundme.cheaperWithdrw();
        vm.stopPrank();
        assert(address(fundme).balance == 0);
        assert(
            startingFundmeBalnce + startingOwnerBalance ==
                fundme.getOwner().balance
        );
    }

    function testWithdrawFromMultipleFunds() public funded {
        uint160 numberofFunders = 10;
        uint160 startingFunderIndex = 1;
        for (uint160 i = startingFunderIndex; i < numberofFunders; i++) {
            hoax(address(i), SEND_VALUE);
            fundme.fund{value: SEND_VALUE}();
        }
        uint256 startingOwnerBalance = fundme.getOwner().balance;
        uint256 startingFundmeBalnce = address(fundme).balance;
        vm.startPrank(fundme.getOwner());
        fundme.withdraw();
        vm.stopPrank();
        assert(address(fundme).balance == 0);
        assert(
            startingFundmeBalnce + startingOwnerBalance ==
                fundme.getOwner().balance
        );
    }
}

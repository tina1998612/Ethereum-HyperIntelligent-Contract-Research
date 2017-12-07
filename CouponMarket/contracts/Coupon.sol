pragma solidity ^0.4.13;

contract Coupon {
  // Configuration
  uint256 ID;
  address issuer;
  address owner;
  uint256 startTime;
  uint256 endTime;
  uint256 value;

  // Functions with this modifier can only be executed by the owner
  modifier onlyOwner(){
      assert(owner == msg.sender);
      _;
  }

  // Functions with this modifier can only be executed by the issuer
  modifier onlyIssuer() {
    assert(issuer == msg.sender);
    _;
  }

  // Check whether the redeem time is between the span of startTime and endTime.
  modifier isValidRedeemTime(){
    require(startTime <= now);
    require(endTime >= now);
    _;
  } 

  // Constructor
  function Coupon(uint256 id, uint256 _startTime, uint256 _endTime, uint256 _value) {
    require(_endTime >= _startTime);

    ID = id;
    issuer =  msg.sender;   // issuer is default to be the owner of the coupon
    owner = msg.sender;
    startTime =  _startTime;
    endTime =  _endTime;
    value =  _value;
  }

  // receiver is the owner to be changed to 
  function changeOwnerTo(address receiver) onlyOwner {
    owner = receiver;
  }

  // redeem the coupon
  function redeem() onlyOwner {
    changeOwnerTo(issuer);
  }

  // transfer the coupon ownership
  function transfer(address receiver) onlyOwner {
    changeOwnerTo(receiver);
  }
}
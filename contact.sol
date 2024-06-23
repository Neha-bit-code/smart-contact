// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AssertionContract {
    uint256 public totalValue;
    address public owner;

    // Events
    event ValueUpdated(uint256 newValue);
    event ValueIncreased(uint256 amount, uint256 newValue);
    event ValueRemoved(uint256 amount, uint256 newValue);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // Constructor to set the initial owner
    constructor() {
        owner = msg.sender;
        emit OwnershipTransferred(address(0), owner);
    }

    // Modifier to restrict function access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    // Function to transfer ownership
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "New owner is the zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }

    // require() to ensure valid inputs.
    function updateValue(uint256 _value) external onlyOwner {
        require(_value > 0, "Value must be greater than zero");
        totalValue = _value;
        emit ValueUpdated(_value);
    }

    // assert() to check for invariants.
    function increaseValue(uint256 _value) external onlyOwner {
        uint256 oldValue = totalValue;
        uint256 newValue = oldValue + _value;
        assert(newValue >= oldValue); // Check for overflow
        totalValue = newValue;
        emit ValueIncreased(_value, newValue);
    }

    // revert() to handle exceptional cases.
    function removeValue(uint256 _amount) external onlyOwner {
        require(_amount <= totalValue, "Not enough balance");
        totalValue -= _amount;
        emit ValueRemoved(_amount, totalValue);

        // Simulate a failure scenario with a specific condition.
        if (_amount > 100) {
            revert("Withdrawal amount should not exceed 100");
        }
        
        
    }
}

# Smart-contact
# Project Title
 Write a smart contract that implements the require(), assert() and revert() statements.
# Description
require():
Used to validate conditions that should hold true before executing a function.
If the condition is false, it reverts the transaction and optionally provides an error message.

assert():
Used to test for conditions that should never be false.
Typically used for internal errors and to check invariants.


revert():
Directly reverts the transaction and optionally provides an error message.
Useful for complex conditions and to provide detailed error messages within nested conditions or loops.

# Getting Started: 
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension. (e.g., Smart contact .sol).Copy and paste the following code into the file:
```
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



       

```

Click on the "Solidity Compiler" tab on the left sidebar (second icon from the top, resembling a "less than" sign and a "greater than" sign).
Make sure the compiler version is set to a compatible version (at least 0.8.0).

Click the "Compile Smart contact .sol" button.

 Deploy the Contract Click on the "Deploy & Run Transactions" tab on the left sidebar (third icon from the top, resembling a blockchain).
Select "JavaScript VM" in the "Environment" dropdown to use an in-browser blockchain.
Ensure the "Contract" dropdown is set to "ErrorHandling".

Click the "Deploy" button.
 Interact with the Contract After deployment, you will see the deployed contract listed under "Deployed Contracts" at the bottom of the "Deploy & Run Transactions" pane.

After deployment, you will see the deployed contract under "Deployed Contracts".
Expand the deployed contract to see the available functions.
Testing the Functions:

updateValue: Enter a value greater than 0 and click updateValue. Check totalValue to see if it updates correctly. An event ValueUpdated will be logged.

increaseValue: Enter a value and click increaseValue. Check totalValue to see if it increases by the specified amount. An event ValueIncreased will be logged.

removeValue: Enter an amount less than or equal to totalValue and click removeValue. Check totalValue to see if it decreases correctly. An event ValueRemoved will be logged. Enter an amount greater than 100 to test the revert condition.

transferOwnership: Enter a new owner address and click transferOwnership to change the owner. An event OwnershipTransferred will be logged.

# License
This project is licensed under the MIT License.


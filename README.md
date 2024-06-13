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

contract smart {

    address public owner;
    uint public balance;

    constructor() {
        owner = msg.sender;
        balance = 0;
    }

    
    function deposit() public payable {
        require(msg.value > 0, "Deposit value must be greater than 0");
        balance += msg.value;
    }

    
    function withdraw(uint _amount) public {
        require(msg.sender == owner, "Only the owner can withdraw funds");
        require(_amount <= balance, "Insufficient balance");

        balance -= _amount;
        payable(msg.sender).transfer(_amount);
    }

    
    function validateContract() public view {
        assert(balance >= 0);
    }

    
    function demoRevert(bool _triggerRevert) public pure {
        if (_triggerRevert) {
            revert("Revert triggered");
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

Expand the deployed contract instance to see the available functions and state variables.

 Testing the Functions
Increment Function:Ensure the owner account is selected in the "Account" dropdown.

Enter a value (e.g., 5) in the _value field of the increment function and click "transact".

The count variable should now be 5.

Decrement Function:Enter a value (e.g., 2) in the _value field of the decrement function and click "transact".

The count variable should now be 3.

Reset Count Function Click the resetCount function button.

The count variable should be reset to 0.

Require Only Owner:Change the account in the "Account" dropdown to a non-owner account.
Try to call the increment or decrement function, and it should revert with an error message "Caller is not the owner".

# Authors
Metacrafter Chris



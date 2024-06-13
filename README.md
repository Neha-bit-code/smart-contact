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

In the "Value" field above the function buttons, enter the amount of Ether you want to deposit (e.g., 1 for 1 Ether).
Click the deposit button. Ensure you have sufficient test Ether in your account.

Withdraw Ether
Enter the amount you want to withdraw in the _amount field of the withdraw function.

Click the withdraw button.

Validate Contract
Click the validateContract button to ensure the contract's balance is non-negative.

Trigger Revert
Toggle the _triggerRevert parameter to true or false.

Click the demoRevert button to see how revert works when _triggerRevert is true.

 Check Balances and Owner
 
You can view the owner address and balance of the contract by clicking the corresponding buttons in the "Deployed Contracts" section.



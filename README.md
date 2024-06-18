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

contract Library {
    struct Book {
        uint id;
        string title;
        bool isAvailable;
    }

    address public owner;
    mapping (uint => Book) public books;
    mapping (address => uint) public borrowedBooks;
    uint public booksCount;

    event LogBookAdded(uint id, string title);
    event LogBookBorrowed(uint id, address borrower);
    event LogBookReturned(uint id, address borrower);
    event LogBookList(uint id, string title, bool isAvailable);

    constructor() {
        owner = msg.sender;
    }

    function addBook(string memory _title) public {
        require(msg.sender == owner, "Only the owner can add books");
        require(bytes(_title).length > 0, "Title cannot be empty");

        booksCount++;
        books[booksCount] = Book(booksCount, _title, true);
        emit LogBookAdded(booksCount, _title);
    }

    function borrowBook(uint _bookId) public {
        require(msg.sender != address(0), "Invalid sender address");
        require(_bookId > 0 && _bookId <= booksCount, "Invalid book ID");
        require(books[_bookId].isAvailable, "Book is not available");

        books[_bookId].isAvailable = false;
        borrowedBooks[msg.sender] = _bookId;
        emit LogBookBorrowed(_bookId, msg.sender);
    }

    function returnBook(uint _bookId) public {
        require(msg.sender != address(0), "Invalid sender address");
        require(_bookId > 0 && _bookId <= booksCount, "Invalid book ID");
        require(!books[_bookId].isAvailable, "Book is already available");
        require(borrowedBooks[msg.sender] == _bookId, "You did not borrow this book");

        books[_bookId].isAvailable = true;
        delete borrowedBooks[msg.sender];
        emit LogBookReturned(_bookId, msg.sender);
    }

    function viewBooks() public {
        for (uint i = 1; i <= booksCount; i++) {
            Book memory book = books[i];
            emit LogBookList(book.id, book.title, book.isAvailable);
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

Adding Books (Using Owner Account)
Select the Owner Account:

In the Account dropdown, ensure the default account (first account in the list) is selected. This is the account that deployed the contract and is the owner.
Add Books:

In the deployed contract section, find the addBook function.

Input the book title (e.g., "The Great Gatsby").

Click transact to add the book.

 Borrowing a Book (Using a Different Account)
Switch to Another Account (e.g., Account 2):

In the Account dropdown, select another account (e.g., the second account in the list).
Borrow a Book:

In the deployed contract section, find the borrowBook function.

Input the book ID (e.g., 1 for "The Great Gatsby").

Click transact to borrow the book.

 Returning a Book (Using the Same Account)

Ensure the Same Account is Selected (e.g., Account 2):

Confirm that the account which borrowed the book is still selected.
Return the Book:

In the deployed contract section, find the returnBook function.

Input the book ID (e.g., 1 for "The Great Gatsby").

Click transact to return the book.
 Viewing Books and Borrowed Books

View Details of a Specific Book:

In the deployed contract section, find the books function.

Input the book ID (e.g., 1).

Click call to see the book details (ID, title, availability).

Check Which Book an Address Borrowed:

In the deployed contract section, find the borrowedBooks function.

Input the borrower's address (copy the address from the Account dropdown).

Click call to see the ID of the book borrowed by that address.

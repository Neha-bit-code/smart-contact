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

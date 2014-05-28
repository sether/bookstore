/* Target:	MySQL
 * Purpose: Define 'BookStore' database and populate
 * Author: 	G.Sparke, 5April07.
 */

DROP DATABASE IF EXISTS BookStore;
CREATE DATABASE BookStore;
USE BookStore;

CREATE TABLE Authors (
   AuthorId       INT		NOT NULL,
   LastName       VARCHAR(40)	NOT NULL,
   FirstName      VARCHAR(20)	NOT NULL,
   Phone          CHAR(12)		NOT NULL DEFAULT 'UNKNOWN',
   Address        VARCHAR(40)	NULL,
   City           VARCHAR(20)	NULL,
   State          CHAR(5)		NULL,
   Postcode       CHAR(5)		NULL,
   Country	  VARCHAR(20)		NULL,
   PRIMARY KEY (AuthorId)
);

CREATE TABLE Titles (
  TitleId	INT			NOT NULL,	/* PK */
  Title		VARCHAR(50)		NOT NULL,	/* Book title */
  CatId		CHAR(8)  		NOT NULL,	/* Book category eg. CO - comedy; FK */
  PubId    	INT	  		NULL,		/* Publishers FK */
  Price		DECIMAL(7,2) 	NULL,
  Year		INT			NULL,		/* Year of publication */
  Sales		INT			NULL,		/* No. of titles sold */
  inStock	INT			NULL,		/* No. of titles in stock */
  Type		CHAR(8),				/* could be CD, DVD, etc; not used */
  PRIMARY KEY (TitleId)
);

CREATE TABLE Publishers (
  PubId		INT    AUTO_INCREMENT NOT NULL,
  PubName	VARCHAR(30)     NOT NULL,
  city      	VARCHAR(20)		NULL,
  state		VARCHAR(5)      NULL,
  country	VARCHAR(20)     NULL,
  PRIMARY KEY (PubId)
);

CREATE TABLE TitleAuthor (
  AuthorId     	INT  		NOT NULL,
  TitleId	INT  		NOT NULL,
  royalty 	INT  		NULL,		-- Royalty %
  PRIMARY KEY (AuthorId, TitleId)
);

CREATE TABLE Orders (
  OrderId	INT AUTO_INCREMENT NOT NULL,
  CustId	INT  	NOT NULL,
  OrderDate	DATETIME    	NOT NULL,
  ShipId	CHAR(5),		
  PRIMARY KEY (OrderId)
  );

# OrderItems: normalised, requires link to Orders table
CREATE TABLE OrderItems (
  OrderId	INT  	NOT NULL,	-- FK from Orders(OrderId)
  TitleId	INT  	NOT NULL,	-- FK from titles(TitleId)
  Quantity	INT  	DEFAULT 1,
  Price		DECIMAL(7,2),
  PRIMARY KEY (OrderId, TitleId )
  );

# Order_X: un-normalised to make php easier to demo - don't need Orders table
CREATE TABLE Orders_X (
  OrderId	INT AUTO_INCREMENT PRIMARY KEY,
  OrdersId	INT,			-- FK from Orders(OrderId)
  CustId	INT  	NOT NULL,	-- FK from Customers(CustId)
  TitleId	INT  	NOT NULL,	-- FK from titles(TitleId)
  OrderDate	DATE	NOT NULL,
  Quantity	INT  	DEFAULT 1,
  Price		DECIMAL(7,2)
  );

CREATE TABLE Customers (
  CustId	INT AUTO_INCREMENT NOT NULL,
  FirstName	VARCHAR(15)	NOT NULL,
  LastName	VARCHAR(15)	NOT NULL,
  Gender	VARCHAR(1)	DEFAULT 'F',
  Email		VARCHAR(30)	NOT NULL,
  Address	VARCHAR(20)	NULL,
  City		VARCHAR(50)	NULL,
  State		VARCHAR(20)	NULL,
  Postcode	VARCHAR(8)	NULL,
  Country	VARCHAR(20)	NULL,
  Password      CHAR(32) DEFAULT '',
  UserName	VARCHAR(20),
  CreditCard	VARCHAR(20),
  PRIMARY KEY (CustId)
  );

CREATE TABLE Category (
  CatId		VARCHAR(8) NOT NULL,
  Description	VARCHAR(20) NOT NULL,
  PRIMARY KEY (CatId)
  );

# Cart - similar to order, with session id
DROP TABLE IF EXISTS Cart;
CREATE TABLE Cart (
  CartId	INTEGER AUTO_INCREMENT NOT NULL,
  SessionId	CHAR(32) NOT NULL,
  UserName	VARCHAR(15) NOT NULL,	# FK from Customers
  OrderDate	DATE     NOT NULL,
  Quantity	INTEGER  DEFAULT 1,
  TitleId	INTEGER  NOT NULL,	# FK from Titles
  Price		DECIMAL(7,2),
  PRIMARY KEY (CartId)
);


/* Load some titles
 */
INSERT INTO Titles VALUES(1,'Night of the Crash Test Dummies','HUM', 1, 5.95, 1995, 1000, 10, '');
INSERT INTO Titles VALUES(2,'The Far Side','HUM', 1, 5.95, 1984, 200, 1, '');
INSERT INTO Titles VALUES(3,'Wildlife Preserves','HUM', 1, 5.95, 1989, 250, 0, '');
INSERT INTO Titles VALUES(4,'Body Language','HELP', 2, 12.95, 1988, 1500, 20, '');
INSERT INTO Titles VALUES(5,'Why Women Can''t Read Maps','HELP', 2, 12.95, 1988, 900, 5, '');
INSERT INTO Titles VALUES(6,'Going Solo','BIOG', 3, 8.95, 1986, 150, 9, '');
INSERT INTO Titles VALUES(7,'The Penguin Leunig','HUM', 3, 4.95, 1974, 310, 6, '');
INSERT INTO Titles VALUES(8,'The Java Way','COMP', 4, 15.0, 1988, 200, 10, '');
INSERT INTO Titles VALUES(9,'JFK','BIOG', 5, 3.45, 1978, 55, 11, '');
INSERT INTO Titles VALUES(10,'The Bedtime Leunig','HUM', 3, 4.95, 1974, 310, 14, '');
INSERT INTO Titles VALUES(11,'Nineteen Eighty Four','FICT', 6, 18.95, 1949, 500, 15, '');

/* Load some authors
 */
INSERT INTO Authors VALUES(1, 'Larsen', 'Gary', 'UNKNOWN', 'Main St', 'Kansas City', 'KA', null, 'USA');
INSERT INTO Authors VALUES(2, 'Pease', 'Alan', 'UNKNOWN', 'Pittwater Rd', 'Narrabeen', 'NSW', null, 'AUSTRALIA');
INSERT INTO Authors VALUES(3, 'Pease', 'Barbara', 'UNKNOWN', 'Pittwater Rd', 'Narrabeen', 'NSW', null, 'AUSTRALIA');
INSERT INTO Authors VALUES(4, 'Dahl', 'Roald', 'UNKNOWN', 'Andersson St', 'Oslo', null, null, 'NORWAY');
INSERT INTO Authors VALUES(5, 'Hamilton', 'Nigel', 'UNKNOWN', 'Grand Bvd', 'Boston', 'MA', null, 'USA');
INSERT INTO Authors VALUES(6, 'Leunig', 'Michael', 'UNKNOWN', 'Swanson St', 'Melbourne', 'VIC', null, 'AUSTRALIA');
INSERT INTO Authors VALUES(7, 'Brown', 'Dan', 'UNKNOWN', 'Main St', 'Boston', 'MA', null, 'USA');
INSERT INTO Authors VALUES(8, 'Orwell', 'George', 'UNKNOWN', 'Main St', 'London', null, null, 'ENGLAND');
INSERT INTO Authors VALUES(9, 'Sparke', 'Gerard', '43484000', 'Brush Rd', 'Ourimbah', 'NSW', '2260', 'AUSTRALIA');
INSERT INTO Authors VALUES(10, 'Shakespeare', 'William', 'UNKNOWN', 'Piccadilly St', 'Stratford', null, null, 'ENGLAND');

/* Load some titles & authors
 */
INSERT INTO TitleAuthor VALUES(1, 1, 100);
INSERT INTO TitleAuthor VALUES(1, 2, 100);
INSERT INTO TitleAuthor VALUES(1, 3, 100);
INSERT INTO TitleAuthor VALUES(2, 4, 50);
INSERT INTO TitleAuthor VALUES(2, 5, 50);
INSERT INTO TitleAuthor VALUES(3, 4, 50);
INSERT INTO TitleAuthor VALUES(3, 5, 50);
INSERT INTO TitleAuthor VALUES(4, 6, 100);
INSERT INTO TitleAuthor VALUES(6, 7, 100);
INSERT INTO TitleAuthor VALUES(9, 8, 100);
INSERT INTO TitleAuthor VALUES(5, 9, 100);
INSERT INTO TitleAuthor VALUES(6, 10, 100);
INSERT INTO TitleAuthor VALUES(8, 11, 0);

/* Load some publishers 
 */
INSERT INTO Publishers VALUES(1, 'Andrews', 'Kansas City','KA', 'USA'); 
INSERT INTO Publishers VALUES(2, 'Camel Publishing', 'Avalon Beach','NSW', 'AUSTRALIA'); 
INSERT INTO Publishers VALUES(3, 'Penguin', 'Ringwood','VIC', 'AUSTRALIA'); 
INSERT INTO Publishers VALUES(4, 'Pearson Ed', 'Sydney','', 'AUSTRALIA'); 
INSERT INTO Publishers VALUES(5, 'Harper', 'Boston','', 'USA');
INSERT INTO Publishers VALUES(6, 'Secker & Warburg', 'London','', 'ENGLAND');  

/* Load some customers - use fields in order of table definition
 */
INSERT INTO Customers (FirstName, LastName, Gender, Email, Address, City, State, Postcode, Country, Password)
  VALUES('Sarah','Parker','F','sarah00@hotmail', 'Hollywood Bvde','Springfield','PA','10010', 'USA', '');
INSERT INTO Customers (FirstName, LastName, Gender, Email, Address, City, State, Postcode, Country, Password)
  VALUES('John','Howard','M','jhoward@bigpond.com', 'The Lodge','Canberra','ACT','2600', 'AUSTRALIA', '');
INSERT INTO Customers (FirstName, LastName, Gender, Email, Address, City, State, Postcode, Country, Password)
  VALUES('Ricky','Ponting','M','rponting@bigpond.com','Main St','Hobart','TAS','7000', 'AUSTRALIA', '');
INSERT INTO Customers (FirstName, LastName, Gender, Email, Address, City, State, Postcode, Country, Password)
  VALUES('Edna','Everidge','F','glad@bigpond.com','Swanson St','Melbourne','VIC','5000', 'AUSTRALIA', '');
INSERT INTO Customers (FirstName, LastName, Gender, Email, Address, City, State, Postcode, Country, Password)
  VALUES('Lleyton','Hewitt','M','lh@bigpond.com','Rundle Mall','Adelaide','SA','5000', 'AUSTRALIA', '');
INSERT INTO Customers (FirstName, LastName, Gender, Email, Address, City, State, Postcode, Country, Password)
  VALUES('Tony','Blair','M','tony@aol.com.uk','10 Downing St','London','','LN4.4JG', 'BRITAIN', '');
INSERT INTO Customers (FirstName, LastName, Gender, Email, Address, City, State, Postcode, Country, Password)
  VALUES('Osama','Bin Laden','M','terror@bigfish.com','No fixed address','Kabul','','', 'AFGHANISTAN', '');
INSERT INTO Customers (FirstName, LastName, Gender, Email, Address, City, State, Postcode, Country, Password) 
  VALUES('Aunty','Jack','F','aunty@bigfish.com','Blast St','Wollongong','NSW','2500', 'AUSTRALIA', '');
INSERT INTO Customers (FirstName, LastName, Gender, Email, Address, City, State, Postcode, Country, Password) 
  VALUES('Homer','Simpson','M','chunkylover53@aol.com','94 Evergreen Terrace','Springfield','PA','', 'USA', '');
INSERT INTO Customers (FirstName, LastName, Gender, Email, Address, City, State, Postcode, Country, Password)
  VALUES('Cheryl','Curnow','F','cc@aol.com','10 Coolabah St','Springfield','NSW','2250', 'AUSTRALIA', '');

INSERT INTO Category VALUES('HUM','Comedy');
INSERT INTO Category VALUES('BIOG','Biography');
INSERT INTO Category VALUES('HELP','Self-help');
INSERT INTO Category VALUES('FICT','Fiction');
INSERT INTO Category VALUES('COMP','COMPUTER');

INSERT INTO Orders VALUES(1, 1, '2006-11-21', 'TNT'); 
INSERT INTO Orders VALUES(2, 9, '2006-11-22', 'TNT'); 
INSERT INTO Orders VALUES(3, 4, '2006-11-23', 'TNT'); 
INSERT INTO Orders VALUES(4, 2, '2006-12-02', 'TNT'); 
INSERT INTO Orders VALUES(5, 3, '2006-12-03', 'TNT'); 
INSERT INTO Orders VALUES(6, 1, '2006-12-03', 'TNT'); 

INSERT INTO OrderItems VALUES(1, 1, 2, 5.95); 
INSERT INTO OrderItems VALUES(1, 2, 1, 5.95); 
INSERT INTO OrderItems VALUES(1, 3, 1, 5.95); 
INSERT INTO OrderItems VALUES(2, 1, 1, 5.95); 
INSERT INTO OrderItems VALUES(3, 4, 1, 12.95); 
INSERT INTO OrderItems VALUES(3, 7, 1, 4.95);
 
INSERT INTO OrderItems VALUES(4, 1, 2, 5.95); 
INSERT INTO OrderItems VALUES(4, 2, 1, 5.95); 
INSERT INTO OrderItems VALUES(4, 3, 1, 5.95); 
INSERT INTO OrderItems VALUES(5, 4, 3, 12.95); 
INSERT INTO OrderItems VALUES(6, 5, 1, 12.95); 
INSERT INTO OrderItems VALUES(6, 6, 1, 8.95); 


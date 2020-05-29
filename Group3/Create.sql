CREATE DATABASE RALaundry

USE RALaundry

	-- Master Tables --

CREATE TABLE MsStaff (
	StaffId CHAR(5) PRIMARY KEY
		CHECK (StaffID LIKE 'ST[0-9][0-9][0-9]'),
	StaffName VARCHAR(MAX) NOT NULL,
	StaffAddress VARCHAR(MAX) NOT NULL,
	StaffGender VARCHAR(6) NOT NULL
		CHECK (StaffGender LIKE 'Male' OR StaffGender LIKE 'Female'),
	StaffSalary INT NOT NULL
		CHECK (StaffSalary BETWEEN 1500000 AND 3000000)	
)

CREATE TABLE MsCustomer (
	CustomerId CHAR(5) PRIMARY KEY
		CHECK (CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CustomerName VARCHAR(MAX) NOT NULL,
	CustomerAddress VARCHAR(MAX) NOT NULL,
	CustomerGender VARCHAR(6)
		CHECK (CustomerGender LIKE 'Male' OR CustomerGender LIKE 'Female'),
	CustomerDOB DATE NOT NULL
)

CREATE TABLE MsVendor (
	VendorId CHAR(5) PRIMARY KEY
		CHECK (VendorID LIKE 'VE[0-9][0-9][0-9]'),
	VendorName VARCHAR(MAX) NOT NULL,
	VendorAddress VARCHAR(MAX) NOT NULL
		CHECK (LEN(VendorAddress) > 10),
	VendorPhoneNumber VARCHAR(MAX) NOT NULL
)

CREATE TABLE MsMaterial (
	MaterialId CHAR(5) PRIMARY KEY
		CHECK (MaterialID LIKE 'MA[0-9][0-9][0-9]'),
	MaterialName VARCHAR(MAX) NOT NULL,
	MaterialType VARCHAR(9)
		CHECK (MaterialType LIKE 'Equipment' OR MaterialType LIKE 'Supplies'),
	MaterialPrice INT NOT NULL
)

CREATE TABLE MsClothes (
	ClothesId CHAR(5) PRIMARY KEY
		CHECK (ClothesID LIKE 'CL[0-9][0-9][0-9]'),
	ClothesName VARCHAR(MAX) NOT NULL,
	ClothesType VARCHAR(9)
		CHECK (ClothesType IN ('Cotton', 'Viscose', 'Polyester', 'Linen', 'Wool'))
)

	-- Transaction Tables --

CREATE TABLE TrPurchaseHeader (
	PurchaseId CHAR(5) PRIMARY KEY
		CHECK(PurchaseId LIKE 'PU[0-9][0-9][0-9]'),
	StaffId CHAR(5)
		FOREIGN KEY REFERENCES MsStaff(StaffId),
	VendorId CHAR(5)
		FOREIGN KEY REFERENCES MsVendor(VendorId),
	PurchaseDate DATE NOT NULL
		CHECK(YEAR(PurchaseDate) = '2019')
)

CREATE TABLE TrServiceHeader (
	ServiceId CHAR(5) PRIMARY KEY
		CHECK(ServiceId LIKE 'SR[0-9][0-9][0-9]'),
	StaffId CHAR(5)
		FOREIGN KEY REFERENCES MsStaff(StaffId),
	CustomerId CHAR(5)
		FOREIGN KEY REFERENCES MsCustomer(CustomerId),
	ServiceDate DATE NOT NULL
		CHECK(YEAR(ServiceDate) = '2019')
)

	-- Transaction Detail Tables

CREATE TABLE TrPurchaseDetail (
	PurchaseId CHAR(5)
		FOREIGN KEY REFERENCES TrPurchaseHeader(PurchaseId),
	MaterialId CHAR(5)
		FOREIGN KEY REFERENCES MsMaterial(MaterialId),
	Quantity INT NOT NULL
	PRIMARY KEY(PurchaseId,MaterialId)
)



CREATE TABLE TrServiceDetail (
	ServiceId CHAR(5) NOT NULL
		FOREIGN KEY REFERENCES TrServiceHeader(ServiceId),
	ClothesId CHAR(5) NOT NULL
		FOREIGN KEY REFERENCES MsClothes(ClothesId),
	ServiceType VARCHAR(MAX)
		CHECK (ServiceType IN ('Laundry Service', 'Dry Cleaning Service', 'Ironing Service')),
	ServicePrice INT
	PRIMARY KEY(ServiceId, ClothesId)
)

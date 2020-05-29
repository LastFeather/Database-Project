USE RALaundry

	-- Soal 1 --

SELECT MC.CustomerId,
	CustomerName,
	[TotalServicePrice] = SUM(TSD.ServicePrice)
FROM MsCustomer MC
JOIN TrServiceHeader TSH ON MC.CustomerId = TSH.CustomerId
JOIN TrServiceDetail TSD ON TSH.ServiceId = TSD.ServiceId
WHERE DATENAME(MONTH, TSH.ServiceDate) = 'July' AND
	CustomerGender LIKE 'Male'
GROUP BY MC.CustomerId, CustomerName

	-- Soal 2 --

SELECT MS.StaffName,
	PurchaseDate,
	[TotalTransaction] = COUNT(PurchaseId)
FROM MsStaff MS
JOIN TrPurchaseHeader TPH ON MS.StaffId = TPH.StaffId
WHERE MS.StaffName LIKE '%o%'
GROUP BY MS.StaffName, PurchaseDate
HAVING COUNT(PurchaseId) > 1

	-- Soal 3 --

SELECT VendorName,
	[PurchaseDate] = CONVERT(NVARCHAR, PurchaseDate, 107),
	[TotalTransaction] = COUNT(TPH.PurchaseId),
	[TotalPurchasePrice] = SUM(Quantity*MaterialPrice)
FROM MsVendor MV
JOIN TrPurchaseHeader TPH ON MV.VendorId = TPH.VendorId
JOIN TrPurchaseDetail TPD ON TPH.PurchaseId = TPD.PurchaseId
JOIN MsMaterial MM ON MM.MaterialId = TPD.MaterialId
WHERE VendorName LIKE 'PT. %' AND
	DAY(PurchaseDate) % 2 = 1
GROUP BY VendorName, PurchaseDate

	-- Soal 4 --
	
SELECT StaffName,
	MaterialName,
	[TotalTranscation] = COUNT(TPH.PurchaseId),
	[TotalQuantity] = CAST(SUM(Quantity) AS VARCHAR) + ' pcs'
FROM TrPurchaseHeader TPH
JOIN MsStaff MS ON MS.StaffId = TPH.StaffId
JOIN TrPurchaseDetail TPD ON TPD.PurchaseId = TPH.PurchaseId
JOIN MsMaterial MM ON MM.MaterialId = TPD.MaterialId
WHERE DATENAME(MONTH, PurchaseDate) = 'July'
GROUP BY StaffName, MaterialName
HAVING SUM(Quantity) < 9

	-- Soal 5 --

SELECT [MaterialId] = STUFF(MM.MaterialId, 1, 2, 'Material'),
	[MaterialName] = UPPER(MaterialName),
	PurchaseDate,
	Quantity
FROM MsMaterial MM
JOIN TrPurchaseDetail TPD ON TPD.MaterialId = MM.MaterialId
JOIN (
	SELECT PurchaseId, PurchaseDate
	FROM TrPurchaseHeader
) AS A ON A.PurchaseId = TPD.PurchaseId
WHERE Quantity > (
		SELECT AVG(Quantity)
		FROM TrPurchaseDetail
	) AND MaterialType = 'Supplies'
ORDER BY MM.MaterialId

	-- Soal 6 --

SELECT StaffName,
	CustomerName,
	[ServiceDate] = CONVERT(NVARCHAR, ServiceDate, 106)
FROM TrServiceHeader TSH
JOIN (
	SELECT StaffId, StaffName, StaffSalary
	FROM MsStaff
) AS A ON A.StaffId = TSH.StaffId
JOIN (
	SELECT CustomerId, CustomerName
	FROM MsCustomer
) AS B ON B.CustomerId = TSH.CustomerId
WHERE StaffSalary > (
	SELECT AVG(StaffSalary)
	FROM MsStaff
) AND StaffName NOT LIKE '% %'

	-- Soal 7 --

SELECT ClothesName,
	TotalTransaction,
	[ServiceType] = LEFT(ServiceType, CHARINDEX(' ', ServiceType)-1),
	ServicePrice
FROM MsClothes MC
JOIN (
	SELECT ClothesId,
		ServiceType,
		ServicePrice,
		[TotalTransaction] = CAST(COUNT(ServiceId) AS VARCHAR) + ' transaction'
	FROM TrServiceDetail
	GROUP BY ClothesId, ServiceType, ServicePrice
) AS A ON A.ClothesId = MC.ClothesId
WHERE ServicePrice < (
	SELECT AVG(ServicePrice)
	FROM TrServiceDetail
) AND ClothesType = 'Cotton'

	-- Soal 8 --

SELECT [StaffFirstName] = LEFT(StaffName, CHARINDEX(' ', StaffName)-1),
	VendorName,
	VendorPhoneNumber,
	[TotalTransaction] = SUM(B.TotalTransaction)
FROM MsStaff MS
JOIN TrPurchaseHeader TPH ON TPH.StaffId = MS.StaffId
JOIN (
	SELECT VendorId,
		VendorName,
		[VendorPhoneNumber] = STUFF(VendorPhoneNumber, 1, 2, '+628')
	FROM MsVendor
) AS A ON A.VendorId = TPH.VendorId
JOIN (
	SELECT PurchaseId,
		[TotalTransaction] = COUNT(PurchaseId)
	FROM TrPurchaseDetail
	WHERE Quantity > (
		SELECT AVG(Quantity)
		FROM TrPurchaseDetail
	)
	GROUP BY PurchaseId
) AS B ON B.PurchaseId = TPH.PurchaseId
WHERE CHARINDEX(' ', StaffName) > 0
GROUP BY StaffName, VendorName, VendorPhoneNumber

	-- Soal 9 --

CREATE VIEW ViewMaterialPurchase
AS
SELECT MaterialName,
	[MaterialPrice] = FORMAT(MaterialPrice, 'C0', 'in-ID'),
	[TotalTransaction] = COUNT(PurchaseId),
	[TotalPrice] = SUM(Quantity*MaterialPrice)
FROM MsMaterial MM
JOIN TrPurchaseDetail TPD ON TPD.MaterialId = MM.MaterialId
WHERE MaterialType = 'Supplies'
GROUP BY MaterialName, MaterialPrice
HAVING COUNT(PurchaseId) > 2

SELECT * FROM ViewMaterialPurchase

	-- Soal 10 --
	
CREATE VIEW ViewMaleCustomerTransaction
AS
SELECT CustomerName,
	ClothesName,
	[TotalTransaction] = COUNT(TSD.ServiceId),
	[TotalPrice] = SUM(ServicePrice)
FROM MsCustomer MC
JOIN TrServiceHeader TSH ON TSH.CustomerId = MC.CustomerId
JOIN TrServiceDetail TSD ON TSD.ServiceId = TSH.ServiceId
JOIN MsClothes ML ON ML.ClothesId = TSD.ClothesId
WHERE CustomerGender LIKE 'Male' AND ClothesType IN ('Wool','Linen')
GROUP BY CustomerName, ClothesName

SELECT * FROM ViewMaleCustomerTransaction ORDER BY CustomerName

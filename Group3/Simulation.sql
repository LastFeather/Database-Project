USE RALaundry

--- D. Simulasikan proses service dan purchase transaction

---					SERVICE

--- Cerita :
--- Seorang customer bernama Amethyst Pops,
--- keterangan profil :
---		Customer Name		: Amethyst Pops
---		Customer Address	: Boundless Edge 
---		Customer Gender		: Gender Male
---		Customer DOB		: 3 Januari 2004
---	ingin mencuci 2 bajunya di RALaundry, yaitu
---		"Fox Jacket" dengan tipe baju Polyester
---		"Swallowtail Shirt" dengan tipe baju Linen
--- ia ingin kedua bajunya di laundry dengan ServiceType "Laundry Service".
--- Transaksi terjadi pada tanggal 9 September 2019
--- oleh staff ST017 (Xeros Dagger)
--- dan ternyata harga dari servicenya yaitu
---		"Fox Jacket" seharga 29000
---		"Swallowtail Shirt" seharga 21000

--- Simulasi :
--- 1. Insert data Customer
INSERT INTO MsCustomer 
VALUES
('CU018', 'Amethyst Pops', 'Boundless Edge', 'Male', '3 January 2004')
--- 2. Insert data Clothes / baju yang ingin dicuci
INSERT INTO MsClothes 
VALUES
('CL018', 'Fox Jacket', 'Polyester'),
('CL019', 'Swallowtail Shirt', 'Linen')
--- 3. Insert data transaksi servis (Staffnya ST017 - Xeros Dagger)
INSERT INTO TrServiceHeader 
VALUES
('SR022', 'ST017', 'CU018', '9 September 2019')
--- 4. Insert detail dari transaksi servis
INSERT INTO TrServiceDetail 
VALUES
('SR022', 'CL018', 'Laundry Service', 29000),
('SR022', 'CL019', 'Laundry Service', 21000)

---				PURCHASE

--- Cerita :
--- Stok Material di RALaundry mulai habis maka dari itu,
--- RALaundry memesan Material baru bernama "Elixir"
--- sebanyak 16 pcs
--- pada tanggal 19 Desember 2019.
--- Harga "Elixir" yaitu 21000 per pc
--- dengan Material Type "Supplies"
--- dari sebuah vendor baru bernama PT. Magna Exceed,
--- keterangan profil :
---		Vendor Name		: PT. Magna Exceed
---		Vendor Address	: Eighteenth Avenue
---		Vendor Phone	: 087842491781
--- Selain itu, Staff yang mengurus pemesanan tersebut adalah
--- seorang staff baru bernama Anesthesia Virgo,
--- keterangan profil :
---		Staff Name		: Anesthesia Virgo
---		Staff Address	: Starmoon Valley
---		Staff Gender	: Female
---		Staff Salary	: 1500000
--- Selain Elixir, RALaundry juga memesan 20 pcs Lava dari PT. Magna Exceed

--- Simulasi :
--- 1. Insert data Material / barang yang ingin dibeli
INSERT INTO MsMaterial 
VALUES
('MA018', 'Elixir', 'Supplies', 21000)
--- 2. Insert data Staff
INSERT INTO MsStaff 
VALUES
('ST018', 'Anesthesia Virgo', 'Starmoon Valley', 'Female', 1500000)
--- 3. Insert data Vendor
INSERT INTO MsVendor 
VALUES
('VE018', 'PT. Magna Exceed', 'Eighteenth Avenue', '087842491781')
--- 4. Insert data transaksi pembelian
INSERT INTO TrPurchaseHeader 
VALUES
('PU030', 'ST018', 'VE018','19 December 2019')
--- 5. Insert detail dari transaksi pembelian
INSERT INTO TrPurchaseDetail
VALUES
('PU030', 'MA018', 16),
('PU030', 'MA006', 20)

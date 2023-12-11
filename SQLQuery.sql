-- Step 1: Create or drop and create the database
USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'ExerciseDb')
    DROP DATABASE ExerciseDb;

CREATE DATABASE ExerciseDb;
GO

-- Step 2: Use the ExerciseDb database
USE ExerciseDb;
GO

-- Step 3: Create the Products table
CREATE TABLE Products (
    Pid INT PRIMARY KEY,
    PQ NVARCHAR(50),
    PPrice FLOAT,
    DiscountPercent FLOAT,
    ManufacturingDate DATE
);
GO

-- Step 4: Insert at least 5 records
INSERT INTO Products (Pid, PQ, PPrice, DiscountPercent, ManufacturingDate)
VALUES
    (1, 'ABC', 100, 10, '2019-01-01'),
    (2, 'XYZ', 150, 15, '2018-03-05'),
    (3, 'LMN', 200, 20, '2020-05-08'),
    (4, 'PQR', 120, 12, '2015-06-09'),
    (5, 'DEF', 180, 18, '2024-02-06');
GO

-- Step 5: Create a function to calculate discounted value
CREATE FUNCTION dbo.CalculateDiscountedValue
(
    @price FLOAT,
    @discountPercent FLOAT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @discountedValue FLOAT;
    SET @discountedValue = @price - (@price * (@discountPercent / 100));
    RETURN @discountedValue;
END;
GO

-- Step 6: Use the function to display details from the Products table
SELECT
    Pid,
    PPrice AS Price,
    DiscountPercent AS Discount,
    dbo.CalculateDiscountedValue(PPrice, DiscountPercent) AS PriceAfterDiscount
FROM
    Products;
GO
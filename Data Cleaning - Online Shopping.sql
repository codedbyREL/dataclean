--Remove Duplicates

WITH DuplicateCTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY F1, CustomerID, Gender, Location, Tenure_Months, Transaction_ID, Transaction_Date, Product_SKU, Product_Description, Product_Category, Quantity, Avg_Price, Delivery_Charges, Coupon_Status, GST, Date, Offline_Spend, Online_Spend, Month, Coupon_Code, Discount_pct ORDER BY (SELECT NULL)) AS RowNum
    FROM OnlineShoppingDB
)
DELETE FROM DuplicateCTE WHERE RowNum > 1;


-- Date Conversion with 'MM/DD/YYYY' format
UPDATE OnlineShoppingDB
SET Date = 
  CASE
    WHEN ISDATE(Date) = 1 THEN CONVERT(DATETIME, Date, 101)
    ELSE NULL
  END;

  --  Handle Missing Values by Dropping Rows
DELETE FROM OnlineShoppingDB
WHERE F1 IS NULL OR CustomerID IS NULL OR Gender IS NULL OR Location IS NULL
   OR Tenure_Months IS NULL OR Transaction_ID IS NULL OR Transaction_Date IS NULL
   OR Product_SKU IS NULL OR Product_Description IS NULL OR Product_Category IS NULL
   OR Quantity IS NULL OR Avg_Price IS NULL OR Delivery_Charges IS NULL
   OR Coupon_Status IS NULL OR GST IS NULL OR Date IS NULL
   OR Offline_Spend IS NULL OR Online_Spend IS NULL OR Month IS NULL
   OR Coupon_Code IS NULL OR Discount_pct IS NULL;

  --  Convert 'Gender' column to lowercase
UPDATE OnlineShoppingDB
SET Gender = LOWER(Gender);

 -- Convert 'Coupon_Status' column to lowercase
UPDATE OnlineShoppingDB
SET Coupon_Status = LOWER(Coupon_Status);

--  Convert 'Month' column to integer
UPDATE OnlineShoppingDB
SET Month = TRY_CAST(Month AS INT);

--  Convert 'Location' and 'Coupon_Code' columns to lowercase
UPDATE OnlineShoppingDB
SET Location = LOWER(Location),
    Coupon_Code = LOWER(Coupon_Code);

-- Remove Unnecessary Columns
--ALTER TABLE OnlineShoppingDB
--DROP COLUMN Transaction_ID, Product_SKU, Product_Description;

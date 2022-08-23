# Change SaleDate from text string to Date format
SELECT str_to_date(SaleDate,'%M %d, %Y')
FROM lb5.nashville;

UPDATE lb5.nashville
SET SaleDate = str_to_date(SaleDate,'%M %d, %Y');

# Populate Property Address Data
SELECT *
FROM lb5.nashville
WHERE PropertyAddress = '';

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ifnull(a.PropertyAddress,b.PropertyAddress)
FROM lb5.nashville a
JOIN lb5.nashville b
	on a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress = '';

UPDATE lb5.nashville a
JOIN lb5.nashville b
	on a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
SET a.PropertyAddress = b.PropertyAddress
WHERE a.PropertyAddress = '';

# Divide Property Address into Address, City, and State
SELECT SUBSTRING(PropertyAddress, 1, position("," IN PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress, position("," IN PropertyAddress) + 1), length(PropertyAddress) AS Address
FROM lb5.nashville;

ALTER TABLE lb5.nashville
ADD PropertyAddressSplit Nvarchar(255);

UPDATE lb5.nashville
SET PropertyAddressSplit = SUBSTRING(PropertyAddress, 1, position("," IN PropertyAddress)-1);

ALTER TABLE lb5.nashville
ADD PropertyCity Nvarchar(255);

UPDATE lb5.nashville
SET PropertyCity = SUBSTRING(PropertyAddress, position("," IN PropertyAddress) + 1);

SELECT *
FROM lb5.nashville;

#Splitting Owner Address
SELECT SUBSTRING_INDEX((SUBSTRING_INDEX(OwnerAddress,',',1)),',',-1) AS Address,
SUBSTRING_INDEX((SUBSTRING_INDEX(OwnerAddress,',',2)),',',-1) AS Address,
SUBSTRING_INDEX((SUBSTRING_INDEX(OwnerAddress,',',3)),',',-1) AS Address3
FROM lb5.nashville;

ALTER TABLE lb5.nashville
ADD OwnerAddressSplit Nvarchar(255);

UPDATE lb5.nashville
SET OwnerAddressSplit = SUBSTRING_INDEX((SUBSTRING_INDEX(OwnerAddress,',',1)),',',-1)

ALTER TABLE lb5.nashville
ADD OwnerCity Nvarchar(255);

UPDATE lb5.nashville
SET OwnerCity = SUBSTRING_INDEX((SUBSTRING_INDEX(OwnerAddress,',',2)),',',-1);

ALTER TABLE lb5.nashville
ADD OwnerState Nvarchar(255);

UPDATE lb5.nashville
SET OwnerState = SUBSTRING_INDEX((SUBSTRING_INDEX(OwnerAddress,',',3)),',',-1);

SELECT *
FROM lb5.nashville;

# Change "Y" and "N" to "Yes" and "No" in "Sold as Vacant" column
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM lb5.nashville
GROUP by SoldAsVacant
ORDER by 2;

SELECT SoldAsVacant
	,CASE WHEN SoldAsVacant = "Y" THEN "YES"
		 WHEN SoldAsVacant = "N" THEN "NO"
		 ELSE SoldAsVacant
	END
FROM lb5.nashville;

UPDATE lb5.nashville
SET SoldAsVacant = CASE WHEN SoldAsVacant = "Y" THEN "YES"
		 WHEN SoldAsVacant = "N" THEN "NO"
		 ELSE SoldAsVacant
	END

# Remove Unused Columns
SELECT *
FROM lb5.nashville;

ALTER TABLE lb5.nashville
DROP COLUMN OwnerAddress,
DROP COLUMN TaxDistrict,
DROP COLUMN PropertyAddress;

#Rename Column Names
ALTER TABLE lb5.nashville 
RENAME COLUMN PropertyAddressSplit to PropertyAddress,
RENAME COLUMN OwnerAddressSplit to OwnerAddress;








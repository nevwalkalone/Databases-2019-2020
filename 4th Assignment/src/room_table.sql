
--creating Room table with the fields specified from "Listing"

CREATE TABLE "Room" AS 
(SELECT id AS listing_id, accommodates, bathrooms, bedrooms, beds, bed_type, amenities, square_feet, price, weekly_price, monthly_price, security_deposit
FROM "Listing");


--Dropping the specified fields except the ones that we need for Price table

ALTER TABLE "Listing"
DROP COLUMN  accommodates, DROP COLUMN bathrooms, DROP COLUMN bedrooms, DROP COLUMN beds, DROP COLUMN bed_type, DROP COLUMN amenities, DROP COLUMN square_feet;


--Adding the foreign key
ALTER TABLE "Room"
ADD FOREIGN KEY (listing_id) REFERENCES "Listing" (id);

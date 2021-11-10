-- creating location table with the specified fields
CREATE TABLE "Location" AS
(SELECT id AS listing_id, street, neighbourhood, neighbourhood_cleansed, city, state, zipcode, market, smart_location, country_code, country, latitude, longitude, is_location_exact FROM "Listing");


-- Adding foreign keys
ALTER TABLE "Location"
ADD FOREIGN KEY (listing_id) REFERENCES "Listing" (id),
ADD FOREIGN KEY (neighbourhood_cleansed) REFERENCES "Neighbourhood" (neighbourhood);


-- Dropping the old constraint from Listing
ALTER TABLE "Listing"
DROP CONSTRAINT "Listings_neighbourhood_cleansed_fkey";


-- Dropping the specified fields from listing except id
ALTER TABLE "Listing"
DROP COLUMN street, DROP COLUMN neighbourhood, DROP COLUMN neighbourhood_cleansed, DROP COLUMN city, DROP COLUMN state, 
DROP COLUMN zipcode, DROP COLUMN market, DROP COLUMN smart_location, DROP COLUMN country_code, DROP COLUMN country, 
DROP COLUMN latitude, DROP COLUMN longitude, DROP COLUMN is_location_exact ;
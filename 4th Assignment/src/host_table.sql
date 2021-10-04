--Creating Host table with the fields specified from Listings 

CREATE TABLE "Host" AS 
(SELECT DISTINCT host_id AS id, host_url AS url, host_name AS name, host_since AS since,
host_location AS location, host_about AS about, host_response_time AS response_time, host_response_rate AS response_rate, host_acceptance_rate AS acceptance_rate, host_is_superhost 
AS is_superhost, host_thumbnail_url AS thumbnail_url, host_picture_url AS picture_url, host_neighbourhood AS neighbourhood, host_listings_count AS listings_count, host_total_listings_count AS total_listings_count, host_verifications AS verifications, host_has_profile_pic AS has_profile_pic, host_identity_verified AS identity_verified,
calculated_host_listings_count AS calculated_listings_count 
FROM "Listing");


--adding primary key

ALTER TABLE "Host" 
ADD PRIMARY KEY (id);


--Dropping the specified columns in Listing except id

ALTER TABLE "Listing"
 
 DROP COLUMN host_url, DROP COLUMN host_name, DROP COLUMN host_since,
  DROP COLUMN host_location, DROP COLUMN host_about, DROP COLUMN host_response_time,
  DROP COLUMN host_response_rate, DROP COLUMN host_acceptance_rate, DROP COLUMN host_is_superhost,
  DROP COLUMN host_thumbnail_url, DROP COLUMN host_picture_url, DROP COLUMN host_neighbourhood,
  DROP COLUMN host_listings_count, DROP COLUMN host_total_listings_count, DROP COLUMN host_verifications,
  DROP COLUMN host_has_profile_pic, DROP COLUMN host_identity_verified, DROP COLUMN calculated_host_listings_count;


--adding foreign key

ALTER TABLE "Listing"
ADD FOREIGN KEY (host_id) REFERENCES "Host" (id);

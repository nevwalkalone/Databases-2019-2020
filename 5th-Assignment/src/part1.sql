-- creating Amenity table
CREATE TABLE "Amenity" 
(amenity_id BIGSERIAL, amenity_name text,
PRIMARY KEY(amenity_id));


-- inserting each amenity from room table
INSERT INTO "Amenity" (amenity_name)
SELECT DISTINCT unnest(amenities::text[]) FROM "Room";


-- creating a new table that acts
-- as an intermediary between Room and Amenity
CREATE TABLE "Room_connects_with_Amenity" AS 
(SELECT DISTINCT new.listing_id, amenity_id FROM "Amenity", (SELECT listing_id, unnest(amenities::text[]) AS amen FROM "Room") AS new
WHERE amenity_name=amen
ORDER BY new.listing_id,amenity_id);


-- adding a primary key
-- so we can reference it in the new table
-- as a foreign key
ALTER TABLE "Room"
ADD PRIMARY KEY(listing_id);


-- adding a primary key in the new table we created
-- that connects room with amenity and adding the appropriate 
-- foreign keys so it is connected to both of them
ALTER TABLE "Room_connects_with_Amenity"
ADD PRIMARY KEY(listing_id,amenity_id),
ADD FOREIGN KEY(listing_id) REFERENCES "Room"(listing_id),
ADD FOREIGN KEY(amenity_id) REFERENCES "Amenity" (amenity_id);


-- dropping the amenities column
-- from Room
ALTER TABLE "Room"
DROP COLUMN amenities;

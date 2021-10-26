--For Query 1)
CREATE INDEX listing_host_id_idx ON "Listing"(host_id);

--For Query 2)
CREATE INDEX price_guestsincl_price_idx ON "Price"(guests_included,price);

--For Query 3) 
CREATE INDEX host_identity_idx ON "Host"(identity_verified);
CREATE INDEX location_neighb_idx ON "Location"(neighbourhood);

--For Query 4)
CREATE INDEX room_bath_sq_idx ON "Room"(bathrooms,square_feet);

--For Query 5)
CREATE INDEX  geoloc_idx ON "Geolocation"(geometry_coordinates_0_0_0_1);

--For Query 6)
CREATE INDEX location_neighb_cleansed_idx ON "Location"(neighbourhood_cleansed)

--For Query 7)
CREATE INDEX ra_amid_accom_idx ON "Room_connects_with_Amenity"(amenity_id);
CREATE INDEX room_accom_idx ON "Room"(accommodates);
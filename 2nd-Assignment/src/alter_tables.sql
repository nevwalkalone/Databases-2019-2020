-- Adding foreing keys in all tables

ALTER TABLE "Listings"
ADD FOREIGN KEY (neighbourhood_cleansed) REFERENCES "Neighbourhoods"(neighbourhood);


ALTER TABLE "Listings_Summary"
ADD FOREIGN KEY(id) REFERENCES "Listings"(id);


ALTER table "Reviews"
ADD FOREIGN KEY (listing_id) REFERENCES "Listings"(id);


ALTER table "Reviews_Summary"
ADD FOREIGN KEY (listing_id) REFERENCES "Listings"(id);


ALTER table "Calendar"
ADD FOREIGN KEY (listing_id) REFERENCES "Listings"(id);


ALTER table "Geolocation"
ADD FOREIGN KEY (properties_neighbourhood) REFERENCES "Neighbourhoods"(neighbourhood);
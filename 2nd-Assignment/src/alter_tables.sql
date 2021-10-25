
alter table "Listings"
add FOREIGN KEY (neighbourhood_cleansed) REFERENCES "Neighbourhoods"(neighbourhood);

alter table "Listings_Summary"
add FOREIGN KEY(id) REFERENCES "Listings"(id);


alter table "Reviews"
add FOREIGN KEY (listing_id) REFERENCES "Listings"(id);


alter table "Reviews_Summary"
add FOREIGN KEY (listing_id) REFERENCES "Listings"(id);


alter table "Calendar"
add FOREIGN KEY (listing_id) REFERENCES "Listings"(id);

alter table "Geolocation"
add FOREIGN KEY (properties_neighbourhood) REFERENCES "Neighbourhoods"(neighbourhood);


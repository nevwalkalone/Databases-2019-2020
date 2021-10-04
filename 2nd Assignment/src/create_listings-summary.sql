create table "Listings_Summary" (
   id int,
   name varchar(100),
   host_id int,
   host_name varchar(40),
   neighbourhood_group varchar(10),
   neighbourhood varchar(40),
   latitude double precision,
   longitude double precision,
   room_type varchar(20),
   price MONEY,
   minimum_nights INT,
   number_of_reviews INT,
   last_review DATE,
   reviews_per_month FLOAT,
   calculated_host_listings_count INT,
   availability_365 INT,
   PRIMARY KEY (id)
);
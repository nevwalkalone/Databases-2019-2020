create table "Calendar"(
   listing_id int,
   date date,
   available boolean,
   price money,
   adjusted_price money,
   minimum_nights int,
   maximum_nights int,
   PRIMARY KEY (listing_id,date)
);
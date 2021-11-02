-- Creating "Price" Table with the specified fields from Listing

CREATE TABLE "Price" AS 
(SELECT id AS listing_id,price,weekly_price,monthly_price,security_deposit,cleaning_fee,guests_included,extra_people,minimum_nights,maximum_nights,
minimum_minimum_nights,maximum_minimum_nights,minimum_maximum_nights,maximum_maximum_nights,minimum_nights_avg_ntm,maximum_nights_avg_ntm 
FROM "Listing");


-- adding foreign key

ALTER TABLE "Price"
ADD FOREIGN KEY (listing_id) REFERENCES "Listing" (id);


-- changing the type to varchar fist, so we can use the replace function

ALTER TABLE "Price"
ALTER COLUMN price TYPE varchar(10) using price::varchar,
ALTER COLUMN weekly_price TYPE varchar(10) using weekly_price::varchar,
ALTER COLUMN monthly_price TYPE varchar(10) using monthly_price::varchar,
ALTER COLUMN security_deposit TYPE varchar(10) using security_deposit::varchar,
ALTER COLUMN cleaning_fee TYPE varchar(10) using cleaning_fee::varchar,
ALTER COLUMN extra_people TYPE varchar(10) using extra_people::varchar;


-- removing the $ sign from fields that have money type

UPDATE "Price"
SET price = REPLACE(price,',',''),
weekly_price = REPLACE(weekly_price,',',''),
monthly_price = REPLACE(monthly_price,',',''),
security_deposit = REPLACE(security_deposit,',',''),
cleaning_fee = REPLACE(cleaning_fee,',',''),
extra_people = REPLACE(extra_people,',','');


-- removing the , sign from fields that have money type

UPDATE "Price"
SET price = REPLACE(price,'$',''),
weekly_price = REPLACE(weekly_price,'$',''),
monthly_price = REPLACE(monthly_price,'$',''),
security_deposit = REPLACE(security_deposit,'$',''),
cleaning_fee = REPLACE(cleaning_fee,'$',''),
extra_people = REPLACE(extra_people,'$','');


-- altering the column types to numeric

ALTER TABLE "Price"
ALTER column price TYPE numeric(8,0) using price::numeric,
ALTER column weekly_price TYPE numeric(8,0) using weekly_price::numeric,
ALTER column monthly_price TYPE numeric(8,0) using monthly_price::numeric,
ALTER column security_deposit TYPE numeric(8,0) using security_deposit::numeric,
ALTER column cleaning_fee TYPE numeric(8,0) using cleaning_fee::numeric,
ALTER COLUMN extra_people TYPE numeric(8,0) using extra_people::numeric;


-- Dropping the specified fields from Listing except id

ALTER TABLE "Listing"
DROP COLUMN price, DROP COLUMN weekly_price, DROP COLUMN monthly_price,DROP COLUMN security_deposit,DROP COLUMN cleaning_fee, DROP COLUMN guests_included,
DROP COLUMN extra_people, DROP COLUMN minimum_nights, DROP COLUMN maximum_nights, DROP COLUMN minimum_minimum_nights,DROP COLUMN maximum_minimum_nights, 
DROP COLUMN minimum_maximum_nights, DROP COLUMN maximum_maximum_nights, DROP COLUMN minimum_nights_avg_ntm, DROP COLUMN maximum_nights_avg_ntm ;
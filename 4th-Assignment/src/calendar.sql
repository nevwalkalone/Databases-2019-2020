-- changing the type to varchar fist, so we can use the replace function

ALTER TABLE "Calendar"
ALTER COLUMN price TYPE varchar(15) using price::varchar,
ALTER COLUMN adjusted_price varchar(15) using adjusted_price::varchar;


-- removing the $ sign from price field

UPDATE "Calendar"
SET price = REPLACE(price,'$','');


-- removing the , sign from price field

UPDATE "Calendar"
SET price = REPLACE(price,',','');


-- removing the $ sign from adjusted_price field

UPDATE "Calendar"
SET adjusted_price = REPLACE (adjusted_price, '$','');


-- removing the , sign from adjusted_price field

UPDATE "Calendar"
SET adjusted_price= REPLACE(adjusted_price,',','');


-- altering the column types to numeric

ALTER TABLE "Calendar"
ALTER COLUMN price TYPE numeric(8,0) using price::numeric,
ALTER COLUMN adjusted_price TYPE numeric(8,0) using adjusted_price::numeric;


-- We didn't need to modify available field, because it already was of boolean type.

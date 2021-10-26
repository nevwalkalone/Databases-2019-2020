CREATE OR REPLACE FUNCTION change_host()
	RETURNS trigger AS $$
	BEGIN
		IF TG_OP = 'INSERT' THEN
			UPDATE "Host" AS H
			SET listings_count = listings_count + 1
			WHERE H.id=NEW.host_id;
			RETURN NEW;
		ELSIF TG_OP = 'DELETE' THEN 
			UPDATE "Host" AS H 
			SET listings_count = listings_count - 1
			WHERE  H.id=OLD.host_id ;
			RETURN OLD;
		END IF;
		
		END;
		$$ LANGUAGE plpgsql;


CREATE
	TRIGGER hostListings AFTER INSERT OR DELETE 
	ON "Listing"	
	FOR EACH ROW
	EXECUTE PROCEDURE change_host();

--------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION change_listing() 
	RETURNS trigger AS $$
		BEGIN
		IF TG_OP = 'INSERT' THEN
			UPDATE "Listing" AS L
			SET number_of_reviews = number_of_reviews + 1
			WHERE L.id=NEW.listing_id ;
			INSERT INTO "Review_Summary"(listing_id,date)
			VALUES(NEW.listing_id,NEW.date);
			RETURN NEW;	

		ELSIF TG_OP = 'DELETE' THEN 
			UPDATE "Listing" AS L
			SET number_of_reviews = number_of_reviews - 1
			WHERE L.id=OLD.listing_id;
			DELETE FROM "Review_Summary" AS R WHERE OLD.listing_id=R.listing_id AND R.date=OLD.date;
			RETURN OLD;
		END IF;
		END;
		$$ LANGUAGE plpgsql;

CREATE
	TRIGGER reviewsListings AFTER INSERT OR DELETE 
	ON "Review"	
	FOR EACH ROW
	EXECUTE PROCEDURE change_listing();
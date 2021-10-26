------------------------------------------------- PART B ----------------------------------------------------------------------------




-- 1ST QUERY) --Movies_per_year--
SELECT NEW.year_released,COUNT(*) AS movies_per_year
FROM "Movies_Metadata",(select distinct extract(year from release_date) AS year_released from "Movies_Metadata") AS NEW
WHERE extract(year from "Movies_Metadata".release_date)=NEW.year_released
GROUP BY NEW.year_released
ORDER BY NEW.year_released DESC;


-- 2ND QUERY) --Movies_per_genre 
SELECT NEW."genre",COUNT(*) AS "Movies_per_Genre"
FROM "Movies_Metadata",(
	WITH tempor (col) AS ( SELECT genres FROM "Movies_Metadata")
	SELECT DISTINCT "Genres".obj->>'name' AS "genre" FROM tempor, LATERAL (SELECT json_array_elements(tempor.col) as obj) as "Genres") AS NEW
WHERE "Movies_Metadata".genres::text LIKE  '%'|| NEW."genre" ||'%'
GROUP BY NEW."genre"
ORDER BY NEW."genre"


-- 3RD QUERY) --Μovies_per_year_and_genre
SELECT GENRES."genre",YEARS.year_released,COUNT(*) AS "Μovies_per_year_and_genre"
FROM "Movies_Metadata",(select distinct extract(year from release_date) AS year_released from "Movies_Metadata")
AS YEARS,(
	WITH tempor (col) AS ( SELECT genres FROM "Movies_Metadata")
SELECT DISTINCT "Genres".obj->>'name' AS "genre" FROM tempor, LATERAL (SELECT json_array_elements(tempor.col) as obj) as "Genres") AS GENRES
WHERE extract(year from "Movies_Metadata".release_date)=YEARS.year_released  AND "Movies_Metadata".genres::text LIKE  '%'|| GENRES."genre" ||'%'
GROUP BY GENRES."genre",YEARS.year_released
ORDER BY YEARS.year_released DESC


-- 4TH QUERY) --Average_rating_per_genre
SELECT GENRES."genre",ROUND(AVG(rating::numeric),3) AS average_rating_per_genre
FROM "Movies_Metadata","Ratings_Small",

(WITH tempor (col) AS ( SELECT genres FROM "Movies_Metadata")
	SELECT DISTINCT "Genres".obj->>'name' AS "genre" FROM tempor,
	 LATERAL (SELECT json_array_elements(tempor.col) as obj) as "Genres") AS GENRES

WHERE "Movies_Metadata".id="Ratings_Small".movieid AND "Movies_Metadata".genres::text LIKE  '%'|| GENRES."genre" ||'%'
GROUP BY GENRES."genre"


-- 5TH QUERY) --Number_of_Ratings
SELECT userid,COUNT(movieid) AS number_of_ratings
FROM "Ratings_Small"
GROUP BY userid
ORDER BY number_of_ratings DESC


-- 6TH QUERY) --Average_user_rating
SELECT userid,ROUND(AVG(rating)::numeric,3) AS average_user_rating
FROM "Ratings_Small"
GROUP BY userid
ORDER BY average_user_rating DESC


-- View
CREATE VIEW "User_Info" AS(
	SELECT userid,ROUND(AVG(rating)::numeric,3) AS average_user_rating,COUNT(userid) AS number_of_ratings
	FROM "Ratings_Small"
	GROUP BY userid
	ORDER BY number_of_ratings);

/* The relation between the number of ratings and the average rating per user is that users with a low number of
ratings are most likely to have a higher average rating than users with higher number of ratings. Also
we see that more fluctuations occur between users_ratings with <50 number_of_ratings and that there are
not many differences between average_rating with users with more number_of_ratings. We come to this
conclusiοn by viewing the viewtable.png image we created.
*/

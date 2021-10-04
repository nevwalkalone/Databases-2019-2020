
---------------------------------------------------------------------------------------

-- Shows hosts with verified identities
-- that live on areas that appartments are registered
-- along with the ones that havent registered a neighbourhood
-- OUTER JOIN must be used here in order to be able to extract 
-- the null values.

-- Output : 1031 rows

SELECT DISTINCT H.neighbourhood,H.name FROM  "Host" AS H
FULL OUTER JOIN "Location" AS L ON  L.neighbourhood = H.neighbourhood
WHERE H.identity_verified = true; 

-- Show the flats that have more than one bathroom and are bigger
-- than 100 square feet we output flats that dont have weekly_price
-- as well with intergrating outer join in our query.

-- Output : 25 rows

SELECT DISTINCT P.weekly_price,P.listing_id FROM "Price" AS P
FULL OUTER JOIN "Room" AS R ON R.listing_id = P.listing_id
WHERE R.bathrooms > 1 AND CAST(R.square_feet AS NUMERIC(8)) > 100 ;

-- Show how many appartments are registered in every neighbourhood
-- with descending order that their second geometry coordinate is above 20.
-- Only neighbourhoods that have more than 2 registered houses will 
-- be in our results.

-- Output : 39 rows 

SELECT COUNT(L.listing_id),L.neighbourhood_cleansed FROM "Location" AS L
JOIN "Geolocation" AS G ON L.neighbourhood_cleansed = G.properties_neighbourhood
GROUP BY L.neighbourhood_cleansed
WHERE G.geometry_coordinates_0_0_0_1 > 20
HAVING COUNT(L.listing_id)>25
ORDER BY COUNT(L.listing_id) DESC;

-- Show how many appartments existS for every number of guests
-- in the neighbourhood of ambelokhpoi
-- Only if there is more than one house that can host that
-- number of accommodates will show in our result.

-- Output : 3 rows

SELECT COUNT(R.listing_id),R.accommodates FROM "Room" AS R
JOIN "Location" AS L ON L.listing_id = R.listing_id
WHERE L.neighbourhood_cleansed = 'ΑΜΠΕΛΟΚΗΠΟΙ'
GROUP BY R.accommodates
HAVING COUNT(R.listing_id) > 50
ORDER BY R.accommodates ASC;

-- Show the appartments that cant host more than 3 guests
-- and that have an esspreso machine as an amenity
-- results are shown in ascending order based on the
-- number of accomodates.

-- Output : 101 rows

SELECT R.listing_id,R.accommodates FROM "Room" AS R
JOIN "Room_connects_with_Amenity" AS RA ON RA.listing_id = R.listing_id
WHERE RA.amenity_id = 56 AND R.accommodates > 3
ORDER BY R.accommodates ASC;

---------------------------------------------------------------------------------------
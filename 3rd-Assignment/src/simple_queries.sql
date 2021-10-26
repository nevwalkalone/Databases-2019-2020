--WITHOUT JOINS
---------------------------------------------------------------------------------------------------------

/* 

1) Find the first 200 listings with positive reviews(from "Reviews" table)that took place between 2015 and 2017

Output: 200 rows 

*/

SELECT DISTINCT listing_id
FROM "Reviews"
WHERE (comments LIKE '%cheap%' OR comments LIKE '%friendly%' OR comments LIKE '%hospitable%' OR comments LIKE '%perfect%' OR comments LIKE '%amazing%')
AND date BETWEEN '2015-01-01' AND '2017-12-31' 
LIMIT 200;

---------------------------------------------------------------------------------------------------------

/* 

2) Find number of airbnb listings for each host with reviews_per_month over 1.5

Output: 2610 rows 

*/

SELECT host_id,host_name,COUNT(id) AS number_of_reviews_per_month
FROM "Listings"
WHERE reviews_per_month BETWEEN 1.5 AND(
SELECT max(reviews_per_month)
FROM "Listings" )
GROUP BY host_id,host_name
ORDER BY count(id) DESC;

---------------------------------------------------------------------------------------------------------



--INNER JOINS
---------------------------------------------------------------------------------------------------------

/* 

3) Count the number of neighbourhoods with the specific coordinates 

Output: 16 rows  

*/

SELECT COUNT(n.neighbourhood) AS neighbourhood_with_spec_coordinates
FROM "Neighbourhoods" n
INNER JOIN "Geolocation" g
ON n.neighbourhood=g.properties_neighbourhood
WHERE g.geometry_coordinates_0_0_0_0 > 23.550 AND g.geometry_coordinates_0_0_0_1 >38.000;

---------------------------------------------------------------------------------------------------------

/*
 
4) Find airbnb listings in the neighbourhood "ΚΟΛΩΝΑΚΙ" which are available for the dates given and their price is <=average

Output: 179 rows  

*/

SELECT DISTINCT listing_id, name, host_name, summary, space, description, listing_url,"Listings".price,neighbourhood_cleansed
FROM "Listings" 
INNER JOIN "Calendar" 
ON "Listings".id = "Calendar".listing_id
WHERE date BETWEEN '2020-05-19' AND '2020-05-25' AND available='t' AND neighbourhood_cleansed = 'ΚΟΛΩΝΑΚΙ' AND "Listings".price::numeric <=(SELECT ROUND(AVG("Listings".price::numeric),2) FROM "Listings");
---------------------------------------------------------------------------------------------------------

/* 

5) Find reviews for the most expensive airbnb listings with best reviews_scores_rating. 
Also find reviews for airbnb listings with worst possible review_scores_rating and price above or equal to average price. 
Ordered by review_scores_rating

Output: 7 rows  

 */

SELECT "Listings".id,price,review_scores_rating,reviewer_name,comments,date
FROM "Listings", "Reviews"
WHERE "Listings".id="Reviews".listing_id AND(review_scores_rating= (SELECT MAX(review_scores_rating)FROM "Listings") 
AND price::numeric =(SELECT MAX("Listings".price::numeric) FROM "Listings")
OR review_scores_rating=(SELECT MIN(review_scores_rating) FROM "Listings") AND price::numeric >=(SELECT ROUND(AVG("Listings".price::numeric),2) FROM "Listings"))
ORDER BY review_scores_rating;
 
---------------------------------------------------------------------------------------------------------

/*

 6) Find for each neighbourhood average_price,average_score, average_cleaning_fee, etc

Output: 45 rows
 
*/

SELECT N.neighbourhood, ROUND(AVG(review_scores_rating)) AS average_score_per_neighb,ROUND(AVG(price::numeric),2) AS average_price_per_neighb,
ROUND(AVG(cleaning_fee::numeric),2) AS average_cleaning_fee_per_neighb,
ROUND(AVG(extra_people::numeric),2) AS average_extra_people_per_neighb
FROM "Neighbourhoods" AS N
INNER JOIN "Listings" AS L
ON N.neighbourhood=L.neighbourhood_cleansed 
GROUP BY N.neighbourhood
ORDER BY N.neighbourhood;

---------------------------------------------------------------------------------------------------------

/*

7) Find the top 100 reviewers with most reviews 

Output: 100 rows

*/

SELECT R.reviewer_id, R.reviewer_name, COUNT(R.reviewer_id) AS total_reviews_per_reviewer
FROM "Reviews" AS R
INNER JOIN "Listings" AS L
ON L.id=R.listing_id
GROUP BY R.reviewer_id,R.reviewer_name
ORDER BY COUNT(R.reviewer_id) DESC
LIMIT 100;

---------------------------------------------------------------------------------------------------------

/* 

8) Find recent reviews for airbnbs with number of reviews >100 that are  located either on KERAMIKOS OR THISIO with a flexible cancellation policy.

Output: 606 rows

*/

SELECT L.id,L.summary,R.reviewer_name, R.comments, R.date,L.neighbourhood_Cleansed
FROM "Listings" L
INNER JOIN "Reviews" R
ON L.id=R.listing_id
WHERE L.number_of_reviews>100 AND R.date>'2019-06-01' AND L.cancellation_policy='flexible' AND (L.neighbourhood_cleansed= 'ΚΕΡΑΜΕΙΚΟΣ' OR L.neighbourhood_cleansed='ΘΗΣΕΙΟ');

---------------------------------------------------------------------------------------------------------

/* 

9) Find minimum and maximum price for each neighbourhood. Grouped and ordered by neighbourhood.

Output: 45 rows

*/

SELECT N.neighbourhood, MAX(price::numeric) AS max_price_per_neighb,MIN(price::numeric) AS min_price_per_neighb
FROM "Neighbourhoods" AS N
INNER JOIN "Listings" AS L
ON N.neighbourhood=L.neighbourhood_cleansed 
GROUP BY N.neighbourhood
ORDER BY N.neighbourhood;

---------------------------------------------------------------------------------------------------------

/*

10)Show all airbnbs that are located in "ABELOKIPI" OR "GIZI" and are available for the specific dates. Wifi and cable tv must be included too.

Output : 43 rows 
 
*/

SELECT DISTINCT C.listing_id,listing_url,name,picture_url
FROM "Calendar" AS C
JOIN  "Listings" ON listing_id = id
WHERE C.date BETWEEN '05-07-2020' AND '05-11-2020' AND C.available = true AND amenities LIKE '%Wifi%' AND amenities LIKE '%"Cable TV"%' 
AND (neighbourhood_cleansed = 'ΑΜΠΕΛΟΚΗΠΟΙ' OR neighbourhood_cleansed =  'ΓΚΥΖΗ') ;

---------------------------------------------------------------------------------------------------------



--OUTER JOINS
---------------------------------------------------------------------------------------------------------

/* 

11) Top 30 hosts with most airbnbs that their first review date is unknown. Left join would give us the same result
cause we are utilizing only the Listings first_review column with our where statement.
We are using full outer join so we are able to see those null values on first_reviews.

Output : 30 rows

*/

SELECT l.host_id,l.host_name,COUNT(l.id) AS Number_of_null_first_reviews
FROM "Listings" AS l
FULL OUTER JOIN "Reviews" ON date = l.first_review 
WHERE first_review IS NULL
GROUP BY l.host_id,l.host_name
ORDER BY COUNT(l.id) DESC
LIMIT 30;

---------------------------------------------------------------------------------------------------------

/* 

12) Find which reviews dates correspond to first reviews of flats between 2016 to 2017 and which don't
Without the outer join we wouldn't get null values.
Outer join here was used to be able to see the dates that there are no first reviews for any of the ids 
We use the AND statement on the join to be able to connect every review to exactly its first review
Without that addon, our results would get mixed up and we would end up with a big and inefficient result. Ordered by first review. 

Output : 29790 rows
So the number of rows is basically equal to the number of reviews that took place during that period.

 */

SELECT l.first_review,l.id,R.date
FROM "Listings" AS l
FULL OUTER JOIN "Reviews" AS R ON date = l.first_review AND l.id = R.listing_id
WHERE R.date BETWEEN '01-01-2016' AND '01-01-2017' 
ORDER BY first_review;





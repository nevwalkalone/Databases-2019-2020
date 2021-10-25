
------------------------------------------------- PART A----------------------------------------------------------------------------







---------------------------------------------CREATING ALL TABLES--------------------------------------------------------------------




--Credits table creation

create table "Credits"(
   "cast" text,
   crew text,
   id int
);


--Keywords table creation

create table "Keywords"(
   id int,
   keywords text
);


--Links table creation

create table "Links"(
   movieId int,
   imdbId int,
   tmdbId int
);


--Movies_Metadata table creation

create table "Movies_Metadata"(
   adult boolean,
   belongs_to_collection text,
   budget int,
   genres text,
   homepage varchar(2500),
   id int,
   imdb_id varchar(100),
   original_language varchar(10),
   original_title varchar(1100),
   overview text,
   popularity double precision,
   poster_path varchar(100),
   production_companies text,
   production_countries text,
   release_date date,
   revenue bigint,
   runtime double precision,
   spoken_languages text,
   status varchar(50),
   tagline text,
   title varchar(200),
   video boolean,
   vote_average double precision,
   vote_count int
);


--Ratings_Small table creation

create table "Ratings_Small"(
   userId int,
   movieId int,
   rating double precision,
   timestamp bigint
);







------------------------------------------------DATA FILTERING-------------------------------------------------------------------------




--Removing Duplicates from each table


DELETE FROM "Keywords" as a USING (
      SELECT MIN(ctid) as ctid, id
        FROM "Keywords"
        GROUP BY id HAVING COUNT(*) > 1
      )as b
      WHERE a.id = b.id
      AND a.ctid <> b.ctid;


DELETE FROM "Credits" as a USING (
      SELECT MIN(ctid) as ctid, id
        FROM "Credits"
        GROUP BY id HAVING COUNT(*) > 1
      )as b
      WHERE a.id = b.id
      AND a.ctid <> b.ctid;



DELETE FROM "Movies_Metadata" as a USING (
      SELECT MIN(ctid) as ctid, id
        FROM "Movies_Metadata"
        GROUP BY id HAVING COUNT(*) > 1
      )as b
      WHERE a.id = b.id
      AND a.ctid <> b.ctid;



DELETE FROM "Links" as a USING (
      SELECT MIN(ctid) as ctid, tmdbid
        FROM "Links"
        GROUP BY tmdbid HAVING COUNT(*) > 1
      )as b
      WHERE a.tmdbid = b.tmdbid
      AND a.ctid <> b.ctid;



--Removing records containing movies that don't exist in Movies_Metadata

DELETE FROM "Links" WHERE movieid IN (SELECT movieid FROM "Links"
LEFT JOIN "Movies_Metadata"
ON "Links".tmdbid="Movies_Metadata".id
WHERE "Movies_Metadata".id is NULL );


DELETE FROM "Ratings_Small" WHERE movieid IN (SELECT movieid FROM "Ratings_Small"
LEFT JOIN "Movies_Metadata"
ON "Ratings_Small".movieid="Movies_Metadata".id
WHERE "Movies_Metadata".id is NULL );




--It was necessary to replace single quote with double quote so we can alter the specific
-- column type from text to json. The reason this change is needed, is because we
--use genre column in some queries in PARTB.

UPDATE "Movies_Metadata"
SET genres=REPLACE(genres,E'\'',E'\"');


ALTER TABLE "Movies_Metadata"
ALTER COLUMN genres TYPE json using genres::json;






------------------------------------------------PRIMARY KEYS--------------------------------------------------------------------------

--PK for Credits table

ALTER TABLE "Credits"
ADD PRIMARY KEY(id);


--PK for Keywords table

ALTER TABLE "Keywords"
ADD PRIMARY KEY(id);


--PK for Links table

ALTER TABLE "Links"
ADD PRIMARY KEY(movieid);


--PK for Movies_Metadata table

ALTER TABLE "Movies_Metadata"
ADD PRIMARY KEY(id);


--PK for Ratings_Small table

ALTER TABLE "Ratings_Small"
ADD PRIMARY KEY(userid,movieid);







------------------------------------------------FOREIGN KEYS------------------------------------------------------------------------


--FK for Credits table

ALTER TABLE "Credits"
ADD FOREIGN KEY(id) REFERENCES "Movies_Metadata" (id);


--FK for Keywords table

ALTER TABLE "Keywords"
ADD FOREIGN KEY(id) REFERENCES "Movies_Metadata" (id);

--FK for Links table

ALTER TABLE "Links"
ADD FOREIGN KEY(tmdbid) REFERENCES "Movies_Metadata" (id);


--FK for Ratings_Small table

ALTER TABLE "Ratings_Small"
ADD FOREIGN KEY(movieid) REFERENCES "Movies_Metadata" (id);

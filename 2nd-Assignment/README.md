# Second Assignment

It is highly suggested that you read all the details [here](https://github.com/nevwalkalone/PSQL-Projects/blob/main/2nd-Assignment/assignment/2nd-assignment.pdf), so you get a full overview.

In this assignment 3 main actions were requested:

- Create a table for each csv file from the airbnb dataset,
- Import all csv data into the corresponding tables,
- Create the ER Diagram.

Some sql files that create a new table, can be auto generated with the use of [gen_ddl_python3](https://drive.google.com/file/d/1mVgOWewHsTfu_sQSau208Hb6pmsglOsN/view) script, as some csv files had over 90 columns (listings.csv) and it would be very time consuming to create a sql file manually. For example, if you want to generate a sql file that creates a table that matches the listings csv, place the python script in the same directory with the csv files and type in cmd:

```console
python gen_ddl_python3 listings.csv
```

This will save some time. Note that some manual adjustments have to be made in the auto-generated sql file, like primary key constraints. Afterwards you need to connect to your Database via PSQLshell. If you want to run a SQL command from a script, run the following command in PSQLshell:

```console
\i <filename>
```

After all tables are created use the **\copy** command in PSQLshell to import all data from the csv files.
Before running copy, run the command:

```console
set client_encoding to 'utf8';
```

to avoid character encoding issues.

Note that the first line of each csv file is a header. Set a parameter in the copy command to avoid headers. For example:

```console
\copy Listing FROM "airbnb dataset/listings.csv" DELIMITER ',' CSV HEADER;
```

will import listings.csv data into the newly created Listing table.
Add the foreign key constraints after the tables have been populated.

## ER Diagram

The ER Diagram can be found [here](https://github.com/nevwalkalone/PSQL-Projects/blob/main/2nd-Assignment/ER%20Diagram/airbnb_ERD.png).

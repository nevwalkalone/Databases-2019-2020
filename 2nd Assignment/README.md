# Second Assignment

In this assignment 2 main actions were requested:
* Create a table for each csv file from the airbnb dataset,
* Import all csv data into the corresponding tables.

Some sql files that create a new table, can be auto generated with the use of gen_ddl_python3 script, as some csv files had over 90 columns (listings.csv) and it would be very time consuming to create a sql file manually. For example, if you want to generate a sql file that creates the table that matches the calendar csv, place the python script in the same directory with the csv files and type:
```console
python gen_ddl_python3 calendar.csv
```

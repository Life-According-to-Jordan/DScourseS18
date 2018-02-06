-- ******************
-- Import data
-- ******************

.print ' '
.print 'Importing data'
-- First, create the table that the CSV will be stored in
CREATE TABLE "INSURANCE" (
	policyID INTEGER,
  statecode TEXT,
  county TEXT,
	eq_site_limit INTEGER,
	hu_site_lieq_site_limitmit INTEGER,
	fl_site_limit INTEGER,
	fr_site_limit INTEGER,
	tiv_2011 INTEGER,
	tiv_2012 INTEGER,
  eq_site_deductible INTEGER,
  hu_site_deductible INTEGER,
  fl_site_deductible INTEGER,
  fr_site_deductible INTEGER,
  point_latitude INTEGER,
  point_longitude INTEGER,
  line TEXT,
  construction TEXT,
  point_granularity INTEGER,
);

-- Tell SQL to expect a CSV file by declaring CSV mode
.mode csv

-- Next, import the CSV following the directions on the sqlitetutorial website
.import FL_insurance_sample.csv INSURANCE


-- ******************
-- View first 10 observations
-- ******************
.print ' '
.print 'View first 10 observations'
-- View first 10 observations
SELECT * FROM INSURANCE LIMIT 10;


-- ******************
-- How many unique values of a certain variable?
-- ******************
.print ' '
.print 'Unique values'
-- Number of unique counties in the data (lists a number)
SELECT count(distinct county) from INSURANCE;


-- ******************
-- Average 
-- ******************
.print ' '
.print 'Margin of victory'
-- Create new column which is the Wscore-Lscore difference, then find the average of it
SELECT AVG(tiv_2011) FROM INSURANCE;
SELECT AVG(tiv_2012) FROM INSURANCE;
SELECT  AVG(tiv_2011-tiv_2012) FROM INSURANCE;


-- ******************
-- Save as text file
-- ******************
.output INSURANCE.sqlite3
.dump


-- TYLER_TIP: You can execute this file from the Linux command line by issuing the following:
-- sqlite3 < SQLexample.sql > SQLexample.sqlog

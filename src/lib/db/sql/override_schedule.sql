-- Script to create table for override_schedule 

CREATE TABLE OVERRIDE_SCHEDULE	( TEAM_ID	INT		NOT NULL REFERENCES TEAM(TEAM_ID),
			  	  CAL_DATE	DATE		NOT NULL, 
			  	  OLD_EMP	VARCHAR(32) 	NOT NULL,
			  	  NEW_EMP	VARCHAR(32) 	NOT NULL
				);
ALTER TABLE OVERRIDE_SCHEDULE ADD COLUMN SHIFT VARCHAR(2) NOT NULL DEFAULT '2' AFTER CAL_DATE;

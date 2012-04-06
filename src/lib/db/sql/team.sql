-- Script to create table for team 

CREATE TABLE TEAM	( TEAM_ID                  INT         NOT NULL PRIMARY KEY,
			  COMPANY                  INT         NOT NULL REFERENCES COMPANY(ID),
			  TEAM_NAME                VARCHAR(32) NOT NULL,
			  TEAM_MAX_SIZE_WKDAY      INT         NOT NULL,
			  TEAM_MIN_SIZE_WKDAY      INT         NOT NULL,
			  TEAM_MAX_SIZE_WKEND      INT         NOT NULL,
			  TEAM_MIN_SIZE_WKEND      INT         NOT NULL
			);


ALTER TABLE TEAM AUTO_INCREMENT=10000; 

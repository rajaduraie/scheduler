CREATE TABLE EMPLOYEE ( ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
                        NAME VARCHAR(128),
                        COMPANY_ID INT NOT NULL REFERENCES COMPANY(ID),
                        TEAM_ID NOT INT NULL REFERENCES TEAM(ID),
                        LABEL INT,
                        EMAIL_ID VARCHAR(64)NOT NULL,
                        DEFAULT_SHIFT VARCHAR(1),
                        ADDRESS_STR1 VARCHAR(64),
                        ADDRESS_STR2 VARCHAR(64),
                        ADDRESS_CITY VARCHAR(16),
                        ADDRESS_ZIP VARCHAR(16),
                        ADDRESS_STATE VARCHAR(16),
                        ADDRESS_COUNTRY VARCHAR(16)
                      );

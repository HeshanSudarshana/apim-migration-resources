CREATE TABLE AM_SYSTEM_APPS (
  ID INTEGER,
  NAME VARCHAR2(50) NOT NULL,
  CONSUMER_KEY VARCHAR2(512) NOT NULL,
  CONSUMER_SECRET VARCHAR2(512) NOT NULL,
  CREATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (NAME),
  UNIQUE (CONSUMER_KEY),
  PRIMARY KEY (ID)
)
/

CREATE SEQUENCE AM_SYSTEM_APP_SEQUENCE START WITH 1 INCREMENT BY 1 NOCACHE
/

CREATE OR REPLACE TRIGGER AM_SYSTEM_APPS_TRIG
  BEFORE INSERT
  ON AM_SYSTEM_APPS
  REFERENCING NEW AS NEW
  FOR EACH ROW
     BEGIN
         SELECT AM_SYSTEM_APP_SEQUENCE.nextval INTO :NEW.ID FROM dual;
     END;
/

CREATE TABLE AM_API_CLIENT_CERTIFICATE (
  TENANT_ID INTEGER NOT NULL,
  ALIAS VARCHAR2(45) NOT NULL,
  API_ID INTEGER NOT NULL,
  CERTIFICATE BLOB NOT NULL,
  REMOVED INTEGER DEFAULT 0 NOT NULL,
  TIER_NAME VARCHAR2 (512),
  FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE,
  PRIMARY KEY (ALIAS, TENANT_ID, REMOVED)
)
/

ALTER TABLE AM_POLICY_SUBSCRIPTION ADD (
  MONETIZATION_PLAN VARCHAR(25) DEFAULT NULL NULL,
  FIXED_RATE VARCHAR(15) DEFAULT NULL NULL,
  BILLING_CYCLE VARCHAR(15) DEFAULT NULL NULL,
  PRICE_PER_REQUEST VARCHAR(15) DEFAULT NULL NULL,
  CURRENCY VARCHAR(15) DEFAULT NULL NULL
)
/

CREATE TABLE AM_MONETIZATION_USAGE_PUBLISHER (
	ID VARCHAR(100) NOT NULL,
	STATE VARCHAR(50) NOT NULL,
	STATUS VARCHAR(50) NOT NULL,
	STARTED_TIME VARCHAR(50) NOT NULL,
	PUBLISHED_TIME VARCHAR(50) NOT NULL,
	PRIMARY KEY(ID)
)
/

CREATE TABLE AM_NOTIFICATION_SUBSCRIBER (
    UUID VARCHAR2(255),
    CATEGORY VARCHAR2(255),
    NOTIFICATION_METHOD VARCHAR2(255),
    SUBSCRIBER_ADDRESS VARCHAR2(255) NOT NULL,
    PRIMARY KEY(UUID, SUBSCRIBER_ADDRESS)
)
/

DROP SEQUENCE AM_API_COMMENTS_SEQUENCE
/

DROP TRIGGER AM_API_COMMENTS_TRIGGER
/

ALTER TABLE AM_EXTERNAL_STORES
ADD LAST_UPDATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP
/

ALTER TABLE AM_API
  ADD API_TYPE VARCHAR(10) DEFAULT NULL NULL
/

CREATE TABLE AM_API_PRODUCT_MAPPING (
  API_PRODUCT_MAPPING_ID INTEGER,
  API_ID INTEGER,
  URL_MAPPING_ID INTEGER,
  FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
  FOREIGN KEY (URL_MAPPING_ID) REFERENCES AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
  PRIMARY KEY(API_PRODUCT_MAPPING_ID)
)
/

CREATE SEQUENCE AM_API_PRODUCT_MAPPING_SEQ START WITH 1 INCREMENT BY 1
/

CREATE OR REPLACE TRIGGER AM_API_PRODUCT_MAPPING_TRIGGER
  BEFORE INSERT
  ON AM_API_PRODUCT_MAPPING
  REFERENCING NEW AS NEW
  FOR EACH ROW
  BEGIN
    SELECT AM_API_PRODUCT_MAPPING_SEQ.nextval INTO :NEW.API_PRODUCT_MAPPING_ID FROM dual;
  END;
/

-- Start of Data Migration Scripts --
ALTER TABLE AM_API_COMMENTS
  DROP COLUMN COMMENT_ID
/

ALTER TABLE AM_API_COMMENTS
  ADD COMMENT_ID VARCHAR(255) DEFAULT (SYS_GUID()) NOT NULL
/

ALTER TABLE AM_API_RATINGS
	DROP COLUMN RATING_ID
/

ALTER TABLE AM_API_RATINGS
  ADD RATING_ID VARCHAR(255) DEFAULT (SYS_GUID()) NOT NULL
/
                                      
CREATE TABLE AM_REVOKED_JWT (
    UUID VARCHAR(255) NOT NULL,
    SIGNATURE VARCHAR(2048) NOT NULL,
    EXPIRY_TIMESTAMP NUMBER(19) NOT NULL,
    TENANT_ID INTEGER DEFAULT -1,
    TOKEN_TYPE VARCHAR(15) DEFAULT 'DEFAULT',
    TIME_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (UUID)
)
/

-- UMA tables --
CREATE TABLE IDN_UMA_RESOURCE (
  ID INTEGER,
  RESOURCE_ID VARCHAR2(255),
  RESOURCE_NAME VARCHAR2(255),
  TIME_CREATED TIMESTAMP NOT NULL,
  RESOURCE_OWNER_NAME VARCHAR2(255),
  CLIENT_ID VARCHAR2(255),
  TENANT_ID INTEGER DEFAULT -1234,
  USER_DOMAIN VARCHAR2(50),
  PRIMARY KEY (ID)
)
/

CREATE SEQUENCE IDN_UMA_RESOURCE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
/

CREATE OR REPLACE TRIGGER IDN_UMA_RESOURCE_TRIG
BEFORE INSERT
ON IDN_UMA_RESOURCE
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
SELECT IDN_UMA_RESOURCE_SEQ.nextval INTO :NEW.ID FROM dual;
END;
/

CREATE INDEX IDX_RID ON IDN_UMA_RESOURCE (RESOURCE_ID)
/

CREATE INDEX IDX_USER ON IDN_UMA_RESOURCE (RESOURCE_OWNER_NAME, USER_DOMAIN)
/

CREATE TABLE IDN_UMA_RESOURCE_META_DATA (
  ID INTEGER,
  RESOURCE_IDENTITY INTEGER NOT NULL,
  PROPERTY_KEY VARCHAR2(40),
  PROPERTY_VALUE VARCHAR2(255),
  PRIMARY KEY (ID),
  FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
)
/

CREATE SEQUENCE IDN_UMA_RESOURCE_META_DATA_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
/

CREATE OR REPLACE TRIGGER IDN_UMA_RESOURCE_METADATA_TRIG
BEFORE INSERT
ON IDN_UMA_RESOURCE_META_DATA
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
SELECT IDN_UMA_RESOURCE_META_DATA_SEQ.nextval INTO :NEW.ID FROM dual;
END;
/

CREATE TABLE IDN_UMA_RESOURCE_SCOPE (
  ID INTEGER,
  RESOURCE_IDENTITY INTEGER NOT NULL,
  SCOPE_NAME VARCHAR2(255),
  PRIMARY KEY (ID),
  FOREIGN KEY (RESOURCE_IDENTITY) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
)
/

CREATE SEQUENCE IDN_UMA_RESOURCE_SCOPE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
/

CREATE OR REPLACE TRIGGER IDN_UMA_RESOURCE_SCOPE_TRIG
BEFORE INSERT
ON IDN_UMA_RESOURCE_SCOPE
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
SELECT IDN_UMA_RESOURCE_SCOPE_SEQ.nextval INTO :NEW.ID FROM dual;
END;
/

CREATE INDEX IDX_RS ON IDN_UMA_RESOURCE_SCOPE (SCOPE_NAME)
/

CREATE TABLE IDN_UMA_PERMISSION_TICKET (
  ID INTEGER,
  PT VARCHAR2(255) NOT NULL,
  TIME_CREATED TIMESTAMP NOT NULL,
  EXPIRY_TIME TIMESTAMP NOT NULL,
  TICKET_STATE VARCHAR2(25) DEFAULT 'ACTIVE',
  TENANT_ID INTEGER DEFAULT -1234,
  PRIMARY KEY (ID)
)
/

CREATE SEQUENCE IDN_UMA_PERMISSION_TICKET_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
/

CREATE OR REPLACE TRIGGER IDN_UMA_PERMISSION_TICKET_TRIG
BEFORE INSERT
ON IDN_UMA_PERMISSION_TICKET
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
SELECT IDN_UMA_PERMISSION_TICKET_SEQ.nextval INTO :NEW.ID FROM dual;
END;
/

CREATE INDEX IDX_PT ON IDN_UMA_PERMISSION_TICKET (PT)
/

CREATE TABLE IDN_UMA_PT_RESOURCE (
  ID INTEGER,
  PT_RESOURCE_ID INTEGER NOT NULL,
  PT_ID INTEGER NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (PT_ID) REFERENCES IDN_UMA_PERMISSION_TICKET (ID) ON DELETE CASCADE,
  FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_RESOURCE (ID) ON DELETE CASCADE
)
/

CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
/

CREATE OR REPLACE TRIGGER IDN_UMA_PT_RESOURCE_TRIG
BEFORE INSERT
ON IDN_UMA_PT_RESOURCE
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
SELECT IDN_UMA_PT_RESOURCE_SEQ.nextval INTO :NEW.ID FROM dual;
END;
/

CREATE TABLE IDN_UMA_PT_RESOURCE_SCOPE (
  ID INTEGER,
  PT_RESOURCE_ID INTEGER NOT NULL,
  PT_SCOPE_ID INTEGER NOT NULL,
  PRIMARY KEY (ID),
  FOREIGN KEY (PT_RESOURCE_ID) REFERENCES IDN_UMA_PT_RESOURCE (ID) ON DELETE CASCADE,
  FOREIGN KEY (PT_SCOPE_ID) REFERENCES IDN_UMA_RESOURCE_SCOPE (ID) ON DELETE CASCADE
)
/

CREATE SEQUENCE IDN_UMA_PT_RESOURCE_SCOPE_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
/

CREATE OR REPLACE TRIGGER IDN_UMA_PT_RESOURCE_SCOPE_TRIG
BEFORE INSERT
ON IDN_UMA_PT_RESOURCE_SCOPE
REFERENCING NEW AS NEW
FOR EACH ROW
BEGIN
SELECT IDN_UMA_PT_RESOURCE_SCOPE_SEQ.nextval INTO :NEW.ID FROM dual;
END;
/

ALTER TABLE AM_API ADD API_UUID VARCHAR(255) /


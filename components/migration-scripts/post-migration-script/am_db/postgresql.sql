ALTER TABLE IDN_OAUTH2_ACCESS_TOKEN_SCOPE ALTER COLUMN TOKEN_SCOPE TYPE VARCHAR (100);

ALTER TABLE AM_API_CATEGORIES DROP COLUMN TENANT_ID;

ALTER TABLE AM_API_CATEGORIES ADD UNIQUE(NAME,ORGANIZATION);

ALTER TABLE AM_APPLICATION ADD UNIQUE(NAME,SUBSCRIBER_ID,ORGANIZATION);

ALTER TABLE AM_API ADD UNIQUE(API_PROVIDER,API_NAME,API_VERSION,ORGANIZATION);

ALTER TABLE AM_KEY_MANAGER ADD UNIQUE(NAME,ORGANIZATION);

ALTER TABLE AM_GATEWAY_ENVIRONMENT ADD UNIQUE(NAME,ORGANIZATION);

ALTER TABLE AM_GW_API_DEPLOYMENTS DROP CONSTRAINT am_gw_api_deployments_api_id_fkey;
ALTER TABLE AM_GW_API_DEPLOYMENTS ADD CONSTRAINT am_gw_api_deployments_api_id_fkey FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE AM_GW_API_ARTIFACTS DROP CONSTRAINT am_gw_api_artifacts_api_id_fkey;
ALTER TABLE AM_GW_API_ARTIFACTS ADD CONSTRAINT am_gw_api_artifacts_api_id_fkey FOREIGN KEY (API_ID) REFERENCES AM_GW_PUBLISHED_API_DETAILS(API_ID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE AM_API_RATINGS DROP CONSTRAINT am_api_ratings_api_id_fkey;
ALTER TABLE AM_API_RATINGS ADD CONSTRAINT am_api_ratings_api_id_fkey FOREIGN KEY(API_ID) REFERENCES AM_API(API_ID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE AM_API_COMMENTS DROP CONSTRAINT am_api_comments_api_id_fkey;
ALTER TABLE AM_API_COMMENTS ADD CONSTRAINT am_api_comments_api_id_fkey FOREIGN KEY(API_ID) REFERENCES AM_API(API_ID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE AM_API_LC_EVENT DROP CONSTRAINT am_api_lc_event_api_id_fkey;
ALTER TABLE AM_API_LC_EVENT ADD CONSTRAINT am_api_lc_event_api_id_fkey FOREIGN KEY(API_ID) REFERENCES AM_API(API_ID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE AM_SUBSCRIPTION DROP CONSTRAINT am_subscription_api_id_fkey;
ALTER TABLE AM_SUBSCRIPTION ADD CONSTRAINT am_subscription_api_id_fkey FOREIGN KEY(API_ID) REFERENCES AM_API(API_ID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE AM_SECURITY_AUDIT_UUID_MAPPING DROP CONSTRAINT am_security_audit_uuid_mapping_api_id_fkey;
ALTER TABLE AM_SECURITY_AUDIT_UUID_MAPPING ADD CONSTRAINT am_security_audit_uuid_mapping_api_id_fkey FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON UPDATE CASCADE ON DELETE CASCADE;

/*need*/
ALTER TABLE AM_APPLICATION_REGISTRATION DROP CONSTRAINT am_application_registration_app_id_fkey ;
ALTER TABLE AM_APPLICATION_REGISTRATION ADD CONSTRAINT am_application_registration_app_id_fkey FOREIGN KEY (APP_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE AM_APPLICATION_KEY_MAPPING DROP CONSTRAINT am_application_key_mapping_application_id_fkey ;
ALTER TABLE AM_APPLICATION_KEY_MAPPING ADD CONSTRAINT am_application_key_mapping_application_id_fkey FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE AM_SUBSCRIPTION DROP CONSTRAINT am_subscription_application_id_fkey ;
ALTER TABLE AM_SUBSCRIPTION ADD CONSTRAINT am_subscription_application_id_fkey FOREIGN KEY (APPLICATION_ID) REFERENCES AM_APPLICATION(APPLICATION_ID) ON UPDATE CASCADE ON DELETE CASCADE;

create index IDX_AAI_ORG on AM_API (ORGANIZATION);

-- you may encounter issues while adding foreign keys for AM_API_REVISION_METADATA,AM_REVISION due to data inconsistencies
ALTER TABLE AM_API_REVISION_METADATA ADD FOREIGN KEY(REVISION_UUID) REFERENCES AM_REVISION(REVISION_UUID) ON DELETE CASCADE;
ALTER TABLE AM_REVISION ADD FOREIGN KEY (API_UUID) REFERENCES AM_API(API_UUID) ON DELETE CASCADE; 

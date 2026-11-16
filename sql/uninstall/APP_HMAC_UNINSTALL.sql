set define off
whenever sqlerror continue
begin dbms_scheduler.drop_job('APP_HMAC_DISABLE_KEYS_JOB',force=>true); exception when others then null; end;
/
drop package app_hmac_admin;
drop package app_hmac;
drop table app_hmac_admin_log purge;
drop table app_hmac_actions purge;
drop table app_hmac_keys purge;

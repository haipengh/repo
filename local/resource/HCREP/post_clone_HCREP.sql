alter session set current_schema=sysadm;
 
UPDATE PSOPTIONS 
SET GUID = ' '
/
 
delete from psuseremail 
--where oprid not in ('PS')
/
 
update psoprdefn
set emailid = ' '
--where oprid not in ('PS')
/
 
update PS_ROLEXLATOPR
set emailid = ' '
--where oprid not in ('PS')
/
 
UPDATE PS_EMAIL_ADDRESSES E
SET E.PREF_EMAIL_FLAG = 'N',
where email_addr    = ' '
/
 
update psprcsrqst
set DBNAME = 'HCREP'
where DBNAME = 'HCPRD'
/
 
update PSPRCSPARMS
set PARMLIST = REPLACE(PARMLIST, 'HCPRD', 'HCREP'), 
    ORIGPARMLIST = REPLACE(ORIGPARMLIST, 'HCPRD', 'HCREP')
/
 
update psprcsrqst
set rundttm = rundttm + 2
where runstatus = '5'
/
 
update psprcsque
set rundttm = rundttm + 2
where runstatus = '5'
/
 
UPDATE PSPRCSRQST
SET RUNSTATUS = 4
WHERE RUNSTATUS IN (5)
/
 
UPDATE PSPRCSQUE
SET RUNSTATUS = 4
WHERE RUNSTATUS IN (5)
/
 

update psprcsruncntls a
set a.servername = 'PSUNX1'
where a.servername = 'PSUNX2'
/
 
 
delete from PS_SERVERDEFN a
where a.servername = 'PSUNX2'
/
 
set define !
update ps_cdm_dist_node 
set url = 'https://hrisrep.ds.acc.co.nz:8443/psreports/HCREP',
opsys = '4',
uri_host = 'hrisrep.ds.acc.co.nz',uri_port = '8080',
uri_resource = 'SchedulerTransfer/HCREP',
uri_scheme = 'http',
uri_rpt='https://' || 'hrisrep.ds.acc.co.nz:8443/psc/ps/EMPLOYEE/HRMS/c/CDM_RPT.CDM_RPT.GBL?Page=CDM_RPT_INDEX&Action=U&CDM_ID=',
cdm_dir_template = '%DBNAME%/%CURRDATE%/%REPORTID%'
where distnodename = 'hrisrpt'
/
set define &
 
update psurldefn 
set url =  'ftps://hrisftp:Pds23Awwe@hrisrep.ds.acc.co.nz/PAYSLIPS/'
where url_id = 'GP_SS_PSLP_FTP'
/
 
-- Integration Broker

DELETE FROM PSAPMSGDSPSTAT WHERE MACHINENAME <> 'hrisrep' OR (APPSERVER_PATH <> '/opt/oracle/pt849/appserv/HCREP' AND MACHINENAME= 'hrisrep')
/

DELETE FROM PSAPMSGDOMSTAT WHERE MACHINENAME <> 'hrisrep' OR (APPSERVER_PATH <> '/opt/oracle/pt849/appserv/HCREP' AND MACHINENAME= 'hrisrep')
/

DELETE FROM PSAPMSGQUEUESET WHERE MACHINENAME <> 'hrisrep' OR (APPSERVER_PATH <> '/opt/oracle/pt849/appserv/HCREP' AND MACHINENAME= 'hrisrep')
/


UPDATE PSAPMSGDOMSTAT SET DOMAIN_STATUS= 'A' WHERE MACHINENAME= 'hrisrep' AND APPSERVER_PATH= '/opt/oracle/pt849/appserv/HCREP'
/

UPDATE PSIBDSPSTATVW SET DSPSTATUS='0',STATUSSTRING='ACT' WHERE MACHINENAME='hrisrep' AND DISPATCHERNAME='PSBRKDSP_dflt' AND APPSERVER_PATH='/opt/oracle/pt849/appserv/HCREP'
/

UPDATE PSIBDSPSTATVW SET DSPSTATUS='0',STATUSSTRING='ACT' WHERE MACHINENAME='hrisrep' AND DISPATCHERNAME='PSPUBDSP_dflt' AND APPSERVER_PATH='/opt/oracle/pt849/appserv/HCREP'
/

UPDATE PSIBDSPSTATVW SET DSPSTATUS='0',STATUSSTRING='ACT' WHERE MACHINENAME='hrisrep' AND DISPATCHERNAME='PSSUBDSP_dflt' AND APPSERVER_PATH='/opt/oracle/pt849/appserv/HCREP'
/

--  core tables:
DELETE FROM PSAPMSGPUBHDR;
DELETE FROM PSAPMSGPUBDATA;
DELETE FROM PSAPMSGPUBCON;
DELETE FROM PSAPMSGSUBCON;
DELETE FROM PSAPMSGPUBERR;
DELETE FROM PSAPMSGPUBERRP;
DELETE FROM PSAPMSGPUBCERR;
DELETE FROM PSAPMSGPUBCERRP;
DELETE FROM PSAPMSGSUBCERR;
DELETE FROM PSAPMSGSUBCERRP;
DELETE FROM PSAPMSGPCONDATA;
DELETE FROM PSAPMSGSCONDATA;
DELETE FROM PSIBERR;
DELETE FROM PSIBERRP;
 
-- synchronous core tables:
DELETE FROM PSIBLOGHDR;
DELETE FROM PSIBLOGDATA;
DELETE FROM PSIBLOGERR;
DELETE FROM PSIBLOGERRP;
DELETE FROM PSIBLOGIBINFO;
 
--  archive tables:
DELETE FROM PSAPMSGARCHPH;
DELETE FROM PSAPMSGARCHPD;
DELETE FROM PSAPMSGARCHPC;
DELETE FROM PSAPMSGARCHSC;
DELETE FROM PSAPMSGARCHPT;
DELETE FROM PSAPMSGARCHST;
DELETE FROM PSIBLOGHDRARCH;
DELETE FROM PSIBLOGDATAARCH;
DELETE FROM PSIBLOGIBINFOAR;
 
update psgateway
set connurl = 'https://hrisrep.ds.acc.co.nz:8443/PSIGW/PeopleSoftListeningConnector';
 
commit;


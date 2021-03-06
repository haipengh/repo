-- $Header: /u999/cvsadmin/cms_rep/repository/local_acc/resource/NFREFM/create_db_NFREFM.sql,v 1.1 2011/02/27 22:43:04 hongh Exp $
-- ----------------------------------------------------------------------------------------------
-- Script  : create_db.sql
-- Purpose : 
-- Changes :
--           Seq Name          Date       Description
--           --- ------------- ---------- -------------------------------------------------------
--           000               2009/11/24 Initial creation for 11gR1
--           001               2011/02/01 update for core ver 14
-- ----------------------------------------------------------------------------------------------

set echo on

define _ORACLE_UNQNAME='&1'
define _REDO_BASE_1='&2'
define _REDO_BASE_2='&3'
define _DBF_BASE='&4'
define _TMPF_BASE='&5'

CREATE DATABASE &_ORACLE_UNQNAME.
   -- general section
	USER SYS IDENTIFIED BY SYS_&_ORACLE_UNQNAME.
	USER SYSTEM IDENTIFIED BY SYSTEM_&_ORACLE_UNQNAME.
	CONTROLFILE REUSE
	MAXINSTANCES 32
	MAXDATAFILES 2048
	CHARACTER SET AL32UTF8	
   -- database logging section
	MAXLOGHISTORY 9999
	MAXLOGFILES 192
	MAXLOGMEMBERS 4 
	ARCHIVELOG 
	FORCE LOGGING
	LOGFILE 
		GROUP 1 ('&_REDO_BASE_1./redo1_1.log', '&_REDO_BASE_2./redo1_2.log') SIZE 50M REUSE, 
		GROUP 2 ('&_REDO_BASE_1./redo2_1.log', '&_REDO_BASE_2./redo2_2.log') SIZE 50M REUSE, 
		GROUP 3 ('&_REDO_BASE_1./redo3_1.log', '&_REDO_BASE_2./redo3_2.log') SIZE 50M REUSE,
		GROUP 4 ('&_REDO_BASE_1./redo4_1.log', '&_REDO_BASE_2./redo4_2.log') SIZE 50M REUSE
   -- tablespace section
	EXTENT MANAGEMENT LOCAL 
	DATAFILE '&_DBF_BASE./system01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 10240K MAXSIZE UNLIMITED
	SYSAUX DATAFILE '&_DBF_BASE./sysaux01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M 
   -- default tablespace
	DEFAULT TABLESPACE USERS 
	DATAFILE '&_DBF_BASE./users01.dbf' SIZE 100M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M	--EXTENT MANAGEMENT LOCAL AUTOALLOCATE
	SEGMENT SPACE MANAGEMENT AUTO
   -- temp tablespace
	SMALLFILE DEFAULT TEMPORARY TABLESPACE TEMP 
	TEMPFILE '&_TMPF_BASE./temp01.dbf' SIZE 500M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M
	EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M	--EXTENT MANAGEMENT LOCAL AUTOALLOCATE
   -- undo tablespace
	SMALLFILE UNDO TABLESPACE "UNDOTBS1" 
	DATAFILE '&_DBF_BASE./undotbs1_01.dbf' SIZE 200M REUSE AUTOEXTEND ON NEXT 100M MAXSIZE 8000M 
/

exit

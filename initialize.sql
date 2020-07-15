-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 15, 2020 at 03:06 AM
-- Server version: 5.7.30-0ubuntu0.18.04.1
-- PHP Version: 7.2.31-1+ubuntu18.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `up-pgh`
--
CREATE DATABASE IF NOT EXISTS `up-pgh` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `up-pgh`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `sp_addMonitor`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_addMonitor` (IN `monitorname` VARCHAR(250), IN `monitordesc` VARCHAR(1000), IN `wardid` INT, IN `maxslot` INT)  BEGIN
insert into r_monitor_details VALUES(null, monitorname,maxslot, monitordesc, 0,wardid,CURRENT_TIMESTAMP);
select last_insert_id() monitorid;
END$$

DROP PROCEDURE IF EXISTS `sp_addpatient`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_addpatient` (IN `fname` VARCHAR(250), IN `mname` VARCHAR(250), IN `lname` VARCHAR(250), IN `birthday` VARCHAR(50), IN `gender` VARCHAR(10), IN `age` INT, IN `covid19` VARCHAR(1000), IN `remarks` VARCHAR(5000), IN `address` VARCHAR(1000), IN `city` VARCHAR(100), IN `country` VARCHAR(100), IN `contact` VARCHAR(100), IN `email` VARCHAR(100), IN `sss` VARCHAR(100), IN `philhealth` VARCHAR(100), IN `hmo` VARCHAR(100), IN `admission` VARCHAR(100), IN `ward` INT, IN `contactname` VARCHAR(100), IN `contactnumber` VARCHAR(100), IN `rel` VARCHAR(100), IN `civil` VARCHAR(100), IN `pat_clas` VARCHAR(100), IN `bed_no` INT)  BEGIN
insert into r_patient_info VALUES (null, fname, mname,lname,gender,birthday, CURRENT_TIMESTAMP,age,covid19,remarks,address,city,country,contact,email,sss,philhealth,hmo,admission,ward,contactname,contactnumber,rel,1, civil, pat_clas, bed_no);
select last_insert_id() patient_id ;
end$$

DROP PROCEDURE IF EXISTS `sp_addpatienthistory`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_addpatienthistory` (IN `patientid` INT, IN `respiration` DOUBLE, IN `oxygen` DOUBLE, IN `sys` INT, IN `dias` INT, IN `heartrate` INT)  BEGIN
insert into t_patient_data_history VALUES(null, patientid, respiration, oxygen, sys, dias, heartrate, CURRENT_TIMESTAMP);
select last_insert_id() data_history, "success" result ;
end$$

DROP PROCEDURE IF EXISTS `sp_addPatienttoMonitor`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_addPatienttoMonitor` (IN `patientid` INT, IN `monitorid` INT)  begin

Declare patientslot int;

select count(tml_listid) into  patientslot from t_monitor_list where tml_patientid = patientid and tml_monitorid = monitorid;

if patientslot > 0 THEN
delete from t_monitor_list where tml_patientid = patientid and tml_monitorid = monitorid;

insert into t_monitor_list VALUES (null, patientid, monitorid,0, CURRENT_TIMESTAMP);
end if;

if patientslot <=0 then 
insert into t_monitor_list VALUES (null, patientid, monitorid,0, CURRENT_TIMESTAMP);
end if;

select "sucess" result;
END$$

DROP PROCEDURE IF EXISTS `sp_addpatient_observation`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_addpatient_observation` (IN `id` VARCHAR(250), IN `obscode` VARCHAR(250), IN `obsvalue` VARCHAR(250), IN `subject` VARCHAR(250), IN `effectivity` VARCHAR(250), IN `obsstatus` VARCHAR(250), IN `dataerror` VARCHAR(250), IN `obssystem` VARCHAR(250), IN `valuesystem` VARCHAR(250), IN `valuecode` VARCHAR(250), IN `valueunit` VARCHAR(250))  BEGIN
insert into t_patient_observation values(null,
id,obscode , obsvalue, subject, effectivity, obsstatus, dataerror, obssystem,valuesystem,valuecode,valueunit
);

select "success", last_insert_id() id;
END$$

DROP PROCEDURE IF EXISTS `sp_addWard`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_addWard` (IN `wardname` VARCHAR(250), IN `warddesc` VARCHAR(1000))  BEGIN
insert into r_ward_details VALUES (null, wardname, warddesc, 0, CURRENT_TIMESTAMP);
select last_insert_id() wardid;
end$$

DROP PROCEDURE IF EXISTS `sp_add_patient_config`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_add_patient_config` (IN `patientid` INT, IN `rpc_ecg_st_msec` DOUBLE, IN `rpc_heartrate_upper_bpm` DOUBLE, IN `rpc_heartrate_lower_bpm` DOUBLE, IN `rpc_pulserate_upper_bpm` DOUBLE, IN `rpc_pulserate_lower_bpm` DOUBLE, IN `rpc_oxygen_upper_saturation` DOUBLE, IN `rpc_oxygen_lower_saturation` DOUBLE, IN `rpc_respiratory_upper_rpm` DOUBLE, IN `rpc_respiratory_lower_rpm` DOUBLE, IN `rpc_bp_systolic_upper` DOUBLE, IN `rpc_bp_systolic_lower` DOUBLE, IN `rpc_bp_diastolic_upper` DOUBLE, IN `rpc_bp_diastolic_lower` DOUBLE, IN `rpc_bp_time_frame` DOUBLE, IN `rpc_temperature_upper` DOUBLE, IN `rpc_temperature_lower` DOUBLE)  begin 
insert into r_patient_config VALUES(null, patientid, rpc_ecg_st_msec, rpc_heartrate_upper_bpm, rpc_heartrate_lower_bpm, rpc_pulserate_upper_bpm, rpc_pulserate_lower_bpm, rpc_oxygen_upper_saturation, rpc_oxygen_lower_saturation, rpc_respiratory_upper_rpm, rpc_respiratory_lower_rpm, rpc_bp_systolic_upper, rpc_bp_systolic_lower, rpc_bp_diastolic_upper, rpc_bp_diastolic_lower, rpc_bp_time_frame, rpc_temperature_lower, rpc_temperature_upper, CURRENT_TIMESTAMP);
select last_insert_id() configid;
END$$

DROP PROCEDURE IF EXISTS `sp_createstatuscode`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_createstatuscode` (IN `name` VARCHAR(50), IN `descr` VARCHAR(150), IN `category` VARCHAR(100))  BEGIN
insert into r_patient_status() values(null,name, descr, category,1);
select last_insert_id() statusid;
END$$

DROP PROCEDURE IF EXISTS `sp_deleteMonitor`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_deleteMonitor` (IN `monitorid` INT)  begin
 update r_monitor_details set rmd_isRemoved =1 where rmd_monitorid = monitorid;
 update t_monitor_list set tml_isRemoved = 1 where tml_monitorid = monitorid;
select "deleted" result;
end$$

DROP PROCEDURE IF EXISTS `sp_deletepatient`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_deletepatient` (IN `patientid` INT)  BEGIN
update r_patient_info set rpi_patientstatus = 0  where r_patient_info.rpi_patientid = patientid;
select "deleted" deletepatient_report;
end$$

DROP PROCEDURE IF EXISTS `sp_deletestatuscode`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_deletestatuscode` (IN `codeid` INT)  BEGIN
update r_patient_status set rps_isActive =0 where rps_id = codeid;
select 'deleted' result;
END$$

DROP PROCEDURE IF EXISTS `sp_filterstatuscode`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_filterstatuscode` (IN `category` VARCHAR(100))  BEGIN
select rps_id, rps_name, rps_desc, rps_category from r_patient_status where rps_category like concat('%',category,'%') and rps_isActive =1 ;
END$$

DROP PROCEDURE IF EXISTS `sp_getECGObs`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_getECGObs` ()  BEGIN
select * from t_patient_ecg inner join (select max(tpe_ecgkey) as ecgkey , tpe_subject as subject from t_patient_ecg GROUP by subject) jt on jt.ecgkey = tpe_ecgkey;
END$$

DROP PROCEDURE IF EXISTS `sp_getMonitorList`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_getMonitorList` ()  BEGIN
select rmd_monitorid id, rmd_monitorname description , rmd_monitorname as name, concat('[',(select GROUP_CONCAT(tml_patientid) from t_monitor_list where tml_monitorid = rmd_monitorid and tml_isRemoved = 0),']') as patientIds, rmd_maxslot patientSlot from r_monitor_details where rmd_isRemoved != 1;
end$$

DROP PROCEDURE IF EXISTS `sp_getmonitorpatientlist`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_getmonitorpatientlist` (IN `monitorid` INT)  begin
    select rmd_monitorid id, rmd_monitorname description , rmd_monitorname as name, concat('[',(select GROUP_CONCAT(tml_patientid)
        from t_monitor_list
        where tml_monitorid = rmd_monitorid and tml_isRemoved = 0),']') as patientIds, rmd_maxslot patientSlot
    from r_monitor_details
    where rmd_isRemoved != 1 and rmd_monitorid = monitorid;
END$$

DROP PROCEDURE IF EXISTS `sp_getPatientDetails`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_getPatientDetails` (IN `patientid` INT)  BEGIN
select  rpi_patientid, rpi_patientfname, rpi_patientmname, rpi_patientlname, rpi_gender,
rpi_dateregistered, rpi_age, rpi_covid19, rpi_remarks, rpi_address, rpi_city, rpi_country, rpi_contact, rpi_email_add, rpi_sss_gsis_number, rpi_philhealth_number, rpi_hmo, rpi_date_admitted, rpi_ward_id, rpi_contact_name, rpi_contact_number, rpi_contact_relationship, rpi_patientstatus, DATE_FORMAT(str_to_date(rpi_birthday, '%m/%d/%Y' ), "%Y-%m-%d") rpi_birthday from r_patient_info where r_patient_info.rpi_patientid = patientid;
END$$

DROP PROCEDURE IF EXISTS `sp_getpatientlist`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_getpatientlist` ()  BEGIN
select rpi_patientid,rpi_patientfname, rpi_patientmname, rpi_patientlname, rpi_gender, rpi_birthday, rpi_dateregistered, 
rpi_age, rpi_covid19, rpi_remarks, rpi_address, rpi_city, rpi_country,rpi_contact, rpi_email_add, rpi_sss_gsis_number, rpi_philhealth_number, rpi_hmo, rpi_date_admitted, "stable" rpi_patient_status, rpi_civilstatus, rpi_classification, rpi_bednumber  from r_patient_info where rpi_patientstatus = 1;
end$$

DROP PROCEDURE IF EXISTS `sp_getPatientObservationRange`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_getPatientObservationRange` (IN `obscode` VARCHAR(50), IN `spec_date` VARCHAR(50), IN `patientid` VARCHAR(250))  BEGIN
select avg(tpo_value) avg_value, tpo_obsid, date_format( tpo_effectivity, '%H' ) hour_clustered from t_patient_observation where date_format( tpo_effectivity, '%Y-%m-%d' ) = date_format( spec_date, '%Y-%m-%d' ) and tpo_subject = patientid and tpo_code = obscode group by hour_clustered ;
end$$

DROP PROCEDURE IF EXISTS `sp_getPatientObservations`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_getPatientObservations` ()  BEGIN
select `tpo_effectivity`, tpo_subject, tpo_obsid, tpo_id, tpo_code, tpo_value, tpo_status, tpo_dataerror, tpo_system, tpo_valuesystem, tpo_valuecode, tpo_unit from t_patient_observation t inner join (select max(tpo_effectivity) as max_effectivity, tpo_code as code, tpo_subject as subject from t_patient_observation group by `tpo_code`, `tpo_subject`)g on g.max_effectivity = t.tpo_effectivity and g.subject = t.tpo_subject and g.code = t.tpo_code;
end$$

DROP PROCEDURE IF EXISTS `sp_getpatienttimeframe`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_getpatienttimeframe` (IN `patientid` INT)  BEGIN
select rpc_time_frame from r_patient_config where rpc_patientid = patientid order by rpc_configid desc limit 1;
end$$

DROP PROCEDURE IF EXISTS `sp_getstatuscode`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_getstatuscode` ()  BEGIN
select rps_id, rps_name, rps_desc, rps_category from r_patient_status where rps_isActive = 1;
END$$

DROP PROCEDURE IF EXISTS `sp_getWards`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_getWards` ()  BEGIN
select *,rmd_monitorid, rmd_monitorname, rmd_monitordesc, concat(rpi_patientfname,' ',rpi_patientmname,' ',rpi_patientlname) rpi_patientfullname  from r_monitor_details inner join t_monitor_list on t_monitor_list.tml_monitorid = rmd_monitorid inner join r_patient_info on r_patient_info.rpi_patientid = t_monitor_list.tml_patientid where t_monitor_list.tml_listid in (select max(t_monitor_list.tml_listid) from t_monitor_list GROUP by t_monitor_list.tml_patientid);
end$$

DROP PROCEDURE IF EXISTS `sp_get_patient_config`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_get_patient_config` (IN `patientid` INT)  BEGIN
select * from r_patient_config where rpc_patientid = patientid order by rpc_configid desc limit 1;
end$$

DROP PROCEDURE IF EXISTS `sp_insertECG`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_insertECG` (IN `id` INT, IN `ecg_status` VARCHAR(250), IN `ecg_system` VARCHAR(250), IN `subject` VARCHAR(250), IN `effectivity` DATETIME, IN `originvalue` VARCHAR(250), IN `period` INT, IN `factor` DOUBLE, IN `dimension` INT, IN `ecg_data` VARCHAR(20000))  BEGIN
insert into t_patient_ecg values (null, id, ecg_status,ecg_system, subject, effectivity, originvalue, period, factor, dimension, ecg_data);
END$$

DROP PROCEDURE IF EXISTS `sp_removepatientMonitor`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_removepatientMonitor` (IN `patientid` INT, IN `monitorid` INT)  BEGIN
update t_monitor_list set tml_isRemoved = 1 where tml_monitorid = monitorid and t_monitor_list.tml_patientid = patientid;
select "removed" result;
end$$

DROP PROCEDURE IF EXISTS `sp_RemoveWard`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_RemoveWard` (IN `wardid` INT)  BEGIN
update r_ward_details set rwd_isRemoved = 1 where rwd_wardid = wardid;
select "removed" result;
end$$

DROP PROCEDURE IF EXISTS `sp_UpdateMonitor`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_UpdateMonitor` (IN `monitorid` INT, IN `monitorname` VARCHAR(250), IN `monitordesc` VARCHAR(1000), IN `wardid` INT, IN `maxslot` INT)  BEGIN
update r_monitor_details set rmd_monitorname = monitorname, rmd_maxslot = maxslot, rmd_monitordesc = monitordesc, rmd_wardid = wardid where rmd_monitorid = monitorid
;
select "updated" result;
end$$

DROP PROCEDURE IF EXISTS `sp_updatepatient`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_updatepatient` (IN `fname` VARCHAR(250), IN `mname` VARCHAR(250), IN `lname` VARCHAR(250), IN `birthday` VARCHAR(50), IN `gender` VARCHAR(10), IN `age` INT, IN `covid19` VARCHAR(10000), IN `remarks` VARCHAR(5000), IN `address` VARCHAR(1000), IN `city` VARCHAR(100), IN `country` VARCHAR(100), IN `contact` VARCHAR(100), IN `email` VARCHAR(100), IN `sss` VARCHAR(100), IN `philhealth` VARCHAR(100), IN `hmo` VARCHAR(100), IN `admission` VARCHAR(100), IN `ward` INT, IN `contactname` VARCHAR(100), IN `contactnumber` VARCHAR(100), IN `rel` VARCHAR(100), IN `patientid` INT, IN `civil` VARCHAR(100), IN `pat_clas` VARCHAR(100), IN `bedno` INT)  BEGIN
update r_patient_info set  rpi_patientfname = fname, rpi_patientmname= mname, rpi_patientlname=lname, rpi_gender = gender, rpi_birthday = birthday, rpi_dateregistered = CURRENT_TIMESTAMP,rpi_age=age,rpi_covid19 = covid19, rpi_remarks = remarks,rpi_address = address,rpi_city = city,rpi_country = country,rpi_contact =contact, rpi_email_add = email,rpi_sss_gsis_number = sss,rpi_philhealth_number = philhealth,rpi_hmo=hmo,rpi_date_admitted = admission,rpi_ward_id = ward,rpi_contact_name = contactname,rpi_contact_number = contactnumber,rpi_contact_relationship = rel,rpi_civilstatus= civil, rpi_classification = pat_clas, rpi_bednumber = bedno where r_patient_info.rpi_patientid = patientid;
select "success" update_result;
end$$

DROP PROCEDURE IF EXISTS `sp_updateWard`$$
CREATE DEFINER=`ward`@`localhost` PROCEDURE `sp_updateWard` (IN `wardid` INT, IN `wardname` VARCHAR(250), IN `warddesc` VARCHAR(1000))  BEGIN
update r_ward_details set rwd_wardname = wardname, rwd_warddesc =  warddesc where rwd_wardid = wardid;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `r_monitor_details`
--

DROP TABLE IF EXISTS `r_monitor_details`;
CREATE TABLE `r_monitor_details` (
  `rmd_monitorid` int(11) NOT NULL,
  `rmd_monitorname` varchar(250) NOT NULL,
  `rmd_maxslot` int(11) NOT NULL,
  `rmd_monitordesc` varchar(1000) DEFAULT NULL,
  `rmd_isRemoved` int(11) DEFAULT NULL,
  `rmd_wardid` int(11) NOT NULL,
  `rmd_dateadded` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `r_observation_type`
--

DROP TABLE IF EXISTS `r_observation_type`;
CREATE TABLE `r_observation_type` (
  `rot_typeid` int(11) NOT NULL,
  `rot_typename` varchar(250) NOT NULL,
  `rot_description` varchar(5000) DEFAULT NULL,
  `rot_codenumber` varchar(50) NOT NULL,
  `rot_codevalue` varchar(20) NOT NULL,
  `rot_valuesystem` varchar(250) DEFAULT NULL,
  `rot_codesystem` varchar(250) DEFAULT NULL,
  `rot_dateadded` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `r_observation_type`
--

INSERT INTO `r_observation_type` (`rot_typeid`, `rot_typename`, `rot_description`, `rot_codenumber`, `rot_codevalue`, `rot_valuesystem`, `rot_codesystem`, `rot_dateadded`) VALUES
(1, 'SPO2', 'This observation contains the patient\'s SPO2 reading measured using a pulse oximeter on the finger', '59407-7', '%', 'unitsofmeasure.org', 'loinc.org', '2020-04-08 01:35:25'),
(2, 'Respiration Rate', 'This observation contains the patient\'s respiration rate measured using ecg impedance', '76270-8', '{Breaths}/min', 'unitsofmeasure.org', 'loinc.org', '2020-04-08 01:35:25'),
(3, 'Temperature', 'This observation contains the patient\'s body temperature', '8310-5', '/min', 'unitsofmeasure.org', 'loinc.org', '2020-04-08 01:35:25'),
(4, 'Heart Rate', 'This observation contains the patient\'s heart rate measured using a pulse oximeter', '73799-9', '/min', 'unitsofmeasure.org', 'loinc.org', '2020-04-08 01:35:25'),
(5, 'Systolic Pressure', 'This component contains the patient\'s systolic pressure non-invasively measured using oscillometry', '8480-6', 'mm[Hg]', 'unitsofmeasure.org', 'loinc.org', '2020-04-11 16:29:30'),
(6, 'Diastolic Pressure', 'This component contains the patient\'s diastolic pressure non-invasively measured using oscillometry', '8462-4', 'mm[Hg]', 'unitsofmeasure.org', 'loinc.org', '2020-04-11 16:29:30'),
(7, '', 'This component contains the method by which the BP was measured. The type of the value is a CodeableConcept', '', '8357-6', 'unitsofmeasure.org', 'loinc.org', '2020-04-11 16:29:30');

-- --------------------------------------------------------

--
-- Table structure for table `r_patient_config`
--

DROP TABLE IF EXISTS `r_patient_config`;
CREATE TABLE `r_patient_config` (
  `rpc_configid` int(11) NOT NULL,
  `rpc_patientid` int(11) NOT NULL,
  `rpc_ecg_st_msec` double DEFAULT NULL,
  `rpc_heartrate_upper_bpm` double DEFAULT NULL,
  `rpc_heartrate_lower_bpm` double DEFAULT NULL,
  `rpc_pulserate_upper_bpm` double DEFAULT NULL,
  `rpc_pulserate_lower_bpm` double DEFAULT NULL,
  `rpc_oxygen_upper_saturation` double DEFAULT NULL,
  `rpc_oxygen_lower_saturation` double DEFAULT NULL,
  `rpc_respiratory_upper_rpm` double DEFAULT NULL,
  `rpc_respiratory_lower_rpm` double DEFAULT NULL,
  `rpc_bp_systolic_upper` double DEFAULT NULL,
  `rpc_bp_systolic_lower` double DEFAULT NULL,
  `rpc_bp_diastolic_upper` double DEFAULT NULL,
  `rpc_bp_diastolic_lower` double DEFAULT NULL,
  `rpc_time_frame` int(11) DEFAULT NULL,
  `rpc_temperature_upper` double NOT NULL,
  `rpc_temperature_lower` double DEFAULT NULL,
  `rpc_dateadded` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `r_patient_info`
--

DROP TABLE IF EXISTS `r_patient_info`;
CREATE TABLE `r_patient_info` (
  `rpi_patientid` int(11) NOT NULL,
  `rpi_patientfname` varchar(250) NOT NULL,
  `rpi_patientmname` varchar(250) DEFAULT NULL,
  `rpi_patientlname` varchar(250) NOT NULL,
  `rpi_gender` varchar(50) NOT NULL DEFAULT 'unknown',
  `rpi_birthday` varchar(50) DEFAULT NULL,
  `rpi_dateregistered` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rpi_age` int(11) NOT NULL,
  `rpi_covid19` varchar(10000) NOT NULL,
  `rpi_remarks` varchar(5000) NOT NULL,
  `rpi_address` varchar(1000) NOT NULL,
  `rpi_city` varchar(100) NOT NULL,
  `rpi_country` varchar(100) NOT NULL,
  `rpi_contact` varchar(100) NOT NULL,
  `rpi_email_add` varchar(100) NOT NULL,
  `rpi_sss_gsis_number` varchar(100) NOT NULL,
  `rpi_philhealth_number` varchar(100) NOT NULL,
  `rpi_hmo` varchar(100) NOT NULL,
  `rpi_date_admitted` varchar(100) NOT NULL,
  `rpi_ward_id` int(11) NOT NULL,
  `rpi_contact_name` varchar(100) NOT NULL,
  `rpi_contact_number` varchar(100) NOT NULL,
  `rpi_contact_relationship` varchar(100) NOT NULL,
  `rpi_patientstatus` int(11) NOT NULL DEFAULT '1',
  `rpi_civilstatus` varchar(100) NOT NULL,
  `rpi_classification` varchar(100) NOT NULL,
  `rpi_bednumber` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `r_patient_status`
--

DROP TABLE IF EXISTS `r_patient_status`;
CREATE TABLE `r_patient_status` (
  `rps_id` int(11) NOT NULL,
  `rps_name` varchar(50) NOT NULL,
  `rps_desc` varchar(150) DEFAULT NULL,
  `rps_category` varchar(100) NOT NULL,
  `rps_isActive` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `r_patient_status`
--

INSERT INTO `r_patient_status` (`rps_id`, `rps_name`, `rps_desc`, `rps_category`, `rps_isActive`) VALUES
(1, 'covid-18', 'covid nung 2018 pre', 'covid-18', 0),
(2, 'covid-18', 'covid nung 2018 pre', 'covid-18', 0),
(3, 'Confirmed', 'covid nung 2018 pre', 'PATIENT CLASSIFICATION', 0),
(4, 'Confirmed', '', 'PATIENT CLASSIFICATION', 1),
(5, 'Probable', '', 'PATIENT CLASSIFICATION', 1),
(6, 'Suspected', '', 'PATIENT CLASSIFICATION', 1),
(7, 'Stable or No Co-morbid', '', 'PATIENT COVID CASE', 1),
(8, 'Stable or Unstable Co-morbid', '', 'PATIENT COVID CASE', 1),
(9, 'CAP-HR, Sepsis or Shock', '', 'PATIENT COVID CASE', 1),
(10, 'ARDS', '', 'PATIENT COVID CASE', 1);

-- --------------------------------------------------------

--
-- Table structure for table `r_ward_details`
--

DROP TABLE IF EXISTS `r_ward_details`;
CREATE TABLE `r_ward_details` (
  `rwd_wardid` int(11) NOT NULL,
  `rwd_wardname` varchar(250) NOT NULL,
  `rwd_warddesc` varchar(250) NOT NULL,
  `rwd_isRemoved` int(11) NOT NULL DEFAULT '0',
  `rwd_dateadded` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `r_ward_details`
--

INSERT INTO `r_ward_details` (`rwd_wardid`, `rwd_wardname`, `rwd_warddesc`, `rwd_isRemoved`, `rwd_dateadded`) VALUES
(1, 'Ward Name', 'Ward Desc', 0, '2020-04-29 19:59:45');

-- --------------------------------------------------------

--
-- Table structure for table `t_monitor_list`
--

DROP TABLE IF EXISTS `t_monitor_list`;
CREATE TABLE `t_monitor_list` (
  `tml_listid` int(11) NOT NULL,
  `tml_patientid` int(11) NOT NULL,
  `tml_monitorid` int(11) DEFAULT NULL,
  `tml_isRemoved` int(11) DEFAULT NULL,
  `tml_dateadded` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `t_patient_data_history`
--

DROP TABLE IF EXISTS `t_patient_data_history`;
CREATE TABLE `t_patient_data_history` (
  `tpdh_historyid` int(11) NOT NULL,
  `tpdh_patientid` int(11) NOT NULL,
  `tpdh_respiration_rate` double NOT NULL,
  `tpdh_oxygen_level` double NOT NULL,
  `tpdh_bprate_sys` int(11) NOT NULL,
  `tpdh_bprate_dias` int(11) NOT NULL,
  `tpdh_heart_rate` int(11) NOT NULL,
  `tpdh_dt_registered` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `t_patient_ecg`
--

DROP TABLE IF EXISTS `t_patient_ecg`;
CREATE TABLE `t_patient_ecg` (
  `tpe_ecgkey` int(11) NOT NULL,
  `tpe_id` int(11) NOT NULL,
  `tpe_status` varchar(250) DEFAULT 'final',
  `tpe_valuesystem` varchar(250) NOT NULL,
  `tpe_subject` varchar(250) NOT NULL,
  `tpe_effectivity` datetime NOT NULL,
  `tpe_originvalue` int(11) NOT NULL,
  `tpe_period` int(11) NOT NULL,
  `tpe_factor` double NOT NULL,
  `tpe_dimension` int(11) NOT NULL,
  `tpe_data` varchar(20000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `t_patient_observation`
--

DROP TABLE IF EXISTS `t_patient_observation`;
CREATE TABLE `t_patient_observation` (
  `tpo_obsid` int(11) NOT NULL,
  `tpo_id` varchar(1000) NOT NULL,
  `tpo_code` varchar(50) NOT NULL,
  `tpo_value` varchar(250) NOT NULL,
  `tpo_subject` varchar(250) NOT NULL,
  `tpo_effectivity` datetime NOT NULL,
  `tpo_status` varchar(250) NOT NULL,
  `tpo_dataerror` varchar(250) DEFAULT NULL,
  `tpo_system` varchar(500) DEFAULT NULL,
  `tpo_valuesystem` varchar(250) NOT NULL,
  `tpo_valuecode` varchar(50) NOT NULL,
  `tpo_unit` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `r_monitor_details`
--
ALTER TABLE `r_monitor_details`
  ADD PRIMARY KEY (`rmd_monitorid`),
  ADD KEY `rmd_wardid_fk` (`rmd_wardid`);

--
-- Indexes for table `r_observation_type`
--
ALTER TABLE `r_observation_type`
  ADD PRIMARY KEY (`rot_typeid`),
  ADD UNIQUE KEY `rot_codenumber` (`rot_codenumber`);

--
-- Indexes for table `r_patient_config`
--
ALTER TABLE `r_patient_config`
  ADD PRIMARY KEY (`rpc_configid`),
  ADD KEY `rpc_patientid` (`rpc_patientid`);

--
-- Indexes for table `r_patient_info`
--
ALTER TABLE `r_patient_info`
  ADD PRIMARY KEY (`rpi_patientid`);

--
-- Indexes for table `r_patient_status`
--
ALTER TABLE `r_patient_status`
  ADD PRIMARY KEY (`rps_id`);

--
-- Indexes for table `r_ward_details`
--
ALTER TABLE `r_ward_details`
  ADD PRIMARY KEY (`rwd_wardid`);

--
-- Indexes for table `t_monitor_list`
--
ALTER TABLE `t_monitor_list`
  ADD PRIMARY KEY (`tml_listid`),
  ADD KEY `tml_patientid_fk` (`tml_patientid`),
  ADD KEY `tml_monitorid` (`tml_monitorid`);

--
-- Indexes for table `t_patient_data_history`
--
ALTER TABLE `t_patient_data_history`
  ADD PRIMARY KEY (`tpdh_historyid`),
  ADD KEY `tpdh_patientid` (`tpdh_patientid`);

--
-- Indexes for table `t_patient_ecg`
--
ALTER TABLE `t_patient_ecg`
  ADD PRIMARY KEY (`tpe_ecgkey`),
  ADD KEY `tpe_subject` (`tpe_subject`);

--
-- Indexes for table `t_patient_observation`
--
ALTER TABLE `t_patient_observation`
  ADD PRIMARY KEY (`tpo_obsid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `r_monitor_details`
--
ALTER TABLE `r_monitor_details`
  MODIFY `rmd_monitorid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `r_observation_type`
--
ALTER TABLE `r_observation_type`
  MODIFY `rot_typeid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `r_patient_config`
--
ALTER TABLE `r_patient_config`
  MODIFY `rpc_configid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `r_patient_info`
--
ALTER TABLE `r_patient_info`
  MODIFY `rpi_patientid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;
--
-- AUTO_INCREMENT for table `r_patient_status`
--
ALTER TABLE `r_patient_status`
  MODIFY `rps_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT for table `r_ward_details`
--
ALTER TABLE `r_ward_details`
  MODIFY `rwd_wardid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `t_monitor_list`
--
ALTER TABLE `t_monitor_list`
  MODIFY `tml_listid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT for table `t_patient_data_history`
--
ALTER TABLE `t_patient_data_history`
  MODIFY `tpdh_historyid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `t_patient_ecg`
--
ALTER TABLE `t_patient_ecg`
  MODIFY `tpe_ecgkey` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `t_patient_observation`
--
ALTER TABLE `t_patient_observation`
  MODIFY `tpo_obsid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=670575;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `r_monitor_details`
--
ALTER TABLE `r_monitor_details`
  ADD CONSTRAINT `rmd_wardid_fk` FOREIGN KEY (`rmd_wardid`) REFERENCES `r_ward_details` (`rwd_wardid`);

--
-- Constraints for table `r_patient_config`
--
ALTER TABLE `r_patient_config`
  ADD CONSTRAINT `r_patient_config_ibfk_1` FOREIGN KEY (`rpc_patientid`) REFERENCES `r_patient_info` (`rpi_patientid`);

--
-- Constraints for table `t_monitor_list`
--
ALTER TABLE `t_monitor_list`
  ADD CONSTRAINT `tml_monitorid` FOREIGN KEY (`tml_monitorid`) REFERENCES `r_monitor_details` (`rmd_monitorid`),
  ADD CONSTRAINT `tml_patientid_fk` FOREIGN KEY (`tml_patientid`) REFERENCES `r_patient_info` (`rpi_patientid`);

--
-- Constraints for table `t_patient_data_history`
--
ALTER TABLE `t_patient_data_history`
  ADD CONSTRAINT `t_patient_data_history_ibfk_1` FOREIGN KEY (`tpdh_patientid`) REFERENCES `r_patient_info` (`rpi_patientid`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

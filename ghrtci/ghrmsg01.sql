USE DBSctlg
GO
-- SELECT * FROM DBSCOMMON.[dbo].[message_master] WHERE msg_id = 'U00000'
INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00000' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('< NEW HIRE SECTION (1) >  '	As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO		


INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00001' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Total Global HR New Hire: @1 ' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]		
GO


INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00002' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('< ENCOUNTERED THE FOLLOWING ERRORS: >  ' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO			

--Total nbr of employees that already exists
INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00003' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Total nbr of employees that already exist: @1 '			As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO


INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00005' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Employer (@1) does not exist for employee: @2 - defaulting 99999' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00006' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('This employee, @1,NIS nbr already exists - defaulting 99999. NIS nbr is: @2' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00007' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('NIS nbr was blank for employee, @1 - defaulting 99999' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00008' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Unit name (@1) was missing for employee, @2 - defaulting 999999' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00009' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('< BEGINNING OF ERROR MESSAGES: >' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00010' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('<ENDING OF ERROR MESSAGES: >' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00011' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST(' ' As [varchar](255))									AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00012' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Employee, @1, does not exists ' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00013' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('< NAME CHANGE SECTION (4) > ' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00014' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('< SALARY CHANGE SECTION (2) > ' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00015' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Total Global HR Salary Changes: @1' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00016' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Total Global HR Name Changes: @1' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00017' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('< EMPLOYEE TRANSFER SECTION (3) >' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO


INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00018' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Total Global HR Employee Transfer: @1' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00019' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Total Global HR Status Changes: @1' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00020' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Pay Group, @1, does not exists for employee, @2 - defaulting 99999' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00021' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Pay Element Control Group, @1 does not exists for employee,@2 -defaulting 99999' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00022' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('The current status is @1. Cannot rehire an employee, @2, without a current terminated status' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00023' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('< STATUS CHANGE SECTION (5) >' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00024' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Cannot Inactivate an employee, @1, if the current status is not active' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00025' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Cannot Reactivate an employee, @1, if the current status is not inactive' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00026' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('The current status is @1. To Reactivate an employee, @2, the current status must be inactive' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00027' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('The new effective date, @1 , for employee, @2, must be greater than the current effective date' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00028' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('< PAY ELEMENT SECTION (6) >' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00029' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Total Global HR Pay Elements Read: @1' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO


INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00030' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('The Begin Date, @1, cannot be greater than the pay through date for employee @2' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00031' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Pay Element Group was blank for employee, @1 - defaulting 99999' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00032' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('The rehire date must be greater than the termination date - By passing the employee: @1' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO


INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00033' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('The Reactivation date must be greater than the inactivation date - By passing the employee: @1' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

GO


INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00034' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Cannot transfer an employee to the same employer. New Employer is @1 - By passing this employee: @2' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00035' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Salary cannot be blank for salary change record. Employee ID: @1' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00036' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Transfer date must be greater than default position effective date. Employee ID: @1' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00037' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('New Status Effective date must be greater than current effective date. Employee ID: @1' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00038' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Existing payments have not been updated into the accumulator for this employee: @1' As [varchar](255))	AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00039' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Employer does not exists: @1 - bypassing record'			As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO


INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00040' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Pay Element Ctrl Grp cannot be blank for employee: @1 - defaulting 99999'			As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO


INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00041' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Salary cannot be zeroed for a Salary Change for employee: @1'			As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00042' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Cannot terminate an employee, @1, if the current status is not active or inactive.'			As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00043' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Rehire date must be greater than current employee employment effective date for employee: @1'			As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00044' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Cannot transfer an employee, @1, to a pensioner employer'			As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00045' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Terminated employee, @1, cannot be transferred'			As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00046' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('NIS nbr is blank - defaulting 99999 for employee @1'					As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00047' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('The stop date must be the same or later than the employee pay element effective date for employee @1' As [varchar](255)) AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00048' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('After April 1, 2023,Pay Group, @1, must be semi-monthly.' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))									AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO


INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00049' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('The pay element id, @2, was not invalid.' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))								AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO


INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00050' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Empoloyer id, @2, does not match the current employer id.' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))								    AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00051' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('This pay element, @2, has never been assigned to this employee' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))								    AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00052' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Bank id, @2, does not exists.' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))								    AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00053' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('The interface eff date, @2  must be equal or greater current eff date' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))								    AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00054' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Must setup direct deposit (DD1) after: New Hire, Rehire, or Transfer to New Legal Entity' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))								    AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO
INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00055' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('To rehire, the current employee status must be terminated' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))								    AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO
INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00056' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Pay Element or Aggregate missing becuase the effective date is greater than transfer date.' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))								    AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO
INSERT INTO DBSCOMMON.[dbo].[message_master]
SELECT	CAST('U00057' AS CHAR(10))									AS msg_id,
		CAST('1' AS tinyint)										AS [severity_cd],
		CAST('0' AS bit)											AS [user_def],
		CAST('Tax Employer does not exists - defaulting 99999' As [varchar](255))		AS [msg_text],
		CAST(' ' As [varchar](255))								    AS [msg_text_2],
		CAST(' ' As [varchar](255))									AS [msg_text_3],		
		CAST('0' AS [int])											AS [help_context],
		CAST('0' AS [int])											AS [help_file_id],
		CAST('0' AS [int])											AS [pscm_flag],
		CAST('0' AS [int])											AS [CHGSTAMP]
GO

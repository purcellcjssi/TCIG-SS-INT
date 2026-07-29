USE [DBSentp];
GO


DELETE FROM dbo.batch_parameters
WHERE (batch_parameter_key = 'GHR_EMPLOYEE_EVENTS');
GO


INSERT [dbo].[batch_parameters]
(
  [batch_parameter_key]
, [batch_parameter_1]
, [batch_parameter_2]
, [batch_parameter_3]
, [batch_parameter_4]
, [batch_parameter_5]
, [batch_parameter_6]
, [batch_parameter_7]
, [batch_parameter_8]
, [batch_parameter_9]
, [batch_parameter_10]
, [batch_parameter_11]
, [batch_parameter_12]
, [chgstamp]
)
VALUES
(
  N'GHR_EMPLOYEE_EVENTS'
, N''
, N'TAB'
, N'C:\FTP_DATA\DATA\DEV\Load\Interface_SS_VENUS.txt'
, N'hrpn'
, N'ghr_employee_events'
, N'51'
, N'DBS'
, N'usp_cleanup_tbl'
, N''
, N'C:\FTP_DATA\DATA\DEV\Load\Loaded'
, N''
, N'M'
, 2
);
GO

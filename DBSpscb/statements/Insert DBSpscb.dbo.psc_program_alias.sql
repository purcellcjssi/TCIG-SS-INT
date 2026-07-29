USE [DBSpscb];
GO

DELETE FROM dbo.psc_program_alias
WHERE (psc_program_alias IN ('AUDITBNK'
                            , 'AUDITRPT'
                            , 'DOWNLOAD'
                            , 'EVENT'
                            , 'EVENT2'
                            , 'INTEBANK'
                            , 'INTERFACE'
                            , 'REPORT'
                            , 'SAVEXTV'
                            , 'SENDAUDIT'
                            , 'SENDFILE'
                            , 'SSFORT'
                            , 'SSVENUS'
                            , 'UPDBANK'
                            , 'UPLOAD'
							));
GO

INSERT [dbo].[psc_program_alias] ([psc_key], [psc_pgm_name], [psc_window_id], [psc_pgm_op_sys], [psc_dbs_prog_sw], [psc_owner], [psc_access], [chgstamp])
VALUES
  (N'AUDITBNK'	, N'C:\FTP_DATA\EXEDEV\Batch\AUDITBANK.BAT'				, N'', N'', 0, N'DBS'		, N'PUBLIC', 2)
, (N'AUDITRPT'	, N'C:\FTP_DATA\EXEDEV\Batch\AUDITRPT.BAT'				, N'', N'', 0, N'DBS'		, N'PUBLIC', 11)
, (N'DOWNLOAD'	, N'C:\FTP_DATA\EXEDEV\CSHCMInterface\Interface.bat'	, N'', N'', 0, N'DBS'		, N'PUBLIC', 1)
, (N'EVENT'		, N'C:\FTP_DATA\EXEDEV\Batch\EVENT.bat'					, N'', N'', 0, N'JGROSS'	, N'PUBLIC', 1)
, (N'EVENT2'	, N'C:\FTP_DATA\EXEDEV\Batch\EVENT2.bat'				, N'', N'', 0, N'JGROSS'	, N'PUBLIC', 1)
, (N'INTEBANK'	, N'C:\FTP_DATA\EXEDEV\Batch\INTEBANK.BAT'				, N'', N'', 0, N'DBS'		, N'PUBLIC', 2)
, (N'INTERFACE'	, N'C:\FTP_DATA\EXEDEV\Batch\INTERFACE.BAT'				, N'', N'', 0, N'DBS'		, N'PUBLIC', 4)
, (N'REPORT'	, N'C:\FTP_DATA\EXEDEV\Batch\SendReport.bat'			, N'', N'', 0, N'DBS'		, N'PUBLIC', 1)
, (N'SAVEXTV'	, N'C:\FTP_DATA\EXEDEV\Batch\SAVE_EXTRACTV.bat'			, N'', N'', 0, N'DBS'		, N'PUBLIC', 2)
, (N'SENDAUDIT'	, N'C:\FTP_DATA\EXEDEV\Batch\SendAudit.bat'				, N'', N'', 0, N'DBS'		, N'PUBLIC', 1)
, (N'SENDFILE'	, N'C:\FTP_DATA\EXEDEV\Batch\SENDFILE.bat'				, N'', N'', 0, N'JGROSS'	, N'PUBLIC', 1)
, (N'SSFORT'	, N'C:\FTP_DATA\EXEDEV\Batch\SSFORT.BAT'				, N'', N'', 0, N'DBS'		, N'PUBLIC', 2)
, (N'SSVENUS'	, N'C:\FTP_DATA\EXEDEV\Batch\SSVENUS.BAT'				, N'', N'', 0, N'DBS'		, N'PUBLIC', 2)
, (N'UPDBANK'	, N'C:\FTP_DATA\EXEDEV\BATCH\UPDBANK.bat'				, N'', N'', 0, N'DBS'		, N'PUBLIC', 2)
, (N'UPLOAD'	, N'C:\FTP_DATA\EXEDEV\BATCH\UPLOAD_GOSL.bat'			, N'', N'', 0, N'JGROSS'	, N'PUBLIC', 5);
GO
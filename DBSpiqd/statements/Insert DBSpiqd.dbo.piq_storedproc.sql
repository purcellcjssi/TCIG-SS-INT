USE [DBSpiqd];
GO


DELETE FROM dbo.piq_storedproc
WHERE (piq_userid ='DBS')
  AND (piq_request_name IN ('TAX_ACCUM',
'USP_BANKINFO_EVENTS',
'USP_BANK_CURRENT_DATA',
'USP_BANK_VERIFICATION_RPT',
'USP_CURRENT_DATA',
'USP_CURR_PE_DATA',
'USP_SEL_EMPLOYEE_EVENTS',
'USP_SRV_TO_SRV_COPY',
'USP_VAL_GHR_INT_BULKCOPY',
'USP_VERIFICATION_RPT',
'USP_VERIFICATION_RPT_CSV'));
GO


INSERT [dbo].[piq_storedproc] ([piq_userid], [piq_request_name], [piq_server_name], [piq_db_name], [piq_proc_name], [piq_row_limit], [piq_answer_name], [piq_proc_parms], [piq_delimit_format], [chgstamp])
VALUES
 (N'DBS', N'TAX_ACCUM', N@@SERVERNAME, N'DBShrpy', N'usp_sel_pay_element', 0, N'', N'2020', N'C', 1)
,(N'DBS', N'USP_BANKINFO_EVENTS', @@SERVERNAME, N'DBShrpn', N'usp_bankinfo_events', 0, N'', N'', N'C', 0)
,(N'DBS', N'USP_BANK_CURRENT_DATA', @@SERVERNAME, N'DBShrpn', N'usp_bank_current_data', 0, N'C:\FTP_DATA\DATA\DEV\SS_BANK_CURRENT_DATA', N'', N'T', 2)
,(N'DBS', N'USP_BANK_VERIFICATION_RPT', @@SERVERNAME, N'DBShrpn', N'usp_bank_verification_rpt', 0, N'C:\sstrm80\Maildir\HCMBANK', N'', N'T', 4)
,(N'DBS', N'USP_CURRENT_DATA', @@SERVERNAME, N'DBShrpn', N'usp_current_data', 0, N'C:\FTP_DATA\DATA\DEV\SS_CURR_DATA', N'', N'T', 6)
,(N'DBS', N'USP_CURR_PE_DATA', @@SERVERNAME, N'DBShrpn', N'usp_curr_pe_data', 0, N'C:\FTP_DATA\DATA\DEV\SS_CURR_PE_DATA', N'', N'T', 5)
,(N'DBS', N'USP_SEL_EMPLOYEE_EVENTS', @@SERVERNAME, N'DBShrpn', N'usp_sel_employee_events', 0, N'', N'', N'C', 2)
,(N'DBS', N'USP_SRV_TO_SRV_COPY', @@SERVERNAME, N'DBSpscb', N'usp_srv_to_srv_copy', 0, N'', N'', N'C', 1)
,(N'DBS', N'USP_VAL_GHR_INT_BULKCOPY', @@SERVERNAME, N'DBShrpn', N'usp_ghr_int_validate_bulkcopy', 0, N'', N'', N'C', 0)
,(N'DBS', N'USP_VERIFICATION_RPT', N@@SERVERNAME, N'DBShrpn', N'usp_verification_rpt', 0, N'C:\sstrm80\Maildir\HCMRPT', N'', N'T', 5)
,(N'DBS', N'USP_VERIFICATION_RPT_CSV', @@SERVERNAME, N'DBShrpn', N'usp_verification_rpt_csv', 0, N'C:\Reports\vhcmrpt_venus', N'', N'C', 0);
GO
USE DBSpscb;
GO


DELETE FROM dbo.psc_step
WHERE (psc_userid ='DBS')
  AND (psc_batchname ='GHR');
GO


INSERT [dbo].[psc_step] ([psc_userid], [psc_batchname], [psc_qualifier], [psc_stepname], [psc_step_number], [psc_prev_step], [psc_next_step], [psc_ignore_step_sw], [psc_dbs_prog_sw], [psc_unique_id], [psc_class], [psc_priority], [psc_condx_test], [psc_condx_test_code], [psc_condx_next_step], [psc_last_updt_date], [psc_last_comp_date], [psc_last_comp_rc], [psc_pgm_name], [psc_pgm_parms], [chgstamp])
VALUES
  (N'DBS', N'GHR', N'BANK INTERFACE', N'AUDIT', 5, N'S03', N'REPORT', 0, 1, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2024-04-24 14:41:54.343' AS DateTime), CAST(N'2024-04-26 11:42:23.093' AS DateTime), 0, N'Start A Job', N'DBS GHR EXTRACT_BANK_DATA', 8)
, (N'DBS', N'GHR', N'BANK INTERFACE', N'HCM', 1, N'', N'S00', 1, 0, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2024-04-26 11:42:03.690' AS DateTime), CAST(N'2024-04-26 11:28:40.387' AS DateTime), 0, N'INTEBANK', N'', 7)
, (N'DBS', N'GHR', N'BANK INTERFACE', N'REPORT', 6, N'AUDIT', N'', 0, 1, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2024-06-10 14:02:34.133' AS DateTime), CAST(N'2024-04-26 11:42:33.157' AS DateTime), 0, N'Connect Stored Procedure', N'USP_BANK_VERIFICATION_RPT', 26)
, (N'DBS', N'GHR', N'BANK INTERFACE', N'S00', 2, N'HCM', N'S01', 1, 0, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2024-04-26 11:42:03.690' AS DateTime), CAST(N'2024-04-26 11:29:00.467' AS DateTime), 0, N'UPDBANK', N'', 17)
, (N'DBS', N'GHR', N'BANK INTERFACE', N'S01', 3, N'S00', N'S03', 1, 1, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2024-06-10 14:02:34.117' AS DateTime), CAST(N'2024-04-26 11:29:10.510' AS DateTime), 0, N'Bulk Copy', N'GHR_BANKINFO_EVENTS', 12)
, (N'DBS', N'GHR', N'BANK INTERFACE', N'S03', 4, N'S01', N'AUDIT', 1, 1, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2024-06-10 14:02:34.133' AS DateTime), CAST(N'2024-04-26 11:29:20.560' AS DateTime), 0, N'Connect Stored Procedure', N'USP_BANKINFO_EVENTS', 19)
, (N'DBS', N'GHR', N'EVENT', N'EVENT', 1, N'', N'', 0, 0, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2023-06-26 21:20:14.010' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime), 0, N'EVENT', N'', 1)
, (N'DBS', N'GHR', N'EVENT2', N'EVENT', 1, N'', N'', 0, 0, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2023-06-26 21:20:44.820' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime), 0, N'EVENT2', N'', 2)
, (N'DBS', N'GHR', N'EXTRACT_BANK_DATA', N'AUDIT', 2, N'EXTRACT', N'', 0, 0, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2024-04-24 14:54:48.097' AS DateTime), CAST(N'2024-04-26 11:42:53.250' AS DateTime), 0, N'AUDITBNK', N'', 17)
, (N'DBS', N'GHR', N'EXTRACT_BANK_DATA', N'EXTRACT', 1, N'', N'AUDIT', 0, 1, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2024-06-10 14:02:52.867' AS DateTime), CAST(N'2024-04-26 11:42:33.140' AS DateTime), 0, N'Connect Stored Procedure', N'USP_BANK_CURRENT_DATA', 12)
, (N'DBS', N'GHR', N'EXTRACT_DATA', N'AUDIT', 4, N'SAVEXTV', N'SENDAUDT', 0, 0, 0, N'WIN10CLS', 50, N'2', 0, N'STOP', CAST(N'2025-10-03 10:04:13.850' AS DateTime), CAST(N'2026-06-25 05:32:44.520' AS DateTime), 0, N'AUDITRPT', N'', 769)
, (N'DBS', N'GHR', N'EXTRACT_DATA', N'EXTRACT', 2, N'SSVENUS', N'SAVEXTV', 0, 1, 0, N'WIN10CLS', 50, N'2', 0, N'STOP', CAST(N'2025-10-20 11:50:17.237' AS DateTime), CAST(N'2026-06-25 05:30:44.090' AS DateTime), 0, N'Connect Stored Procedure', N'USP_CURRENT_DATA', 766)
, (N'DBS', N'GHR', N'EXTRACT_DATA', N'SAVEXTV', 3, N'EXTRACT', N'AUDIT', 0, 0, 0, N'WIN10CLS', 50, N'2', 0, N'STOP', CAST(N'2025-10-20 11:50:17.240' AS DateTime), CAST(N'2026-06-25 05:31:04.200' AS DateTime), 0, N'SAVEXTV', N'', 365)
, (N'DBS', N'GHR', N'EXTRACT_DATA', N'SENDAUDT', 5, N'AUDIT', N'STOP', 0, 0, 0, N'SMTPCLS', 50, N'', 0, N'', CAST(N'2025-10-15 13:59:47.690' AS DateTime), CAST(N'2026-06-25 05:33:04.617' AS DateTime), 0, N'SENDAUDIT', N'', 430)
, (N'DBS', N'GHR', N'EXTRACT_DATA', N'SSVENUS', 1, N'', N'EXTRACT', 0, 0, 0, N'WIN10CLS', 50, N'2', 0, N'STOP', CAST(N'2025-10-20 11:50:17.237' AS DateTime), CAST(N'2026-06-25 05:30:23.990' AS DateTime), 0, N'SSVENUS', N'', 398)
, (N'DBS', N'GHR', N'EXTRACT_DATA', N'STOP', 6, N'SENDAUDT', N'', 0, 1, 0, N'WIN10CLS', 50, N'', 0, N'', CAST(N'2025-09-12 11:53:38.647' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime), 0, N'STOP', N'', 4)
, (N'DBS', N'GHR', N'EXTRACT_PE_DATA', N'EXTRACT', 1, N'', N'', 0, 1, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2024-06-10 14:03:12.197' AS DateTime), CAST(N'2021-10-02 11:15:04.493' AS DateTime), 0, N'Connect Stored Procedure', N'USP_CURR_PE_DATA', 24)
, (N'DBS', N'GHR', N'INTERFACES', N'END', 8, N'SNDRPT', N'', 0, 1, 0, N'WIN10CLS', 50, N'', 0, N'', CAST(N'2026-03-22 03:35:36.127' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime), 0, N'STOP', N'', 0)
, (N'DBS', N'GHR', N'INTERFACES', N'HCM', 1, N'', N'S00', 1, 0, 0, N'WIN10CLS', 50, N'2', 0, N'S02', CAST(N'2026-06-22 16:33:22.587' AS DateTime), CAST(N'2026-06-19 15:06:16.390' AS DateTime), 0, N'INTERFACE', N'', 387)
, (N'DBS', N'GHR', N'INTERFACES', N'REPORT', 6, N'S03', N'SNDRPT', 0, 1, 0, N'SMTPCLS', 50, N'2', 0, N'END', CAST(N'2026-05-08 15:53:07.257' AS DateTime), CAST(N'2026-06-23 17:11:20.340' AS DateTime), 0, N'Connect Stored Procedure', N'USP_VERIFICATION_RPT_CSV', 367)
, (N'DBS', N'GHR', N'INTERFACES', N'S00', 2, N'HCM', N'S01', 1, 0, 0, N'WIN10CLS', 50, N'2', 0, N'S02', CAST(N'2026-06-22 16:33:22.590' AS DateTime), CAST(N'2026-06-19 15:06:36.487' AS DateTime), 0, N'UPLOAD', N'', 486)
, (N'DBS', N'GHR', N'INTERFACES', N'S01', 3, N'S00', N'S02', 0, 1, 0, N'WIN10CLS', 50, N'2', 0, N'S02', CAST(N'2026-05-08 15:56:31.607' AS DateTime), CAST(N'2026-06-23 17:10:50.147' AS DateTime), 0, N'Bulk Copy', N'GHR_EMPLOYEE_EVENTS', 551)
, (N'DBS', N'GHR', N'INTERFACES', N'S02', 4, N'S01', N'S03', 0, 1, 0, N'WIN10CLS', 50, N'2', 0, N'REPORT', CAST(N'2026-05-08 15:56:31.610' AS DateTime), CAST(N'2026-06-23 17:11:00.207' AS DateTime), 0, N'Connect Stored Procedure', N'USP_VAL_GHR_INT_BULKCOPY', 104)
, (N'DBS', N'GHR', N'INTERFACES', N'S03', 5, N'S02', N'REPORT', 0, 1, 0, N'WIN10CLS', 50, N'2', 0, N'REPORT', CAST(N'2026-05-08 15:58:05.167' AS DateTime), CAST(N'2026-06-23 17:11:10.260' AS DateTime), 0, N'Connect Stored Procedure', N'USP_SEL_EMPLOYEE_EVENTS', 467)
, (N'DBS', N'GHR', N'INTERFACES', N'SNDRPT', 7, N'REPORT', N'END', 0, 0, 0, N'SMTPCLS', 50, N'2', 0, N'END', CAST(N'2026-03-22 03:35:36.127' AS DateTime), CAST(N'2026-06-23 17:11:40.450' AS DateTime), 0, N'REPORT', N'', 108)
, (N'DBS', N'GHR', N'PAYSLIP_INTERFACE', N'DEDUC', 4, N'EARN', N'EARNDUD', 0, 1, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2023-06-26 21:22:18.667' AS DateTime), CAST(N'2022-01-21 11:47:31.367' AS DateTime), 0, N'Connect Stored Procedure', N'PAY_CHECK_DEDUCTION', 41)
, (N'DBS', N'GHR', N'PAYSLIP_INTERFACE', N'EARN', 3, N'NETPAY', N'DEDUC', 0, 1, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2023-06-26 21:22:18.667' AS DateTime), CAST(N'2022-01-21 11:47:21.307' AS DateTime), 0, N'Connect Stored Procedure', N'PAY_CHECK_EARNING', 41)
, (N'DBS', N'GHR', N'PAYSLIP_INTERFACE', N'EARNDUD', 5, N'DEDUC', N'SENDFILE', 0, 1, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2023-06-26 21:22:18.667' AS DateTime), CAST(N'2022-01-21 11:47:41.413' AS DateTime), 0, N'Connect Stored Procedure', N'PAY_CHECK_EARNDEDUCT', 37)
, (N'DBS', N'GHR', N'PAYSLIP_INTERFACE', N'EXT', 1, N'', N'NETPAY', 0, 1, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2023-06-26 21:22:18.667' AS DateTime), CAST(N'2022-01-21 11:47:01.210' AS DateTime), 0, N'Connect Stored Procedure', N'EXTRACT_PAY_SLIP', 37)
, (N'DBS', N'GHR', N'PAYSLIP_INTERFACE', N'NETPAY', 2, N'EXT', N'EARN', 0, 1, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2023-06-26 21:22:18.667' AS DateTime), CAST(N'2022-01-21 11:47:11.253' AS DateTime), 0, N'Connect Stored Procedure', N'PAY_CHECK_NET_PAY', 41)
, (N'DBS', N'GHR', N'PAYSLIP_INTERFACE', N'SENDFILE', 6, N'EARNDUD', N'', 0, 0, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2023-06-26 21:22:18.667' AS DateTime), CAST(N'2022-01-21 11:48:11.503' AS DateTime), 0, N'SENDFILE', N'', 35)
, (N'DBS', N'GHR', N'RUN_EVENT', N'RUN', 1, N'', N'', 0, 1, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2023-06-26 21:22:30.730' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime), 0, N'Connect Stored Procedure', N'RUN_EVENT', 2)
, (N'DBS', N'GHR', N'SRV_TO_SRV_COPY', N'FTP', 1, N'', N'', 0, 1, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2024-06-10 14:04:13.523' AS DateTime), CAST(N'1900-01-01 00:00:00.000' AS DateTime), 0, N'Connect Stored Procedure', N'USP_SRV_TO_SRV_COPY', 2)
, (N'DBS', N'GHR', N'VERIFCATION_0000', N'VER01', 1, N'', N'', 0, 1, 0, N'WINCLASS', 50, N'', 0, N'', CAST(N'2024-06-10 14:04:21.807' AS DateTime), CAST(N'2022-01-19 11:03:23.060' AS DateTime), 0, N'Connect Stored Procedure', N'USP_VERIFICATION_RPT', 114);
GO
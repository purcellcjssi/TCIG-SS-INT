SELECT [piq_userid] 							+ '+*' AS  piq_userid
      ,[piq_request_name] 						+ '+*' AS  piq_request_name
      ,[piq_server_name] 						+ '+*' AS  piq_server_name
      ,[piq_db_name] 							+ '+*' AS  piq_db_name
      ,[piq_proc_name] 							+ '+*' AS  piq_proc_name
      ,CAST([piq_row_limit] AS CHAR(3))			+ '+*' AS  piq_row_limit
	  ,CASE WHEN [piq_answer_name] = '' THEN ' ' ELSE [piq_answer_name] END	+ '+*' AS piq_answer_name
	  ,CASE WHEN [piq_proc_parms]  = '' THEN ' ' ELSE [piq_proc_parms] END	+ '+*' AS piq_proc_parms
      ,[piq_delimit_format] 					+ '+*' AS  piq_delimit_format
      ,CAST([chgstamp] AS CHAR(3))				+ '+!' AS  chgstamp

  INTO [DBSosxp].[dbo].[piq_storedproc]
  FROM [DBSpiqd].[dbo].[piq_storedproc] WHERE [piq_request_name] like 'USP_%'
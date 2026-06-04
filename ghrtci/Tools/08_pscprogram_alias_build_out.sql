SELECT [psc_key]							+ '+*' AS psc_key
      ,[psc_pgm_name]						+ '+*' AS psc_pgm_name
      ,CASE WHEN [psc_window_id]  = '' THEN ' ' ELSE [psc_window_id]  END	+ '+*' AS psc_window_id
	  ,CASE WHEN [psc_pgm_op_sys] = '' THEN ' ' ELSE [psc_pgm_op_sys] END	+ '+*' AS psc_pgm_op_sys
      ,CAST([psc_dbs_prog_sw] AS CHAR)		+ '+*' AS psc_dbs_prog_sw
      ,[psc_owner]							+ '+*' AS psc_owner
      ,[psc_access]							+ '+*' AS psc_access
      ,CAST([chgstamp] AS CHAR(5))			+ '+!' AS chgstamp

  INTO [DBSosxp].[dbo].[psc_program_alias]
  FROM [DBSpscb].[dbo].[psc_program_alias] WHERE [psc_pgm_name] like 'C:\FTP_DATA\%'
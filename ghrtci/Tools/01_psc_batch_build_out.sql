-- This query creates the table for WJAMIT installation
SELECT [psc_userid]					+ '+*' AS psc_userid
      ,[psc_batchname]				+ '+*' AS psc_batchname
      ,[psc_qualifier]				+ '+*' AS psc_qualifier
      ,[psc_batchtype]				+ '+*' AS psc_batchtype
      ,[psc_description]			+ '+*' AS psc_description
      ,[psc_security_profile]		+ '+*' AS psc_security_profile
      ,CASE WHEN [psc_interval_spec] = '' THEN ' ' ELSE [psc_interval_spec] END	+ '+*' AS psc_interval_spec
      ,CONVERT(char,[psc_nxt_run_date],121) 		+ '+*' AS psc_nxt_run_date
	  ,CONVERT(char,[psc_last_run_date],121)	    + '+*' AS psc_last_run_date
	  ,CONVERT(char,[psc_last_updt_date],121) 		+ '+*' AS psc_last_updt_date
      ,CONVERT(char,[psc_last_comp_date],121) 		+ '+*' AS psc_last_comp_date
      ,CAST([psc_last_comp_rc] AS CHAR)			    + '+*' AS psc_last_comp_rc
      ,CAST([psc_last_low_rc]  AS CHAR)		        + '+*' AS psc_last_low_rc
      ,[psc_lang_code]				+ '+*' AS psc_lang_code
      ,[psc_lang_code_dialect]		+ '+*' AS psc_lang_code_dialect
      ,[psc_status]					+ '+*' AS psc_status
      ,[psc_first_step]				+ '+*' AS psc_first_step
      ,[psc_last_step]				+ '+*' AS psc_last_step
      ,[psc_distribution_id]		+ '+*' AS psc_distribution_id
      ,[psc_dist_status]			+ '+*' AS psc_dist_status
      ,[psc_dist_condx_test]		+ '+*' AS psc_dist_condx_test
      ,CAST([psc_dist_condx_code]	AS CHAR) + '+*' AS psc_dist_condx_code
      ,[psc_run_now]				+ '+*' AS psc_run_now
      ,[psc_last_run_now]			+ '+*' AS psc_last_run_now
      ,[psc_abort_flag]				+ '+*' AS psc_abort_flag
      ,[psc_del_on_end]				+ '+*' AS psc_del_on_end
      ,[psc_public]					+ '+*' AS psc_public
      ,[psc_read_only]				+ '+*' AS psc_read_only
      ,[psc_event_name]				+ '+*' AS psc_event_name
      ,CONVERT(char,[psc_first_run_date],121)		+ '+*' AS psc_first_run_date
      ,CAST([chgstamp] AS CHAR(5))  + '+!' AS chgstamp
  INTO [DBSosxp].[dbo].[psc_batch]
  FROM [DBSpscb].[dbo].[psc_batch] WHERE [psc_userid] = 'DBS' AND [psc_batchname] = 'GHR'
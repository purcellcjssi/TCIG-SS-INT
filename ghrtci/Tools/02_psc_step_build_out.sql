
SELECT [psc_userid]					                    + '+*' AS psc_userid
      ,[psc_batchname]				                    + '+*' AS psc_batchname
      ,[psc_qualifier]				                    + '+*' AS psc_qualifier
      ,[psc_stepname]				                    + '+*' AS psc_stepname
      ,CAST([psc_step_number]    AS CHAR)			    + '+*' AS [psc_step_number]
      ,[psc_prev_step]				                    + '+*' AS psc_prev_step
      ,[psc_next_step]				                    + '+*' AS psc_next_step
      ,CAST([psc_ignore_step_sw] AS CHAR)			    + '+*' AS [psc_ignore_step_sw]
      ,CAST([psc_dbs_prog_sw]    AS CHAR)			    + '+*' AS [psc_dbs_prog_sw]
      ,CAST([psc_unique_id]      AS CHAR)			    + '+*' AS [psc_unique_id]
      ,[psc_class]				                        + '+*' AS psc_class
      ,CAST([psc_priority]       AS CHAR)			    + '+*' AS [psc_priority]
      ,[psc_condx_test]				                    + '+*' AS psc_condx_test
      ,CAST([psc_condx_test_code] AS CHAR)			    + '+*' AS [psc_condx_test_code]
      ,[psc_condx_next_step]				            + '+*' AS psc_condx_next_step
      ,CONVERT(char,[psc_last_updt_date],121) 		    + '+*' AS [psc_last_updt_date]
      ,CONVERT(char,[psc_last_comp_date],121) 		    + '+*' AS [psc_last_comp_date]
      ,CAST([psc_last_comp_rc] AS CHAR)			        + '+*' AS [psc_last_comp_rc]
      ,[psc_pgm_name]					                + '+*' AS psc_pgm_name
      ,CASE WHEN [psc_pgm_parms] = '' THEN ' ' ELSE [psc_pgm_parms] END	+ '+*' AS [psc_pgm_parms]	
      ,CAST([chgstamp] AS CHAR(5))                      + '+!' AS [chgstamp]

  INTO [DBSosxp].[dbo].[psc_step]
  FROM [DBSpscb].[dbo].[psc_step]
 WHERE [psc_userid] = 'DBS' AND [psc_batchname] = 'GHR'

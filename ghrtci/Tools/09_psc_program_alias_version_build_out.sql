/****** Script for SelectTopNRows command from SSMS  ******/
SELECT v.[psc_key]								+ '+*' AS psc_key
	  ,CASE WHEN [LANGUAGE_CODE]  = '' THEN ' ' ELSE [LANGUAGE_CODE]  END	+ '+*' AS LANGUAGE_CODE
	  ,CASE WHEN [LANGUAGE_DIALECT_CODE]  = '' THEN ' ' ELSE [LANGUAGE_DIALECT_CODE]  END	+ '+*' AS LANGUAGE_DIALECT_CODE
      ,[psc_alias]								+ '+*' AS psc_alias
      ,[psc_alias_desc]							+ '+*' AS psc_alias_desc
	  ,CASE WHEN [psc_pgm_parms]  = '' THEN ' ' ELSE [psc_pgm_parms]  END	+ '+*' AS psc_pgm_parms
      ,CAST(v.[chgstamp] AS CHAR(5))			+ '+!' AS chgstamp

  INTO [DBSosxp].[dbo].[psc_program_alias_version]
  FROM [DBSpscb].[dbo].[psc_program_alias_version] v
 INNER JOIN [DBSpscb].[dbo].[psc_program_alias] a ON a.[psc_key] = v.[psc_key]
WHERE [psc_pgm_name] like 'C:\FTP_DATA\%'


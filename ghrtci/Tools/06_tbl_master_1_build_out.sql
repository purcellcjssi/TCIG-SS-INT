SELECT [tbl_id] 						+ '+*' AS  tbl_id
      ,[tbl_name] 						+ '+*' AS  tbl_name
      ,[tbl_type] 						+ '+*' AS  tbl_type
      ,[tblfam_id] 						+ '+*' AS  tblfam_id
      ,[owner_app] 						+ '+*' AS  owner_app
      ,[notes] 							+ '+*' AS  notes
      ,[udak_flg] 						+ '+*' AS  udak_flg
      ,CAST([user_def] AS CHAR(3))		+ '+*' AS  user_def
      ,CAST([chgstamp] AS CHAR(3))		+ '+!' AS chgstamp
  INTO [DBSosxp].[dbo].[tbl_master_1]
  FROM [DBSctlg].[dbo].[tbl_master_1] WHERE tbl_id in ('u001','u002')
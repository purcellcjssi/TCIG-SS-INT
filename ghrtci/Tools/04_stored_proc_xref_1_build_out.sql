SELECT [file_id] 						+ '+*' AS  [file_id]
      ,[proc_name] 						+ '+*' AS  [proc_name] 
      ,CONVERT(char,[gen_dt],121) 		+ '+*' AS  [gen_dt]
      ,[notes] 							+ '+*' AS  [notes] 
      ,CAST([tfam_gen_seq] AS CHAR(5))  + '+*' AS  [tfam_gen_seq]
      ,[udak_flg] 						+ '+!' AS  [udak_flg]

  INTO [DBSosxp].[dbo].[stored_proc_xref_1]
  FROM [DBSctlg].[dbo].[stored_proc_xref_1] WHERE file_id in ('usfi0001','usfi0002','usfi0003','usfi0004','usfi0005','usfi0006')
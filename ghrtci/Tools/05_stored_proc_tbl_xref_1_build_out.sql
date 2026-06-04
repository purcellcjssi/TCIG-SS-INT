
SELECT [file_id] 						+ '+*' AS  [file_id]
      ,[tbl_id] 						+ '+!' AS  [tbl_id]
  INTO [DBSosxp].[dbo].[stored_proc_tbl_xref_1]
  FROM [DBSctlg].[dbo].[stored_proc_tbl_xref_1] WHERE file_id in ('usfi0001','usfi0002','usfi0003','usfi0004','usfi0005','usfi0006')


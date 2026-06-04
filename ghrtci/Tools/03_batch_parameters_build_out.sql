SELECT [batch_parameter_key] 					+ '+*' AS  batch_parameter_key 
      ,[batch_parameter_1] 						+ '+*' AS  batch_parameter_1 
      ,[batch_parameter_2] 						+ '+*' AS  batch_parameter_2 
      ,[batch_parameter_3] 						+ '+*' AS  batch_parameter_3 
      ,[batch_parameter_4] 						+ '+*' AS  batch_parameter_4 
      ,[batch_parameter_5] 						+ '+*' AS  batch_parameter_5 
      ,[batch_parameter_6] 						+ '+*' AS  batch_parameter_6 
      ,[batch_parameter_7] 						+ '+*' AS  batch_parameter_7 
      ,[batch_parameter_8] 						+ '+*' AS  batch_parameter_8 
      ,[batch_parameter_9] 						+ '+*' AS  batch_parameter_9 
      ,[batch_parameter_10] 					+ '+*' AS  batch_parameter_10 
      ,[batch_parameter_11] 					+ '+*' AS  batch_parameter_11
      ,[batch_parameter_12] 					+ '+*' AS  batch_parameter_12
      ,CAST([chgstamp] AS CHAR(5))				+ '+!' AS  chgstamp

--  INTO [DBSosxp].[dbo].[batch_parameters]
  FROM [DBSentp].[dbo].[batch_parameters] WHERE [batch_parameter_key] in ('GHR_BANKINFO_EVENTS','GHR_EMPLOYEE_EVENTS')
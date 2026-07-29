USE DBShrpn
GO

-- Header table
DELETE FROM dbo.code_policy
WHERE (code_tbl_id = '50001')
GO

-- Detail
DELETE FROM dbo.code_entry_policy
WHERE (code_tbl_id = '50001')
GO


INSERT INTO dbo.code_policy
(
  code_tbl_id
, short_descp
, code_tbl_type_code
, chgstamp
)
VALUES
(
  '50001'
, 'HCM Employee Type Mapping'
, 'EMP'
, 0
)
GO


INSERT INTO dbo.code_entry_policy
(
  code_tbl_id
, code_value
, language_code
, short_descp
, chgstamp
)
VALUES
  ('50001','CNTR','EN','CONSULTANT',0)
, ('50001','EST','EN','PERMANENT OFFICER',0)
, ('50001','MTM','EN','MONTH TO MONTH',0)
, ('50001','NEST','EN','NON ESTABLISH',0)
, ('50001','OTHER','EN','MEMBER OF PARLIAMENT',0)
, ('50001','OTHER','EN','CABINET MEMBER',0)
, ('50001','PEN','EN','PENSIONER',0)
, ('50001','PROB','EN','PROBATION',0)
, ('50001','TEMP','EN','TEMPORARY OFFICER',0)
GO


SELECT *
FROM dbo.code_entry_policy
WHERE (code_tbl_id = '50001')
GO

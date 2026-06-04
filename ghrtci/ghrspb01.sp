USE [DBShrpn]
GO

IF EXISTS (SELECT * FROM DBShrpn.dbo.sysobjects WHERE name = 'usp_bank_cleanup_tbl')
DROP PROCEDURE [dbo].[usp_bank_cleanup_tbl]
GO

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE procedure [dbo].[usp_bank_cleanup_tbl]

(@USER_ID      char(30) = NULL)

AS
BEGIN

DELETE [DBShrpn].[dbo].[ghr_bankinfo_events]

END

Grant Execute ON usp_bank_cleanup_tbl TO Public

 
GO



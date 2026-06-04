UPDATE DBSpiqd.dbo.piq_storedproc
   SET piq_server_name = @@SERVERNAME
 WHERE piq_request_name like 'U%'
GO
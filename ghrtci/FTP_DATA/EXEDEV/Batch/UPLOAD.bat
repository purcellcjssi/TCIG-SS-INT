REM Clean upload folder before run this new cycle.
Del    C:\FTP_DATA\DATA\DEV\Load\*.*   /Q

REM Preparing file for load: Interface file
Del     C:\FTP_DATA\DATA\DEV\Interface.txt
Del     C:\FTP_DATA\DATA\DEV\Load\Loaded\Interface.txt
copy    C:\FTP_DATA\DATA\DEV\Interface*.txt 						C:\FTP_DATA\DATA\DEV\Load\History\Interface*.txt
copy    C:\FTP_DATA\DATA\DEV\Interface*.txt 						C:\FTP_DATA\DATA\DEV\Load\Interface.txt
Del     C:\FTP_DATA\DATA\DEV\Interface*.txt

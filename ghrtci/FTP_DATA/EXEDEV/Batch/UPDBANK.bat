REM Clean upload folder before run this new cycle.
Del    C:\FTP_DATA\DATA\DEV\Load\b*.*   /Q

REM Preparing file for load: Interface file
Del     C:\FTP_DATA\DATA\DEV\bankinfo.txt
Del     C:\FTP_DATA\DATA\DEV\Load\Loaded\bankinfo.txt
copy    C:\FTP_DATA\DATA\DEV\bankinfo*.txt 						C:\FTP_DATA\DATA\DEV\Load\History\bankinfo*.txt
copy    C:\FTP_DATA\DATA\DEV\bankinfo*.txt 						C:\FTP_DATA\DATA\DEV\Load\bankinfo.txt
Del     C:\FTP_DATA\DATA\DEV\bankinfo*.txt

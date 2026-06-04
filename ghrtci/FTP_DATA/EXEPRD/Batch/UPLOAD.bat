REM Clean upload folder before run this new cycle.
Del    C:\FTP_DATA\DATA\PRD\Load\*.*   /Q

REM Preparing file for load: Interface file
Del     C:\FTP_DATA\DATA\PRD\Interface.txt
Del     C:\FTP_DATA\DATA\PRD\Load\Loaded\Interface.txt
copy    C:\FTP_DATA\DATA\PRD\Interface*.txt 						C:\FTP_DATA\DATA\PRD\Load\History\Interface*.txt
copy    C:\FTP_DATA\DATA\PRD\Interface*.txt 						C:\FTP_DATA\DATA\PRD\Load\Interface.txt
Del     C:\FTP_DATA\DATA\PRD\Interface*.txt

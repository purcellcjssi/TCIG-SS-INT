package ftp.client.cmd;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

public class FTPClient {
    public static void main(String [] args){
        try {
            String userid = "govofgrenada_prd_ftp";
            String passid = "zj7tHLX2KNasypp";
            String source = "C:\\FTP_Data\\PSEARNDED.TAB";
            String dest01   = "";
            String dest02   = "";
            String dest03   = "";
            String dest04   = "";
            Properties config = new Properties();
            config.put("StrictHostKeyChecking", "no");
            String host = "sftp.inforcloudsuite.com";

            String fileSaperator = ".", format = "yyyyMMMdd_HHmm";
            dest01 = getFileWithDate("PSDEDUCT.TAB", fileSaperator, format);
            dest02 = getFileWithDate("PSEARN.TAB", fileSaperator, format);
            dest03 = getFileWithDate("PSEARDED.TAB", fileSaperator, format);
            dest04 = getFileWithDate("PSNETPAY.TAB", fileSaperator, format);
            System.out.println(source);
            JSch jsch = new JSch();
            Session session = jsch.getSession(userid,host);
            session.setPassword(passid);
            session.setConfig(config);
            session.connect();
            ChannelSftp channelSftp = (ChannelSftp) session.openChannel( "sftp");
            channelSftp.connect();
            channelSftp.cd("GHRTransfer");
            channelSftp.cd("HCM_Inbound");


            channelSftp.put("C:\\FTP_DATA\\DATA\\PRD\\PSDEDUCT.TAB", dest01);
            channelSftp.put("C:\\FTP_DATA\\DATA\\PRD\\PSEARN.TAB", dest02);
            channelSftp.put("C:\\FTP_DATA\\DATA\\PRD\\PSEARNDED.TAB", dest03 );
            channelSftp.put("C:\\FTP_DATA\\DATA\\PRD\\PSNETPAY.TAB", dest04 );

            System.out.println("Session connected: "+session.isConnected());
            channelSftp.disconnect();
            session.disconnect();

        }

        catch (Exception e){
            e.printStackTrace();
        }

    }
    public static String getFileWithDate(String fileName, String fileSaperator, String dateFormat) {
        String FileNamePrefix = fileName.substring(0, fileName.lastIndexOf(fileSaperator));
        String FileNameSuffix = fileName.substring(fileName.lastIndexOf(fileSaperator)+1, fileName.length());

        String newFileName = new SimpleDateFormat("'"+FileNamePrefix+"_'"+dateFormat+"'"+fileSaperator+FileNameSuffix+"'").format(new Date());
        System.out.println("New File:"+newFileName);
        return newFileName;
    }

} // End of Class

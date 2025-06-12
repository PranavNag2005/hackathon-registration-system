package conn.dao;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
public class CaptchaVerifier {
    public static boolean verifyCaptcha(String gRecaptchaResponse) {
        try {
            String secretKey = "6LcHoVgrAAAAAKrw2ISVNVMqqp9DFnO3P6lr--Ra"; // Replace with your actual secret key
            String url = "https://www.google.com/recaptcha/api/siteverify";
            String params = "secret=" + secretKey + "&response=" + gRecaptchaResponse;

            HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

            OutputStream out = conn.getOutputStream();
            out.write(params.getBytes("UTF-8"));
            out.flush();
            out.close();

            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder responseStr = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                responseStr.append(line);
            }
            reader.close();

            // Check if the response contains "success": true
            return responseStr.toString().contains("\"success\": true");
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
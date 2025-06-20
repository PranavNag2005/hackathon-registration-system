package conn.dao;

public interface Daomethods {
boolean createuser(String name,String email,String phonenumber,String dateofbirth,String password);
boolean validuser(String email,String password);
boolean forgotpassword(String email,String password);
boolean validemail(String email);
String getUsernameByEmail(String email);
boolean updatepassword(String email,String password);
}

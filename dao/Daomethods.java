package conn.dao;

public interface Daomethods {
	public  boolean createuser(String name,String email,String phonenumber,String dateofbirth,String password,String rollnumber,String branch,String year,String clgname);
boolean validuser(String email,String password);
boolean forgotpassword(String email,String password);
boolean validemail(String email);
String getUsernameByEmail(String email);
boolean updatepassword(String email,String password);
}

package conn.dao;

public interface Daomethods {
boolean createuser(String name,String email,String phonenumber,String dateofbirth,String password);
boolean validuser(String email,String password);
}

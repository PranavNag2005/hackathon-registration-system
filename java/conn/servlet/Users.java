package conn.servlet;

import java.sql.Date;

public class Users {
    private String name;
    private String email;
    private String phoneNumber;
    private Date dateOfBirth;

    // Getters
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getPhoneNumber() { return phoneNumber; }
    public Date getDateOfBirth() { return dateOfBirth; }

    // Setters
    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }
}
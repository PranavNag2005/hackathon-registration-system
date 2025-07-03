package conn.dao;
import java.sql.Timestamp;


public class Activity {
    
    private int activityId;          
    private int userId;             
    private String activityType;    
    private String activityDetails; 
    private Timestamp activityDate; 

    
    public Activity() {
        
    }

   
    public Activity(int userId, String activityType, String activityDetails) {
        this.userId = userId;
        this.activityType = activityType;
        this.activityDetails = activityDetails;
        
    }

   
    
    public int getActivityId() {
        return activityId;
    }

    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getActivityType() {
        return activityType;
    }

    public void setActivityType(String activityType) {
        this.activityType = activityType;
    }

    public String getActivityDetails() {
        return activityDetails;
    }

    public void setActivityDetails(String activityDetails) {
        this.activityDetails = activityDetails;
    }

    public Timestamp getActivityDate() {
        return activityDate;
    }

    public void setActivityDate(Timestamp activityDate) {
        this.activityDate = activityDate;
    }

    
    
}
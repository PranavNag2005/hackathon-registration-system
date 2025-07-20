package conn.servlet;



public class Event {
    private String eventName;
    private String regDeadline;
    private String subDeadline;
    private String resultDate;
    private String status;
    private String notes;
private String eventid;
    // Getters and setters
    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }

    public String getRegDeadline() { return regDeadline; }
    public void setRegDeadline(String regDeadline) { this.regDeadline = regDeadline; }

    public String getSubDeadline() { return subDeadline; }
    public void setSubDeadline(String subDeadline) { this.subDeadline = subDeadline; }

    public String getResultDate() { return resultDate; }
    public void setResultDate(String resultDate) { this.resultDate = resultDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
	public String getEventid() {
		return eventid;
	}
	public void setEventid(String eventid) {
		this.eventid = eventid;
	}
}
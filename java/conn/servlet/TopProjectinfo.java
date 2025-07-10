package conn.servlet;

public class TopProjectinfo {
	private int pid;
    private String projectTitle;
    private String studentName;
    private double avgRating;
    private int totalRaters;
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getProjectTitle() {
		return projectTitle;
	}
	public void setProjectTitle(String projectTitle) {
		this.projectTitle = projectTitle;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public double getAvgRating() {
		return avgRating;
	}
	public void setAvgRating(double avgRating) {
		this.avgRating = avgRating;
	}
	public int getTotalRaters() {
		return totalRaters;
	}
	public void setTotalRaters(int totalRaters) {
		this.totalRaters = totalRaters;
	}
}

package conn.dao;



public class Project {
    private String title;
    private String domain;
    private String description;
    private String techStack;
    private String githubUrl;
   private boolean docsSubmitted;
   private String filepath;

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getDomain() {
        return domain;
    }
    public void setDomain(String domain) {
        this.domain = domain;
    }

    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }

    public String getTechStack() {
        return techStack;
    }
    public void setTechStack(String techStack) {
        this.techStack = techStack;
    }
    private boolean githubSubmitted;

    public boolean isGithubSubmitted() {
        return githubSubmitted;
    }

    public void setGithubSubmitted(boolean githubSubmitted) {
        this.githubSubmitted = githubSubmitted;
    }
    public String getGithubUrl() {
        return githubUrl;
    }

    public void setGithubUrl(String githubUrl) {
        this.githubUrl = githubUrl;
    }
   
    public void setDocsSubmitted(boolean docsSubmitted) { 
        this.docsSubmitted = docsSubmitted; 
    }
    
    public boolean isDocsSubmitted() {
    	return docsSubmitted;
    }
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
    
}

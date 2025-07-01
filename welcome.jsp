<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="conn.dao.Daomethodsimpl" %>
<%@ page import="conn.dao.Activity" %>
<%@ page import="conn.dao.Project" %>
<%@ page import="java.util.*" %>
<%
    // Check if user is logged in
    HttpSession sessions = request.getSession(false);
    if (sessions == null || sessions.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Get user details from session
    String userName = (String) session.getAttribute("name");
    String userEmail = (String) session.getAttribute("email");
    int userId = (Integer) session.getAttribute("sid");
    
    // Check if user has a project
    Daomethodsimpl dao = new Daomethodsimpl();
    boolean hasProject = dao.projectexists(userId);
    
    // Handle password update message
    String passwordUpdate = request.getParameter("password");
    Project project = dao.getProjectBySid(userId);
    boolean githubSubmitted = project != null && project.isGithubSubmitted();
    boolean docsSubmitted = project != null && project.isDocsSubmitted();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | HackX Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6C63FF;
            --secondary-color: #FF6584;
            --accent-color: #00BFA6;
            --dark-color: #2D3748;
            --light-gray: #f8f9fa;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #F7FAFC;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        
        .navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 15px 0;
        }
        
        .navbar-brand {
            font-weight: 700;
            color: var(--dark-color);
            font-size: 1.5rem;
        }
        
        .nav-link {
            color: var(--dark-color);
            font-weight: 500;
            margin: 0 10px;
            padding: 8px 15px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }
        
        .nav-link:hover {
            background-color: rgba(108, 99, 255, 0.1);
            color: var(--primary-color);
            transform: translateY(-2px);
        }
        
        .nav-link.active {
            color: white;
            background-color: var(--primary-color);
        }
        
        .profile-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            cursor: pointer;
            border: 2px solid var(--primary-color);
            transition: transform 0.3s ease;
        }
        
        .profile-img:hover {
            transform: scale(1.1);
        }
        
        .dropdown-menu {
            border: none;
            box-shadow: 0 5px 25px rgba(0,0,0,0.1);
            border-radius: 12px;
            padding: 10px;
            margin-top: 10px;
            border: 1px solid rgba(0,0,0,0.05);
        }
        
        .dropdown-item {
            padding: 8px 15px;
            border-radius: 8px;
            transition: all 0.2s ease;
        }
        
        .dropdown-item:hover {
            background-color: var(--primary-color);
            color: white !important;
        }
        
        .welcome-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.05);
            padding: 30px;
            margin-bottom: 30px;
            border-left: 5px solid var(--primary-color);
        }
        
        .step-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.05);
            padding: 25px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            border-left: 5px solid var(--primary-color);
        }
        
        .step-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.1);
        }
        
        .step-complete {
            border-left-color: var(--accent-color);
        }
        
        .disabled-card {
            opacity: 0.7;
            border-left-color: #ccc !important;
        }
        
        .disabled-card .step-icon {
            color: #ccc !important;
        }
        
        .step-icon {
            font-size: 28px;
            margin-right: 15px;
            color: var(--primary-color);
        }
        
        .step-complete .step-icon {
            color: var(--accent-color);
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background-color: #5a52e0;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 99, 255, 0.3);
        }
        
        .btn-success {
            background-color: var(--accent-color);
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-success:hover {
            background-color: #00a893;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 191, 166, 0.3);
        }
        
        .btn-outline-primary {
            border-color: var(--primary-color);
            color: var(--primary-color);
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-outline-primary:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }
        
        .btn-outline-secondary {
            border-color: #ccc;
            color: #666;
        }
        
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        
        .badge-pending {
            background-color: var(--secondary-color);
            color: white;
        }
        
        .badge-complete {
            background-color: var(--accent-color);
            color: white;
        }
        
        .main-content {
            padding: 30px;
            margin-top: 80px;
            flex: 1;
        }
        
        footer {
            background-color: var(--dark-color);
            color: white;
            padding: 30px 0;
            margin-top: 50px;
        }
        
        .footer-links a {
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            margin: 0 15px;
            transition: color 0.3s ease;
        }
        
        .footer-links a:hover {
            color: white;
        }
        
        .social-icons a {
            color: white;
            font-size: 20px;
            margin: 0 10px;
            transition: all 0.3s ease;
        }
        
        .social-icons a:hover {
            color: var(--primary-color);
            transform: translateY(-3px);
        }
        
        .pulse-animation {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        .list-group-item {
            padding: 12px 0;
            border-left: 3px solid transparent;
            transition: all 0.2s ease;
        }
        
        .list-group-item:hover {
            background-color: rgba(108, 99, 255, 0.05);
            border-left-color: var(--primary-color);
        }
        
        .text-info {
            color: #17a2b8;
        }
        
        @media (max-width: 768px) {
            .main-content {
                padding: 20px;
                margin-top: 70px;
            }
            
            .welcome-card {
                padding: 20px;
            }
            
            .footer-links {
                flex-direction: column;
                align-items: center;
            }
            
            .footer-links a {
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>
    <!-- Password Update Message -->
    <% if ("updated".equals(passwordUpdate)) { %>
        <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
            Password updated successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <!-- Top Navigation Bar -->
    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-code me-2"></i>HackX
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="welcome.jsp"><i class="fas fa-file-alt me-1"></i> Project Details</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= hasProject && !githubSubmitted ? "" : "disabled" %>" 
                           href="<%= hasProject && !githubSubmitted ? "github.jsp" : "javascript:void(0)" %>">
                           <i class="fab fa-github me-1"></i> Submit GitHub
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= hasProject && !docsSubmitted ? "" : "disabled" %>" 
                           href="<%= hasProject && !docsSubmitted ? "worddoc.jsp" : "javascript:void(0)" %>">
                           <i class="fas fa-file-word me-1"></i> Submit Docs
                        </a>
                    </li>
                </ul>
                <div class="dropdown">
                    <a class="d-flex align-items-center text-decoration-none dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=<%= userName %>&background=6C63FF&color=fff" 
                             alt="Profile" class="profile-img me-2">
                        <span class="d-none d-sm-inline"><%= userName %></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li class="px-3 py-2">
                            <small>Signed in as</small>
                            <div class="fw-bold"><%= userEmail %></div>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="updatepassword.jsp"><i class="fas fa-key me-2"></i> Update Password</a></li>
                        <li><a class="dropdown-item" href="logout.jsp"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content Section -->
    <div class="main-content">
        <div class="container">
            <!-- Welcome Card -->
            <div class="welcome-card">
                <h2>Welcome back, <%= userName %>! <i class="fas fa-hand-sparkles text-warning"></i></h2>
                <p class="text-muted">Here's what you need to do next for the hackathon submission.</p>
                
                <div class="d-flex align-items-center mt-3">
                    <span class="status-badge <%= hasProject && githubSubmitted && docsSubmitted ? "badge-complete" : "badge-pending pulse-animation" %> me-3">
                        <i class="fas <%= hasProject && githubSubmitted && docsSubmitted ? "fa-check-circle" : "fa-clock" %> me-1"></i>
                        <%= hasProject && githubSubmitted && docsSubmitted ? "Submission Complete" : "Submission Pending" %>
                    </span>
                    <small class="text-muted">Deadline: June 30, 2023 at 11:59 PM</small>
                </div>
            </div>
          
            <!-- Progress Steps -->
            <div class="row">
                <!-- Project Details Step -->
                <div class="col-md-4">
                    <div class="step-card <%= hasProject ? "step-complete" : "" %>">
                        <div class="d-flex align-items-center">
                            <div class="step-icon"><i class="fas fa-file-alt"></i></div>
                            <div>
                                <h5>Project Details</h5>
                                <p class="text-muted mb-2">
                                    <%= hasProject ? "Project submitted - You can edit" : "Complete your project details first" %>
                                </p>
                                <a href="<%= hasProject ? "Projectservlet?mode=edit" : "project.jsp" %>" 
                                   class="btn <%= hasProject ? "btn-success" : "btn-primary" %> btn-sm">
                                    <%= hasProject ? "Edit Project" : "Start Project Form" %>
                                    <i class="fas fa-arrow-right ms-2"></i>
                                </a>
                                <% if (hasProject) { %>
                                    <div class="mt-2">
                                        <small class="text-muted">Project Name:</small><br>
                                        <strong><%= project.getTitle() %></strong>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- GitHub Submission Step -->
                <div class="col-md-4">
                    <div class="step-card <%= githubSubmitted ? "step-complete" : (hasProject ? "" : "disabled-card") %>">
                        <div class="d-flex align-items-center">
                            <div class="step-icon">
                                <i class="fab fa-github <%= githubSubmitted ? "text-success" : (hasProject ? "" : "text-muted") %>"></i>
                            </div>
                            <div>
                                <h5 class="<%= hasProject ? "" : "text-muted" %>">GitHub Repository</h5>
                                <% if (githubSubmitted) { %>
                                    <p class="text-success mb-2">
                                        <i class="fas fa-check-circle"></i> Submitted (cannot be changed)
                                    </p>
                                    <button class="btn btn-success btn-sm" disabled>
                                        <i class="fas fa-lock"></i> Locked
                                    </button>
                                    <div class="mt-2">
                                        <small>Submitted URL:</small><br>
                                        <span class="text-truncate d-inline-block" style="max-width: 200px;">
                                            <%= project.getGithubUrl() %>
                                        </span>
                                    </div>
                                <% } else { %>
                                    <p class="text-muted mb-2">
                                        <%= hasProject ? "Submit your project code link" : "Complete project form first" %>
                                    </p>
                                    <a href="<%= hasProject ? "github.jsp" : "#" %>" 
                                       class="btn <%= hasProject ? "btn-primary" : "btn-outline-secondary disabled" %> btn-sm"
                                       <%= hasProject ? "" : "tabindex=\"-1\" aria-disabled=\"true\"" %>>
                                        <%= hasProject ? "Submit GitHub" : "Not Available" %>
                                    </a>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Documentation Step -->
                <div class="col-md-4">
                    <div class="step-card <%= docsSubmitted ? "step-complete" : (hasProject ? "" : "disabled-card") %>">
                        <div class="d-flex align-items-center">
                            <div class="step-icon">
                                <i class="fas fa-file-word <%= docsSubmitted ? "text-success" : (hasProject ? "" : "text-muted") %>"></i>
                            </div>
                            <div>
                                <h5 class="<%= hasProject ? "" : "text-muted" %>">Documentation</h5>
                                <% if (docsSubmitted) { %>
                                    <p class="text-success mb-2">
                                        <i class="fas fa-check-circle"></i> Submitted (cannot be changed)
                                    </p>
                                    <button class="btn btn-success btn-sm" disabled>
                                        <i class="fas fa-lock"></i> Locked
                                    </button>
                                    <div class="mt-2">
                                        <a href="download?file=<%= project.getTitle() %>" 
                                           class="btn btn-outline-secondary btn-sm">
                                            <i class="fas fa-download"></i> Download Document
                                        </a>
                                    </div>
                                <% } else { %>
                                    <p class="text-muted mb-2">
                                        <%= hasProject ? "Upload your project documentation" : "Complete project form first" %>
                                    </p>
                                    <a href="<%= hasProject ? "worddoc.jsp" : "#" %>" 
                                       class="btn <%= hasProject ? "btn-primary" : "btn-outline-secondary disabled" %> btn-sm"
                                       <%= hasProject ? "" : "tabindex=\"-1\" aria-disabled=\"true\"" %>>
                                        <%= hasProject ? "Upload Docs" : "Not Available" %>
                                    </a>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Activity Feed -->
            <div class="welcome-card mt-4">
                <h5><i class="fas fa-history me-2" style="color: var(--secondary-color);"></i> Recent Activity</h5>
                <ul class="list-group list-group-flush mt-3" id="activityFeed">
                    <% 
                    List<Activity> activities = dao.getUserActivities(userId);
                    if (activities.isEmpty()) { %>
                        <li class="list-group-item border-0 ps-0"><small>No recent activity yet</small></li>
                    <% } else {
                        for (Activity activity : activities) { 
                            String icon = "";
                            String textClass = "";
                            
                            switch(activity.getActivityType()) {
                                case "PROJECT_CREATE":
                                    icon = "fa-file-alt";
                                    break;
                                case "PROJECT_EDIT":
                                    icon="fa-file-pen";
                                    break;
                                case "GITHUB_UPDATE":
                                    icon = "fab fa-github";
                                    break;
                                case "DOCS_UPLOAD":
                                    icon = "fa-file-word";
                                    break;
                                case "PASSWORD_CHANGE":
                                    icon = "fa-key";
                                    textClass = "text-info";
                                    break;
                                default:
                                    icon = "fa-check-circle";
                            }
                    %>
                        <li class="list-group-item border-0 ps-0 <%= textClass %>">
                            <i class="fas <%= icon %> me-2"></i>
                            <span><%= activity.getActivityDetails() %> - 
                            <small class="text-muted"><%= activity.getActivityDate() %></small></span>
                        </li>
                    <%   }
                       } %>
                </ul>
            </div>
        </div>
    </div>

    <!-- Footer Section -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center text-md-start">
                    <p>&copy; 2025 HackX. All rights reserved.</p>
                </div>
                <div class="col-md-6">
                    <div class="d-flex justify-content-center justify-content-md-end footer-links">
                        <a href="#terms">Terms of Service</a>
                        <a href="#privacy">Privacy Policy</a>
                        <a href="#contact">Contact Us</a>
                    </div>
                    <div class="d-flex justify-content-center justify-content-md-end social-icons mt-3">
                        <a href="#twitter"><i class="fab fa-twitter"></i></a>
                        <a href="#facebook"><i class="fab fa-facebook-f"></i></a>
                        <a href="#instagram"><i class="fab fa-instagram"></i></a>
                        <a href="https://www.linkedin.com/in/pranavnaguppalapati/"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-dismiss alert after 5 seconds
        setTimeout(() => {
            const alert = document.querySelector('.alert');
            if (alert) {
                alert.classList.remove('show');
                setTimeout(() => alert.remove(), 300);
            }
        }, 5000);
        
        // Disable navigation links for completed steps
        document.querySelectorAll('.nav-link.disabled').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                alert('This step is already completed and cannot be modified');
            });
        });
    </script>
</body>
</html>

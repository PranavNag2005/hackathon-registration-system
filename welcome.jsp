<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="conn.dao.Daomethodsimpl" %>
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
    <!-- [Rest of your JSP body content remains exactly the same] -->
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
                        <a class="nav-link <%= hasProject ? "" : "disabled" %>" 
                           href="<%= hasProject ? "#github" : "javascript:void(0)" %>">
                           <i class="fab fa-github me-1"></i> Submit GitHub & Doc
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
                    <span class="status-badge <%= hasProject ? "badge-complete" : "badge-pending pulse-animation" %> me-3">
                        <i class="fas <%= hasProject ? "fa-check-circle" : "fa-clock" %> me-1"></i>
                        <%= hasProject ? "Submission Complete" : "Submission Pending" %>
                    </span>
                    <small class="text-muted">Deadline: June 30, 2023 at 11:59 PM</small>
                </div>
            </div>
          
            <!-- Progress Steps -->
            <div class="row">
                <div class="col-md-4">
                    <div class="step-card <%= hasProject ? "step-complete" : "" %>">
                        <div class="d-flex align-items-center">
                            <div class="step-icon"><i class="fas fa-file-alt"></i></div>
                            <div>
                                <h5>Project Details</h5>
                                <p class="text-muted mb-2"><%= hasProject ? "Update your project information" : "Submit your project information" %></p>
                                <a href="<%= hasProject ? "Projectservlet?mode=edit" : "project.jsp" %>" 
                                   class="btn <%= hasProject ? "btn-success" : "btn-primary" %> btn-sm">
                                    <%= hasProject ? "Edit Project" : "Complete Form" %>
                                    <i class="fas fa-arrow-right ms-2"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="step-card <%= hasProject ? "step-complete" : "" %>">
                        <div class="d-flex align-items-center">
                            <div class="step-icon"><i class="fab fa-github"></i></div>
                            <div>
                                <h5>GitHub Repository</h5>
                                <p class="text-muted mb-2"><%= hasProject ? "Update your project code link" : "Submit your project code link" %></p>
                                <a href="<%= hasProject ? "#github" : "javascript:void(0)" %>" 
                                   class="btn <%= hasProject ? "btn-success" : "btn-outline-primary disabled" %> btn-sm">
                                    <%= hasProject ? "Update GitHub" : "Not Available" %>
                                    <i class="fas <%= hasProject ? "fa-unlock" : "fa-lock" %> ms-2"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="step-card <%= hasProject ? "step-complete" : "" %>">
                        <div class="d-flex align-items-center">
                            <div class="step-icon"><i class="fas fa-file-word"></i></div>
                            <div>
                                <h5>Documentation</h5>
                                <p class="text-muted mb-2"><%= hasProject ? "Update your project documentation" : "Upload your project documentation" %></p>
                                <a href="<%= hasProject ? "#documentation" : "javascript:void(0)" %>" 
                                   class="btn <%= hasProject ? "btn-success" : "btn-outline-primary disabled" %> btn-sm">
                                    <%= hasProject ? "Update Docs" : "Not Available" %>
                                    <i class="fas <%= hasProject ? "fa-unlock" : "fa-lock" %> ms-2"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Recent Activity -->
            <div class="welcome-card mt-4">
                <h5><i class="fas fa-history me-2" style="color: var(--secondary-color);"></i> Recent Activity</h5>
                <ul class="list-group list-group-flush mt-3" id="activityFeed">
                    <% if (hasProject) { %>
                        <li class="list-group-item border-0 ps-0">
                            <i class="fas fa-check-circle text-success me-2"></i>
                            <span>Project details submitted on <%= new java.util.Date() %></span>
                        </li>
                    <% } else { %>
                        <li class="list-group-item border-0 ps-0"><small>No recent activity yet</small></li>
                    <% } %>
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
                        <a href="#linkedin"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toast notification function
        function showToast(message, type = 'info') {
            const toast = document.createElement('div');
            let iconClass;
            if (type === 'success') {
                iconClass = 'fa-check-circle';
            } else if (type === 'danger') {
                iconClass = 'fa-exclamation-circle';
            } else {
                iconClass = 'fa-info-circle';
            }
            
            toast.className = `toast show align-items-center text-white bg-${type} border-0 position-fixed bottom-0 end-0 m-3`;
            toast.style.zIndex = '9999';
            toast.innerHTML = `
                <div class="d-flex">
                    <div class="toast-body">
                        <i class="fas ${iconClass} me-2"></i>
                        ${message}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
                </div>
            `;
            document.body.appendChild(toast);
            
            setTimeout(() => {
                toast.classList.remove('show');
                setTimeout(() => toast.remove(), 300);
            }, 5000);
        }

        // Auto-dismiss alert after 5 seconds
        setTimeout(() => {
            const alert = document.querySelector('.alert');
            if (alert) {
                alert.classList.remove('show');
                setTimeout(() => alert.remove(), 300);
            }
        }, 5000);
    </script>
</body>
</html>
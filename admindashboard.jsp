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
    int userId = (Integer) session.getAttribute("admin_id");
    
    
    int githubCount=(Integer)session.getAttribute("githubCount");
    int docCount=(Integer)session.getAttribute("docCount");
    int bothCount=(Integer)session.getAttribute("bothCount");
    int registeredCount=(Integer)session.getAttribute("registeredCount");
    int projectsubmitted=(Integer)session.getAttribute("projectsubmitted");
    
           int webDevCount=(Integer)session.getAttribute("webDevCount");
          int aiCount=(Integer)session.getAttribute("aiCount");
          int cloudCount=(Integer)session.getAttribute("cloudCount");
          int iotCount=(Integer)session.getAttribute("iotCount");
          int gameDevCount=(Integer)session.getAttribute("gameDevCount");
          int mobileCount=(Integer)session.getAttribute("mobileCount");
        		  int sensorCount=(Integer)session.getAttribute("sensorCount");
        		   int dataScienceCount=(Integer)session.getAttribute("dataScienceCount");
        		   int rated = (Integer) session.getAttribute("rated");
        		    int pending = (Integer) session.getAttribute("pending");

        		 

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> ADMIN Dashboard | HackX Portal</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        .container2 {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 30px;
  margin-top: 100px;
}

.sidebar {
  flex: 1;
  max-width: 400px;
}

.chartcontainer {
  display: flex;
  justify-content: space-around;
  gap: 40px;
  margin-top: 150px;
}
.chartcontainer h3 {
  font-family: 'Segoe UI', sans-serif;
  font-size: 18px;
  color: #34495E;
}
    </style>
</head>
<body>
   
   

    <!-- Top Navigation Bar -->
    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand" href="admindashboard.jsp">
                <i class="fas fa-code me-2"></i>HackX
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
  <a class="nav-link" href="Viewsubmissionservlet"  >
     View Participants
  </a>
</li>
                 <li class="nav-item">
  <a class="nav-link" href="Adminviewprojectservlet"  >
     View Submissions
  </a>   </li>
  <li class="nav-item">
  <a class="nav-link" href="Topprojectservlet"  >
     Top Projects
  </a>   </li>
 <% 
Boolean specialaccess = (Boolean) session.getAttribute("showUpdateForm");
if (specialaccess != null && specialaccess) {
%>
    <li class="nav-item"><a class="nav-link" href="eventdetails.jsp">Update Event</a></li>
<% 
} 
%>      
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
                        <li><a class="dropdown-item" href="adminupdatepassword.jsp"><i class="fas fa-key me-2"></i> Update Password</a></li>
                        <li><a class="dropdown-item" href="logout.jsp"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>
<div class="chartcontainer" style="display: flex; justify-content: space-around;">
  <div style="text-align: center;">
    <h3 style="margin-bottom: 10px; color: #2E86C1;">Submission Types</h3>
    <canvas id="submissionTypeChart" width="400" height="400"></canvas>
  </div>
  
  <div style="text-align: center;">
    <h3 style="margin-bottom: 10px; color: #884EA0;">Chosen Domains</h3>
    <canvas id="domainChoiceChart" width="400" height="400"></canvas>
  </div>

     <div style="text-align: center;">
    <h3 style="margin-bottom: 10px; color: #884EA0;">Rated Projects	</h3>
    <canvas id="ratingStatusChart" width="400" height="400"></canvas>

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
   <script>
  const ctx = document.getElementById('submissionTypeChart');
  new Chart(ctx, {
    type: 'pie',
    data: {
      labels: ['GitHub Only', 'Word Doc Only', 'Both', 'Registered','Project Submitted'],
      datasets: [{
        data: [
          ${githubCount}, 
          ${docCount}, 
          ${bothCount},
          ${registeredCount}, 
          ${projectsubmitted}
        ],
        backgroundColor: [
        	  '#00B0FF', // Bright Sky Blue
        	  '#FF6D00', // Deep Orange
        	  '#D500F9', // Electric Purple
        	  '#00C853', // Neon Green
        	  '#FF4081'  // Vivid Pink
        	]
      }]
    },
    options: {
      responsive: true,
      plugins: {
        legend: { position: 'bottom' },
        
      }
    }
  });
  
  const domainChoiceCtx = document.getElementById('domainChoiceChart').getContext('2d');
  const domainChart = new Chart(domainChoiceCtx, {
      type: 'pie',
      data: {
          labels: ['AI & ML', 'Web Dev', 'CloudComputing', 'IOT Solutions','Game Dev','Mobile App Dev','Sensor-Based Applications','Data Science'],
          datasets: [{
        	  data: [${aiCount},
        		  ${webDevCount},
        		  
        		  ${cloudCount},
        		  ${iotCount},
        		  ${gameDevCount},
        		  ${mobileCount},
        		  ${sensorCount},
        		  ${dataScienceCount},
        		],
              backgroundColor: [
            	  '#FFB300', // Vivid Amber
            	  '#8E24AA', // Deep Purple
            	  '#1E88E5', // Strong Blue
            	  '#43A047', // Rich Green
            	  '#F4511E', // Burnt Orange
            	  '#5E35B1', // Indigo
            	  '#00ACC1', // Teal
            	  '#C0CA33'  // Lime Olive
            	]
          }]
      },options: {
          responsive: true,
          plugins: {
            legend: { position: 'bottom' },
            
          }
        }
  });

</script>
    <script>
    const ctxs = document.getElementById('ratingStatusChart').getContext('2d');
    const chart = new Chart(ctxs, {
        type: 'pie',
        data: {
            labels: ['Rated Projects', 'Pending Projects'],
            datasets: [{
                data: [${rated},${pending}],
                backgroundColor: ['#4CAF50', '#FFC107']
            }]
        },
        options: {
            plugins: {
                legend: { position: 'bottom' },
                title: {
                    display: true,
                    text: 'Projects You\'ve Rated vs Pending',
                    position:'bottom'
                }
            }
        }
    });
</script>
    
</body>
</html>

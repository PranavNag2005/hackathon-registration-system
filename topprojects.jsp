<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,conn.servlet.TopProjectinfo" %>
<%@ page import="conn.dao.Admindaoimpl" %>
<%
List<TopProjectinfo> topProjects = (List<TopProjectinfo>)request.getAttribute("topProjects");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Top Project Details</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --accent: #4895ef;
            --dark: #1b263b;
            --light: #f8f9fa;
            --success: #4cc9f0;
            --warning: #f72585;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color: var(--dark);
            min-height: 100vh;
            padding: 2rem;
        }
        
        .header {
            text-align: center;
            margin-bottom: 2.5rem;
            position: relative;
        }
        
        .header h2 {
            font-size: 2.5rem;
            font-weight: 600;
            color: var(--secondary);
            position: relative;
            display: inline-block;
            padding-bottom: 0.5rem;
        }
        
        .header h2::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: var(--accent);
            border-radius: 2px;
        }
        
        .header p {
            color: #666;
            font-size: 1.1rem;
            margin-top: 0.5rem;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }
        
        .card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 2rem;
        }
        
        .filters {
            padding: 1.5rem;
            background: #f8f9fa;
            border-bottom: 1px solid #eee;
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            align-items: center;
        }
        
        .filter-group {
            display: flex;
            flex-direction: column;
            min-width: 180px;
        }
        
        .filter-group label {
            font-size: 0.85rem;
            margin-bottom: 0.3rem;
            color: #666;
            font-weight: 500;
        }
        
        .filter-group input, 
        .filter-group select {
            padding: 0.6rem 0.8rem;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-family: inherit;
            transition: all 0.3s;
        }
        
        .filter-group input:focus, 
        .filter-group select:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(72, 149, 239, 0.2);
        }
        
        .filter-actions {
            display: flex;
            gap: 0.5rem;
            margin-left: auto;
        }
        
        .table-responsive {
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        thead {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
        }
        
        th {
            padding: 1.2rem 1rem;
            text-align: left;
            font-weight: 500;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }
        
        tbody tr {
            border-bottom: 1px solid #eee;
            transition: all 0.3s ease;
        }
        
        tbody tr:last-child {
            border-bottom: none;
        }
        
        tbody tr:hover {
            background-color: #f8f9fa;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        
        td {
            padding: 1.2rem 1rem;
            color: #555;
        }
        
        .btn {
            display: inline-block;
            padding: 0.5rem 1.2rem;
            border-radius: 6px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 0.9rem;
        }
        
        .btn-primary {
            background: var(--primary);
            color: white;
        }
        
        .btn-primary:hover {
            background: var(--secondary);
            transform: translateY(-2px);
        }
        
        .btn-outline {
            background: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
        }
        
        .btn-outline:hover {
            background: var(--primary);
            color: white;
        }
        
        .btn-reset {
            background: #f1f1f1;
            color: #666;
            border: 1px solid #ddd;
        }
        
        .btn-reset:hover {
            background: #e9e9e9;
        }
        
        .rating-form {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .rating-stars {
            display: flex;
            gap: 0.3rem;
            justify-content: center;
        }
        
        .rating-stars input[type="radio"] {
            display: none;
        }
        
        .rating-stars label {
            color: #ddd;
            font-size: 1.5rem;
            cursor: pointer;
            transition: color 0.2s;
        }
        
        .rating-stars input[type="radio"]:checked ~ label {
            color: #ffc107;
        }
        
        .rating-stars label:hover,
        .rating-stars label:hover ~ label {
            color: #ffc107;
        }
        
        textarea {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 6px;
            resize: vertical;
            min-height: 80px;
            font-family: inherit;
            transition: border 0.3s;
        }
        
        textarea:focus {
            outline: none;
            border-color: var(--accent);
        }
        
        select {
            padding: 0.5rem;
            border-radius: 6px;
            border: 1px solid #ddd;
            font-family: inherit;
        }
        
        .no-projects {
            text-align: center;
            padding: 2rem;
            color: #666;
        }
        
        .no-projects i {
            font-size: 3rem;
            color: #ddd;
            margin-bottom: 1rem;
        }
        
        .badge {
            display: inline-block;
            padding: 0.3rem 0.6rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .badge-domain {
            background: #e3f2fd;
            color: #1976d2;
        }
        
        .badge-tech {
            background: #e8f5e9;
            color: #388e3c;
        }
        
        .action-btns {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        
        @media (max-width: 768px) {
            .header h2 {
                font-size: 2rem;
            }
            
            .filters {
                flex-direction: column;
                align-items: stretch;
            }
            
            .filter-actions {
                margin-left: 0;
                justify-content: flex-end;
            }
            
            th, td {
                padding: 0.8rem 0.5rem;
                font-size: 0.9rem;
            }
            
            .btn {
                padding: 0.4rem 0.8rem;
                font-size: 0.8rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>INNOVATIVE PROJECTS</h2>
            <p>Highly Rated projects submitted by our talented community</p>
        </div>
        
        <div class="card">
            <div class="filters">
                <div class="filter-group">
                    <label for="projectIdFilter">Project ID</label>
                    <input type="text" id="projectIdFilter" placeholder="Filter by ID">
                </div>
                
                <div class="filter-group">
                    <label for="projectTitleFilter">Project Title</label>
                    <input type="text" id="projectTitleFilter" placeholder="Filter by title">
                </div>
                
                <div class="filter-group">
                    <label for="studentNameFilter">Student Name</label>
                    <input type="text" id="studentNameFilter" placeholder="Filter by name">
                </div>
                
                <div class="filter-actions">
                    <button class="btn btn-primary" onclick="filterTable()">
                        <i class="fas fa-filter"></i> Filter
                    </button>
                    <button class="btn btn-reset" onclick="resetFilters()">
                        <i class="fas fa-redo"></i> Reset
                    </button>
                </div>
            </div>
            
            <div class="table-responsive">
                <table id="projectsTable">
                    <thead>
                        <tr>
                            <th>Rank</th>
                            <th>Project ID</th>
                            <th>Project Title</th>
                            <th>Name</th>
                            <th>Average Rating</th>
                            <th>Total Raters</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        int rank=1;
                            if (topProjects != null && !topProjects.isEmpty()) {
                                for (TopProjectinfo project : topProjects) {
                        %>
                        <tr>
                            <td style="font-size:1.5rem;text-align:center;">
    <% if (rank == 1) { %>
        <span style="font-size: 2rem;">🥇</span>
    <% } else if (rank == 2) { %>
        <span style="font-size: 2rem;">🥈</span>
    <% } else if (rank == 3) { %>
        <span style="font-size: 2rem;">🥉</span>
    <% } else { %>
        <%= rank %>
    <% } %>
</td>
                            <td style="font-size:1.5rem;text-align:center;"><%= project.getPid() %></td>
                            <td style="font-weight:bold;"><%= project.getProjectTitle() %></td>
                            <td style="font-weight:bold;"><%= project.getStudentName()%></td>
                            <td style="font-size:1.5rem;text-align:center;"><%=project.getAvgRating() %></td>
                            <td style="font-size:1.5rem;text-align:center;"><%=project.getTotalRaters() %></td>     
                        </tr>
                        <% rank+=1; %>
                        <% } %>
                        <% } else { %>
                        <tr>
                            <td colspan="6">
                                <div class="no-projects">
                                    <i class="far fa-folder-open"></i>
                                    <h3>No Projects Found</h3>
                                    <p>There are currently no projects to display.</p>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        function filterTable() {
            const idFilter = document.getElementById('projectIdFilter').value.toLowerCase();
            const titleFilter = document.getElementById('projectTitleFilter').value.toLowerCase();
            const nameFilter = document.getElementById('studentNameFilter').value.toLowerCase();
            
            const rows = document.querySelectorAll('#projectsTable tbody tr');
            
            rows.forEach(row => {
                if (row.querySelector('.no-projects')) return;
                
                const id = row.cells[1].textContent.toLowerCase();
                const title = row.cells[2].textContent.toLowerCase();
                const name = row.cells[3].textContent.toLowerCase();
                
                const idMatch = id.includes(idFilter);
                const titleMatch = title.includes(titleFilter);
                const nameMatch = name.includes(nameFilter);
                
                if (idMatch && titleMatch && nameMatch) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }
        
        function resetFilters() {
            document.getElementById('projectIdFilter').value = '';
            document.getElementById('projectTitleFilter').value = '';
            document.getElementById('studentNameFilter').value = '';
            
            const rows = document.querySelectorAll('#projectsTable tbody tr');
            rows.forEach(row => {
                row.style.display = '';
            });
        }
        
        // Add event listeners for Enter key in filter inputs
        document.getElementById('projectIdFilter').addEventListener('keyup', function(e) {
            if (e.key === 'Enter') filterTable();
        });
        
        document.getElementById('projectTitleFilter').addEventListener('keyup', function(e) {
            if (e.key === 'Enter') filterTable();
        });
        
        document.getElementById('studentNameFilter').addEventListener('keyup', function(e) {
            if (e.key === 'Enter') filterTable();
        });
    </script>
</body>
</html>

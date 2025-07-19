<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List,conn.servlet.Users, java.util.HashSet, java.util.Set" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Details</title>
    <style>
        /* Modern Gradient Background */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

        /* Main Container */
        .main-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        h2 {
            font-size: 32px;
            margin-bottom: 30px;
            text-align: center;
            color: #fff;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        /* Filter Section */
        .filter-section {
            background: rgba(255, 255, 255, 0.2);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: flex-end;
        }

        .filter-group {
            flex: 1;
            min-width: 200px;
        }

        .filter-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            font-size: 14px;
        }

        .filter-group select, .filter-group input {
            width: 90%;
            padding: 10px 15px;
            border-radius: 5px;
            border: none;
            background: rgba(255, 255, 255, 0.9);
            font-size: 14px;
        }

        .filter-actions {
            display: flex;
            gap: 10px;
        }

        .filter-btn {
            padding: 10px 20px;
            background: linear-gradient(to right, #4b6cb7, #182848);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .filter-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .reset-btn {
            background: linear-gradient(to right, #e74c3c, #c0392b);
        }

        /* Table Styling */
        .table-container {
            overflow-x: auto;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            color: #333;
            border-radius: 10px;
            overflow: hidden;
        }

        th {
            background: linear-gradient(to right, #4b6cb7, #182848);
            color: white;
            padding: 15px;
            text-align: center;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 1px;
        }

        td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
            transform: scale(1.01);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        /* No Users Message */
        .no-users {
            padding: 20px;
            font-size: 18px;
            color: #e74c3c;
            text-align: center;
            font-weight: bold;
        }

        /* Download Button */
        .download-btn {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 25px;
            background: linear-gradient(to right, #00b09b, #96c93d);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }

        .download-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
            background: linear-gradient(to right, #96c93d, #00b09b);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                margin: 20px;
                padding: 15px;
            }
            
            .filter-section {
                flex-direction: column;
            }
            
            .filter-group {
                width: 100%;
            }
            
            th, td {
                padding: 8px 10px;
                font-size: 14px;
            }
            
            h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <h2>🌟 User Details 🌟</h2>
        
        <!-- Filter Section -->
        <div class="filter-section">
            <div class="filter-group">
                <label for="collegeFilter">College Name</label>
                <select id="collegeFilter" name="collegeFilter">
                    <option value="">All Colleges</option>
                    <%
                        List<Users> allUsers = (List<Users>) request.getAttribute("userList");
                        Set<String> collegeNames = new HashSet<>();
                        if (allUsers != null && !allUsers.isEmpty()) {
                            for (Users user : allUsers) {
                                collegeNames.add(user.getCollegeName());
                            }
                            for (String college : collegeNames) {
                    %>
                    <option value="<%= college %>"><%= college %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            
            <div class="filter-group">
                <label for="branchFilter">Branch</label>
                <input type="text" id="branchFilter" name="branchFilter" placeholder="Filter by branch">
            </div>
            
            <div class="filter-actions">
                <button class="filter-btn" onclick="filterTable()">Apply Filters</button>
                <button class="filter-btn reset-btn" onclick="resetFilters()">Reset</button>
            </div>
        </div>
        
        <div class="table-container">
            <table id="usersTable">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone Number</th>
                        <th>Date Of Birth</th>
                        <th>College Name</th>
                        <th>Branch</th>
                        <th>Year of Study</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (allUsers != null && !allUsers.isEmpty()) {
                            for (Users user : allUsers) {
                    %>
                    <tr>
                        <td><%= user.getName() %></td>
                        <td><%= user.getEmail() %></td>
                        <td><%= user.getPhoneNumber() %></td>
                        <td><%= user.getDateOfBirth() %></td>
                        <td><%= user.getCollegeName() %></td>
                        <td><%= user.getBranch() != null ? user.getBranch() : "Not mentioned" %></td>
                        <td><%=user.getYearOfStudy() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6" class="no-users">No users found in the database.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        
        <div style="text-align: center;">
            <a href="DownloadUsersPdf?branch=<%= request.getParameter("branchFilter") %>&college=<%= request.getParameter("collegeFilter") %>&year=<%= request.getParameter("yearFilter") %>" class="download-btn">
    Download as PDF
</a>
        </div>
    </div>

    <script>
        function filterTable() {
            const collegeFilter = document.getElementById('collegeFilter').value.toLowerCase();
            const branchFilter = document.getElementById('branchFilter').value.toLowerCase();
            const table = document.getElementById('usersTable');
            const rows = table.getElementsByTagName('tr');
            
            for (let i = 1; i < rows.length; i++) {
                const row = rows[i];
                const cells = row.getElementsByTagName('td');
                if (cells.length < 6) continue; // Skip header or no-data row
                
                const collegeName = cells[4].textContent.toLowerCase();
                const branch = cells[5].textContent.toLowerCase();
                
                const collegeMatch = collegeFilter === '' || collegeName.includes(collegeFilter);
                const branchMatch = branchFilter === '' || branch.includes(branchFilter);
                
                if (collegeMatch && branchMatch) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            }
        }
        
        function resetFilters() {
            document.getElementById('collegeFilter').value = '';
            document.getElementById('branchFilter').value = '';
            filterTable();
        }
    </script>
</body>
</html>
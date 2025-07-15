<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="conn.dao.Project" %>
<%
    Project p = (Project) request.getAttribute("project");
%>
<% String mode = request.getParameter("mode"); %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Project Submission | HackX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --accent: #4cc9f0;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #4bb543;
        }

        body {
            background-color: #f5f7ff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .project-card {
            width: 90%;
            max-width: 800px;
            margin: 2rem auto;
            padding: 2.5rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            position: relative;
        }

        .project-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: linear-gradient(to bottom, var(--primary), var(--accent));
        }

        .form-title {
            color: var(--dark);
            margin-bottom: 2rem;
            font-weight: 700;
            position: relative;
            padding-bottom: 1rem;
        }

        .form-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 60px;
            height: 4px;
            background: var(--primary);
            border-radius: 2px;
        }

        .form-label, .floating-label {
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(67, 97, 238, 0.15);
        }

        .floating-label-group {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .floating-label {
            position: absolute;
            top: 12px;
            left: 15px;
            transition: all 0.3s ease;
            pointer-events: none;
            background: white;
            padding: 0 5px;
            font-size: 1rem;
        }

        .form-control:focus ~ .floating-label,
        .form-control:not(:placeholder-shown) ~ .floating-label {
            top: -10px;
            left: 10px;
            font-size: 0.8rem;
            color: var(--primary);
        }

        .submit-btn {
            background: var(--primary);
            border: none;
            color: white;
            padding: 12px;
            font-weight: 600;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .submit-btn:hover {
            background: var(--secondary);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }
    </style>
</head>
<body>
    <div class="project-card">
        <h2 class="form-title">
            <i class="fas fa-project-diagram me-2"></i>Submit Your Project
        </h2>

        <form action="Projectservlet" method="post">
            <!-- Title -->
            <div class="floating-label-group mb-4">
                <input type="text" class="form-control" id="title" name="title" required placeholder=" "
                       value="<%= p != null ? p.getTitle() : "" %>">
                <label class="floating-label">Project Title</label>
            </div>

            <!-- Domain -->
            <div class="mb-4">
                <label class="form-label">Project Domain</label>
                <select class="form-select" id="domain" name="domain" required>
                    <option value="" disabled <%= p == null ? "selected" : "" %>>Select domain</option>
                    <option value="Web Development" <%= p != null && "Web Development".equals(p.getDomain()) ? "selected" : "" %>>Web Development</option>
                    <option value="AI & ML" <%= p != null && "AI & ML".equals(p.getDomain()) ? "selected" : "" %>>AI & Machine Learning</option>
                    <option value="Cloud Computing" <%= p != null && "Cloud Computing".equals(p.getDomain()) ? "selected" : "" %>>Cloud Computing</option>
                    <option value="IOT Solutions" <%= p != null && "IOT Solutions".equals(p.getDomain()) ? "selected" : "" %>>IOT Solutions</option>
                    <option value="Game Development" <%= p != null && "Game Development".equals(p.getDomain()) ? "selected" : "" %>>Game Development</option>
                    <option value="Sensor Based Applications" <%= p != null && "Sensor Based Applications".equals(p.getDomain()) ? "selected" : "" %>>Sensor Based Applications</option>
                    <option value="Data Science" <%= p != null && "Data Science".equals(p.getDomain()) ? "selected" : "" %>>Data Science</option>
                    <option value="Mobile App Development" <%= p != null && "Mobile App Development".equals(p.getDomain()) ? "selected" : "" %>>Mobile App Development</option>
                </select>
            </div>

            <!-- Description -->
            <div class="floating-label-group mb-4">
                <textarea class="form-control" id="description" name="description" rows="5" required placeholder=" "><%= p != null ? p.getDescription() : "" %></textarea>
                <label class="floating-label">Project Description</label>
            </div>

            <!-- Tech Stack -->
            <div class="floating-label-group mb-4">
                <input type="text" class="form-control" id="techstack" name="techstack" required placeholder=" "
                       value="<%= p != null ? p.getTechStack() : "" %>">
                <label class="floating-label">Technology Stack</label>
            </div>

            <!-- Submit -->
            <div class="d-grid gap-2 mt-4">
                <button type="submit" class="btn submit-btn">
    <i class="fas fa-paper-plane me-2"></i>
    <%= mode != null && mode.equals("submitted") ? "Update Project" : "Submit Project" %>
</button>
            </div>
        </form>
    </div>

    <script>
        // Floating label JS init
        document.addEventListener('DOMContentLoaded', function () {
            document.querySelectorAll('.form-control').forEach(input => {
                if (input.value.trim() !== "") {
                    const label = input.nextElementSibling;
                    if (label && label.classList.contains('floating-label')) {
                        label.style.top = '-10px';
                        label.style.fontSize = '0.8rem';
                        label.style.color = 'var(--primary)';
                    }
                }
            });
        });
    </script>
</body>
</html>
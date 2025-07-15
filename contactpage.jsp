<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us</title>
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1e40af;
            --accent-color: #3b82f6;
            --text-color: #333;
            --light-bg: #f8fafc;
            --border-color: #e2e8f0;
            --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --error-color: #dc2626;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            max-width: 600px;
            margin: 0 auto;
            padding: 2rem;
            background-color: var(--light-bg);
        }
        
        h2 {
            color: var(--secondary-color);
            text-align: center;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--border-color);
            font-size: 2rem;
        }
        
        .contact-form {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--secondary-color);
        }
        
        input, textarea, select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: 6px;
            font-family: inherit;
            font-size: 1rem;
            transition: border-color 0.2s;
        }
        
        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.1);
        }
        
        textarea {
            min-height: 120px;
            resize: vertical;
        }
        
        .btn-submit {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            font-size: 1rem;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
            transition: background-color 0.2s;
            display: block;
            width: 100%;
        }
        
        .btn-submit:hover {
            background-color: var(--secondary-color);
        }
        
        .form-footer {
            text-align: center;
            margin-top: 1.5rem;
            color: #666;
            font-size: 0.9rem;
        }
        
        @media (max-width: 600px) {
            body {
                padding: 1rem;
            }
            
            .contact-form {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <h2>Contact Us</h2>
    
    <form class="contact-form" method="post" action="Contactservlet">
        <div class="form-group">
            <label for="name">Full Name</label>
            <input type="text" id="name" name="name" required>
        </div>
        
        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" required>
        </div>
        
        <div class="form-group">
            <label for="subject">Subject</label>
            <select id="subject" name="subject" required>
                <option value="" disabled selected>Select an option</option>
                <option value="technical">Technical Issue</option>
                <option value="account">Account Problem</option>
                <option value="feedback">Feedback/Suggestion</option>
                <option value="other">Other</option>
            </select>
        </div>
        
        <div class="form-group">
            <label for="message">Your Message</label>
            <textarea id="message" name="message" required></textarea>
        </div>
        
        <button type="submit" class="btn-submit">Submit</button>
        
        <div class="form-footer">
            We'll respond to your inquiry within 24-48 hours.
        </div>
    </form>
</body>
</html>
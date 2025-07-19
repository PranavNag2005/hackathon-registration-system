<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Event Timeline Management</title>
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --danger: #f72585;
            --light: #f8f9fa;
            --dark: #212529;
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            color: var(--dark);
            line-height: 1.6;
        }
        
        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        h1 {
            color: var(--primary);
            text-align: center;
            margin-bottom: 30px;
            font-weight: 600;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark);
        }
        
        input[type="text"],
        input[type="datetime-local"],
        select, textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border 0.3s;
        }
        
        input[type="text"]:focus,
        input[type="datetime-local"]:focus,
        select:focus, textarea:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.2);
        }
        
        .status-options {
            display: flex;
            gap: 20px;
            margin-top: 10px;
        }
        
        .status-option {
            flex: 1;
        }
        
        .status-option input {
            display: none;
        }
        
        .status-option label {
            display: block;
            padding: 15px;
            text-align: center;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
            background-color: #f1f3f5;
        }
        
        .status-option input:checked + label {
            color: white;
            font-weight: 600;
        }
        
        #upcoming:checked + label {
            background-color: #4cc9f0;
        }
        
        #ongoing:checked + label {
            background-color: #4361ee;
        }
        
        #completed:checked + label {
            background-color: #4895ef;
        }
        
        .btn-submit {
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 14px 28px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-weight: 600;
            transition: background-color 0.3s;
        }
        
        .btn-submit:hover {
            background-color: var(--secondary);
        }
        
        .timeline-preview {
            margin-top: 40px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }
        
        .timeline-item {
            display: flex;
            margin-bottom: 15px;
            align-items: center;
        }
        
        .timeline-date {
            font-weight: 600;
            min-width: 180px;
            color: var(--primary);
        }
        
        .timeline-status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            margin-left: 15px;
        }
        
        .status-upcoming {
            background-color: #e3f8ff;
            color: #0d96c4;
        }
        
        .status-ongoing {
            background-color: #e7ecff;
            color: #2d4feb;
        }
        
        .status-completed {
            background-color: #e8f4ff;
            color: #1a7fd9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Event Timeline Management</h1>
        
        <form action="Eventservlet" method="POST">
            <div class="form-group">
                <label for="eventName">Event Name</label>
                <input type="text" id="eventName" name="eventName" required>
            </div>
            
            <div class="form-group">
                <label for="eventCode">Event ID/Code</label>
                <input type="text" id="eventCode" name="eventCode">
            </div>
            
            <div class="form-group">
                <label for="regDeadline">Registration Deadline</label>
                <input type="datetime-local" id="regDeadline" name="regDeadline" required>
            </div>
            
            <div class="form-group">
                <label for="subDeadline">Submission Deadline</label>
                <input type="datetime-local" id="subDeadline" name="subDeadline" required>
            </div>
            
            <div class="form-group">
                <label for="resultDate">Result Declaration Date</label>
                <input type="datetime-local" id="resultDate" name="resultDate" required>
            </div>
            
            <div class="form-group">
                <label>Current Status</label>
                <div class="status-options">
                    <div class="status-option">
                        <input type="radio" id="upcoming" name="status" value="upcoming" checked>
                        <label for="upcoming">Upcoming</label>
                    </div>
                    <div class="status-option">
                        <input type="radio" id="ongoing" name="status" value="ongoing">
                        <label for="ongoing">Ongoing</label>
                    </div>
                    <div class="status-option">
                        <input type="radio" id="completed" name="status" value="completed">
                        <label for="completed">Completed</label>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label for="notes">Additional Notes</label>
                <textarea id="notes" name="notes" rows="3"></textarea>
            </div>
            
            <div class="form-group">
                <label>
                    <input type="checkbox" name="sendReminders"> Send email reminders to participants
                </label>
            </div>
            
            <button type="submit" class="btn-submit">Save Event Timeline</button>
        </form>
        
        <div class="timeline-preview">
            <h3>Timeline Preview</h3>
            <div class="timeline-item">
                <span class="timeline-date">Registration Deadline:</span>
                <span id="preview-reg">Not set</span>
            </div>
            <div class="timeline-item">
                <span class="timeline-date">Submission Deadline:</span>
                <span id="preview-sub">Not set</span>
            </div>
            <div class="timeline-item">
                <span class="timeline-date">Result Declaration:</span>
                <span id="preview-result">Not set</span>
            </div>
            <div class="timeline-item">
                <span class="timeline-date">Current Status:</span>
                <span id="preview-status" class="status-upcoming">Upcoming</span>
            </div>
        </div>
    </div>

    <script>
        // Update preview in real-time
        document.getElementById('regDeadline').addEventListener('change', function() {
            if(this.value) {
                const date = new Date(this.value);
                document.getElementById('preview-reg').textContent = date.toLocaleString();
            }
        });
        
        document.getElementById('subDeadline').addEventListener('change', function() {
            if(this.value) {
                const date = new Date(this.value);
                document.getElementById('preview-sub').textContent = date.toLocaleString();
            }
        });
        
        document.getElementById('resultDate').addEventListener('change', function() {
            if(this.value) {
                const date = new Date(this.value);
                document.getElementById('preview-result').textContent = date.toLocaleString();
            }
        });
        
        document.querySelectorAll('input[name="status"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const statusElement = document.getElementById('preview-status');
                statusElement.textContent = this.value.charAt(0).toUpperCase() + this.value.slice(1);
                statusElement.className = 'timeline-status status-' + this.value;
            });
        });
    </script>
</body>
</html>
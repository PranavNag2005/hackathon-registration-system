<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>GitHub Repository Submission</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6C63FF;
            --secondary-color: #FF6584;
            --accent-color: #00BFA6;
            --dark-color: #2D3748;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #F7FAFC;
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 20px;
        }
        
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }
        
        .panels-wrapper {
            display: flex;
            gap: 30px;
            justify-content: center;
        }
        
        .panel {
            flex: 1;
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            max-width: 500px;
        }
        
        .panel:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.12);
        }
        
        .instructions-panel {
            border-left: 5px solid var(--accent-color);
        }
        
        .form-panel {
            border-left: 5px solid var(--accent-color);
        }
        
        .panel-title {
            color: var(--dark-color);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .step {
            display: flex;
            margin-bottom: 20px;
            align-items: flex-start;
            gap: 15px;
        }
        
        .step-number {
            background-color: var(--primary-color);
            color: white;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-weight: bold;
            font-size: 14px;
        }
        
        .example-url {
            background-color: #f8f9fa;
            padding: 12px;
            border-radius: 8px;
            font-family: monospace;
            margin-top: 15px;
            border-left: 3px solid var(--primary-color);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .github-btn {
            background-color: #24292E;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        
        .github-btn:hover {
            background-color: #1a1e22;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(36,41,46,0.2);
        }
        
        .btn-submit {
            background-color: var(--primary-color);
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 15px;
        }
        
        .btn-submit:hover {
            background-color: #5a52e0;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 99, 255, 0.3);
        }
        
        .form-control {
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #e1e4e8;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(108, 99, 255, 0.2);
        }
        
        hr {
            opacity: 0.2;
            margin: 25px 0;
        }
        
        @media (max-width: 768px) {
            .panels-wrapper {
                flex-direction: column;
                align-items: center;
            }
            
            .panel {
                width: 100%;
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="panels-wrapper">
            <!-- Instructions Panel -->
            <div class="panel instructions-panel">
                <h3 class="panel-title">
                    <i class="fas fa-info-circle" style="color: var(--accent-color);"></i>
                    How to get your GitHub URL
                </h3>
                
                <div class="step">
                    <div class="step-number">1</div>
                    <div>
                        <h5>Go to your repository</h5>
                        <p class="text-muted">Navigate to your project repository on GitHub.com</p>
                    </div>
                </div>
                
                <div class="step">
                    <div class="step-number">2</div>
                    <div>
                        <h5>Click the "Code" button</h5>
                        <p class="text-muted">Find the green "Code" button near the top of your repository</p>
                    </div>
                </div>
                
                <div class="step">
                    <div class="step-number">3</div>
                    <div>
                        <h5>Copy the HTTPS URL</h5>
                        <p class="text-muted">Make sure "HTTPS" is selected and copy the URL (ends with .git)</p>
                    </div>
                </div>
                
                <div class="example-url">
                    <i class="fas fa-link" style="color: var(--primary-xcolor);"></i>
                    https://github.com/username/repository.git
                </div>
                
                <a href="https://github.com" target="_blank" class="github-btn">
                    <i class="fab fa-github"></i> Click here to go to GitHub
                </a>
            </div>
            
            <!-- Form Panel -->
            <div class="panel form-panel">
                <h3 class="panel-title">
                    <i class="fab fa-github" style="color: var(--accent-color);"></i>
                    Submit Your Repository
                </h3>
                
                <form action="GitHubServlet" method="post">
                    <div class="mb-3">
                        <label for="githubUrl" class="form-label fw-bold">GitHub Repository URL</label>
                        <input type="url" class="form-control" id="githubUrl" name="githubUrl" 
                               placeholder="https://github.com/username/repository.git" required>
                        <div class="form-text">Make sure the repository is public or you've granted access</div>
                    </div>
                    
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-paper-plane"></i> Submit Repository
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submissions Closed | HackX 2025</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #2563eb;
            --secondary: #1d4ed8;
            --dark: #1e293b;
            --light: #f8fafc;
            --danger: #e74c3c;
            --gray: #95a5a6;
            --warning: #f59e0b;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f1f5f9;
            color: var(--dark);
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        header {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px 0;
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .logo i {
            margin-right: 10px;
            font-size: 28px;
        }

        .closed-container {
            text-align: center;
            background: white;
            padding: 50px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            width: 100%;
            margin: 40px 0;
        }

        .closed-icon {
            font-size: 80px;
            color: var(--danger);
            margin-bottom: 20px;
        }

        h1 {
            font-size: 36px;
            margin-bottom: 20px;
            color: var(--dark);
        }

        p {
            font-size: 18px;
            color: #64748b;
            margin-bottom: 20px;
        }

        .submission-types {
            text-align: left;
            margin: 30px auto;
            max-width: 500px;
        }

        .submission-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            padding: 15px;
            background: #f8fafc;
            border-radius: 8px;
            border-left: 4px solid var(--danger);
        }

        .submission-icon {
            font-size: 24px;
            color: var(--danger);
            margin-right: 15px;
            min-width: 30px;
            text-align: center;
        }

        .btn {
            display: inline-block;
            padding: 12px 30px;
            background: var(--primary);
            color: white;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
            font-size: 16px;
            margin: 10px 5px;
        }

        .btn:hover {
            background: var(--secondary);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(37, 99, 235, 0.3);
        }

        .btn-outline {
            background: white;
            color: var(--primary);
            border: 2px solid var(--primary);
        }

        .btn-outline:hover {
            background: rgba(37, 99, 235, 0.1);
        }

        .btn-warning {
            background: var(--warning);
            color: white;
        }

        .btn-warning:hover {
            background: #e67e22;
        }

        footer {
            background-color: var(--dark);
            color: white;
            text-align: center;
            padding: 20px 0;
            margin-top: auto;
        }

        .notice-box {
            background: #fff9e6;
            border-left: 4px solid var(--warning);
            padding: 15px;
            margin: 25px 0;
            text-align: left;
            border-radius: 0 8px 8px 0;
        }

        @media (max-width: 768px) {
            .closed-container {
                padding: 30px 20px;
            }
            
            h1 {
                font-size: 28px;
            }
            
            .closed-icon {
                font-size: 60px;
            }
            
            .submission-item {
                flex-direction: column;
                text-align: center;
                padding: 15px 10px;
            }
            
            .submission-icon {
                margin-right: 0;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="logo"><i class="fas fa-code"></i>HackX 2025</div>
        </div>
    </header>

    <div class="container">
        <div class="closed-container">
            <div class="closed-icon">
                <i class="fas fa-ban"></i>
            </div>
            <h1>All Submissions Are Closed</h1>
            <p>The submission period for HackX 2025 has ended as of <strong>July 14, 2025 at 11:59 PM</strong>.</p>
            
            <div class="notice-box">
                <i class="fas fa-exclamation-circle" style="color: var(--warning); margin-right: 8px;"></i>
                No further submissions or modifications can be accepted at this time.
            </div>

            <div class="submission-types">
                <div class="submission-item">
                    <div class="submission-icon"><i class="fab fa-github"></i></div>
                    <div>GitHub Repository Links</div>
                </div>
                <div class="submission-item">
                    <div class="submission-icon"><i class="fas fa-file-word"></i></div>
                    <div>Project Documentation (Word/PDF)</div>
                </div>
                <div class="submission-item">
                    <div class="submission-icon"><i class="fas fa-project-diagram"></i></div>
                    <div>Project Data & Details</div>
                </div>
                <div class="submission-item">
                    <div class="submission-icon"><i class="fas fa-video"></i></div>
                    <div>Demo Videos</div>
                </div>
            </div>

            <p>Judging is now in progress. Winners will be announced on our website and social media channels.</p>
            
            <div style="margin-top: 30px;">
                <a href="welcome.jsp" class="btn">Return to Home</a>
                <a href="#results" class="btn btn-warning">View Results Timeline</a>
                <a href="welcome.jsp#contact" class="btn btn-outline">Contact Organizers</a>
            </div>
        </div>
    </div>

    <footer>
        <div class="container">
            <p>© 2025 HackX. All rights reserved.</p>
            
        </div>
        <p style="margin-top: 10px; font-size: 14px;">Made with <i class="fas fa-heart" style="color: #e74c3c;"></i> by the HackX Team</p>
    </footer>
</body>
</html>
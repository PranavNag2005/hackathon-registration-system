<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Closed | HackX 2025</title>
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
            max-width: 600px;
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
            margin-bottom: 30px;
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

        footer {
            background-color: var(--dark);
            color: white;
            text-align: center;
            padding: 20px 0;
            margin-top: auto;
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
                <i class="fas fa-calendar-times"></i>
            </div>
            <h1>Registration Closed</h1>
            <p>We're sorry, but registration for HackX 2025 has now closed. The deadline for submissions was <strong>July 14, 2025</strong>.</p>
            <p>Thank you to everyone who registered! We're excited to see what you'll create during the hackathon.</p>
            
            <div style="margin-top: 30px;">
                <a href="index.html" class="btn">Return to Home</a>
                <a href="index.html#contact" class="btn btn-outline">Contact Us</a>
            </div>
        </div>
    </div>

    <footer>
        <div class="container">
            <p>© 2025 HackX. All rights reserved.</p>
            <br>
            <p style="margin-top: 10px; font-size: 14px;">Made with <i class="fas fa-heart" style="color: #e74c3c;"></i> by the HackX Team</p>
        </div>
    </footer>
</body>
</html>
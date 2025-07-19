<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>OTP Verification</title>
    
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: linear-gradient(135deg, #1a2a6c, #b21f1f, #fdbb2d);
    background-size: 400% 400%;
    animation: gradientBG 15s ease infinite;
        }
        
        .otp-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }
        
        h2 {
            color: #333;
            margin-bottom: 20px;
        }
        
        p {
            color: #666;
            margin-bottom: 25px;
            font-size: 14px;
        }
        
        .otp-inputs {
            display: flex;
            justify-content: space-between;
            margin-bottom: 25px;
        }
        
        .otp-input {
            width: 45px;
            height: 45px;
            text-align: center;
            font-size: 18px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .otp-input:focus {
            outline: none;
            border-color: #4CAF50;
        }
        
        .verify-btn {
        background: linear-gradient(to right, #1a2a6c, #b21f1f);
    color: white;
            
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 20px;
            transition: background-color 0.3s;
        }
        
        .verify-btn:hover {
            background-color: #45a049;
        }
        
        .resend {
            margin-top: 20px;
            font-size: 14px;
        }
        
        .resend a {
            color: #4CAF50;
            text-decoration: none;
        }
        
        .resend a:hover {
            text-decoration: underline;
        }
        
        .error {
            color: #f44336;
            font-size: 14px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="otp-container">
        <h2>OTP Verification</h2>
        <p>We've sent a 6-digit verification code to <%= request.getParameter("email") != null ? request.getParameter("email") : "your email" %></p>
        
        <% if (request.getParameter("error") != null) { %>
            <div class="error">Invalid OTP. Please try again.</div>
        <% } %>
        
        <form id="otpForm" action="Verifyotpservlet" method="post">
            <div class="otp-inputs">
                <input type="text" name="otp1" class="otp-input" maxlength="1" pattern="[0-9]" required>
                <input type="text" name="otp2" class="otp-input" maxlength="1" pattern="[0-9]" required>
                <input type="text" name="otp3" class="otp-input" maxlength="1" pattern="[0-9]" required>
                <input type="text" name="otp4" class="otp-input" maxlength="1" pattern="[0-9]" required>
                <input type="text" name="otp5" class="otp-input" maxlength="1" pattern="[0-9]" required>
                <input type="text" name="otp6" class="otp-input" maxlength="1" pattern="[0-9]" required>
            </div>
            
            <input type="hidden" name="email" value="<%= request.getParameter("email") %>">
            <button type="submit" class="verify-btn">Verify</button>
        </form>
        <div class="resend">
    Didn't receive code? <a id="resendLink" href="Otpservlet?email=<%= session.getAttribute("email") %>" style="pointer-events: none; color: gray;">Resend</a> <span id="timer">59</span>
</div>
        
        <%String error=request.getParameter("invalidotp");
    if(error!=null && error.equals("0")){%>
    <p style="color:red;text-align:center;";>Invalid OTP</p>
    <%} %>
    </div>

    <script>
        // Auto-focus the first input when the page loads
        document.addEventListener('DOMContentLoaded', function() {
            const otpInputs = document.querySelectorAll('.otp-input');
            if (otpInputs.length > 0) {
                otpInputs[0].focus();
            }
            
            // Auto-tab between OTP inputs
            otpInputs.forEach((input, index) => {
                input.addEventListener('input', (e) => {
                    if (e.target.value.length === 1) {
                        if (index < otpInputs.length - 1) {
                            otpInputs[index + 1].focus();
                        } else {
                            // If it's the last input, focus stays there
                            e.target.blur(); // Optional: remove focus from last input
                        }
                    }
                });
                
                input.addEventListener('keydown', (e) => {
                    if (e.key === 'Backspace' && e.target.value.length === 0) {
                        if (index > 0) {
                            otpInputs[index - 1].focus();
                        }
                    }
                    
                    // Allow only numeric input
                    if (e.key.length === 1 && !/[0-9]/.test(e.key)) {
                        e.preventDefault();
                    }
                });
                
                // Paste OTP from clipboard
                input.addEventListener('paste', (e) => {
                    e.preventDefault();
                    const pasteData = e.clipboardData.getData('text');
                    if (/^\d{6}$/.test(pasteData)) {
                        pasteData.split('').forEach((char, i) => {
                            if (i < otpInputs.length) {
                                otpInputs[i].value = char;
                            }
                        });
                        if (otpInputs.length > 5) {
                            otpInputs[5].focus();
                        }
                    }
                });
            });
        });
    </script>
    <script>
    let seconds = 59;
    const timerEl = document.getElementById('timer');
    const resendLink = document.getElementById('resendLink');

    const countdown = setInterval(() => {
        seconds--;
        timerEl.textContent = seconds;

        if (seconds <= 0) {
            clearInterval(countdown);
            resendLink.style.pointerEvents = "auto"; // enable link
            resendLink.style.color = "#2E86C1";      // style it back to active
           
            timerEl.style.display = "none";// update countdown text
        }
    }, 1000);
</script>
</body>
</html>
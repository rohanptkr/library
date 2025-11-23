<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register Member - Library System</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script>
        function validateForm() {
            var phone = document.getElementById('phone').value;
            var aadhar = document.getElementById('aadhar').value;
            
            // Phone validation: exactly 10 digits
            var phoneRegex = /^[0-9]{10}$/;
            if (!phoneRegex.test(phone)) {
                alert('Please enter exactly 10-digit phone number');
                return false;
            }
            
            // Aadhar validation: exactly 12 digits
            var aadharRegex = /^[0-9]{12}$/;
            if (!aadharRegex.test(aadhar)) {
                alert('Please enter exactly 12-digit Aadhar number');
                return false;
            }
            
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <header>
            <h1>Register New Member</h1>
            <nav>
                <ul>
                    <li><a href="admin-dashboard.jsp">Dashboard</a></li>
                    <li><a href="members?action=new" class="active">Register Member</a></li>
                    <li><a href="members?action=renew">Renew Membership</a></li>
                    <li><a href="members?action=active">View Active Members</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <div class="form-container">
                <form action="members" method="post" onsubmit="return validateForm()">
                    <input type="hidden" name="action" value="register">

                    <div class="form-group">
                        <label for="name">Full Name:</label>
                        <input type="text" id="name" name="name" required placeholder="Enter member's full name">
                    </div>

                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required placeholder="Enter email address">
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone:</label>
                        <input type="tel" id="phone" name="phone" required
                               pattern="[0-9]{10}" 
                               title="Please enter exactly 10-digit phone number"
                               placeholder="Enter 10-digit phone number">
                    </div>

                    <div class="form-group">
                        <label for="aadhar">Aadhar Card Number:</label>
                        <input type="text" id="aadhar" name="aadhar" required 
                               pattern="[0-9]{12}" 
                               title="Please enter 12-digit Aadhar number"
                               placeholder="Enter 12-digit Aadhar number">
                    </div>

                    <div class="form-group">
                        <label for="duration">Membership Duration (months):</label>
                        <select id="duration" name="duration" required>
                            <option value="1">1 Month</option>
                            <option value="3">3 Months</option>
                            <option value="6">6 Months</option>
                            <option value="12">12 Months</option>
                        </select>
                    </div>

                    <button type="submit" class="btn">Register Member</button>
                </form>

                <% if (request.getAttribute("message") != null) { %>
                    <div class="success-message">
                        <%= request.getAttribute("message") %>
                    </div>
                <% } %>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>
            </div>
        </main>
    </div>
</body>
</html>

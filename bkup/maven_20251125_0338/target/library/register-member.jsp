<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register Member - Library System</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        body {
            background-color: #000000;
            color: #ffffff;
        }
        .container {
            background-color: #000000;
        }
        .form-container {
            background: #1a1a1a;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #333;
            margin-bottom: 30px;
        }
        .member-details {
            background: #1a1a1a;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #333;
            margin-top: 20px;
        }
        .details-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            background: #000000;
        }
        .details-table th,
        .details-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #333;
            color: #ffffff;
        }
        .details-table th {
            background-color: #2d2d2d;
            font-weight: bold;
            color: #ffffff;
            width: 30%;
        }
        input, select {
            background-color: #2d2d2d;
            color: #ffffff;
            border: 1px solid #555;
        }
        input:focus, select:focus {
            background-color: #3d3d3d;
            color: #ffffff;
            border-color: #007bff;
        }
        input::placeholder {
            color: #999;
        }
        .btn {
            background-color: #007bff;
            color: white;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        nav ul {
            background-color: #1a1a1a;
        }
        nav ul li a {
            color: #ffffff;
        }
        nav ul li a:hover, nav ul li a.active {
            background-color: #007bff;
            color: #ffffff;
        }
        .success-message {
            background-color: #155724;
            color: #d4edda;
            border: 1px solid #c3e6cb;
            padding: 15px;
            border-radius: 4px;
            margin: 15px 0;
        }
        .error-message {
            background-color: #721c24;
            color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 15px;
            border-radius: 4px;
            margin: 15px 0;
        }
        .section-title {
            color: #ffffff;
            border-bottom: 2px solid #007bff;
            padding-bottom: 5px;
            margin-bottom: 15px;
        }
    </style>
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
            <h1 style="color: #ffffff;">Register New Member</h1>
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
                        <label for="name" style="color: #ffffff;">Full Name:</label>
                        <input type="text" id="name" name="name" required placeholder="Enter member's full name">
                    </div>
                    
                    <div class="form-group">
                        <label for="email" style="color: #ffffff;">Email:</label>
                        <input type="email" id="email" name="email" required placeholder="Enter email address">
                    </div>
                    
                    <div class="form-group">
                        <label for="phone" style="color: #ffffff;">Phone:</label>
                        <input type="tel" id="phone" name="phone" required
                               pattern="[0-9]{10}" 
                               title="Please enter exactly 10-digit phone number"
                               placeholder="Enter 10-digit phone number">
                    </div>
                    
                    <div class="form-group">
                        <label for="aadhar" style="color: #ffffff;">Aadhar Card Number:</label>
                        <input type="text" id="aadhar" name="aadhar" required 
                               pattern="[0-9]{12}" 
                               title="Please enter 12-digit Aadhar number"
                               placeholder="Enter 12-digit Aadhar number">
                    </div>
                    
                    <div class="form-group">
                        <label for="duration" style="color: #ffffff;">Membership Duration (months):</label>
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

            <!-- Member Details Section - Show after successful registration -->
            <% if (request.getAttribute("message") != null && request.getAttribute("registeredMember") != null) { 
                com.library.model.Member member = (com.library.model.Member) request.getAttribute("registeredMember");
            %>
                <div class="member-details">
                    <h2 class="section-title">Registered Member Details</h2>
                    <table class="details-table">
                        <tr>
                            <th>Member ID:</th>
                            <td><%= member.getMemberId() %></td>
                        </tr>
                        <tr>
                            <th>Full Name:</th>
                            <td><%= member.getName() %></td>
                        </tr>
                        <tr>
                            <th>Email:</th>
                            <td><%= member.getEmail() %></td>
                        </tr>
                        <tr>
                            <th>Phone:</th>
                            <td><%= member.getPhone() %></td>
                        </tr>
                        <tr>
                            <th>Aadhar Card Number:</th>
                            <td><%= member.getAadhar() %></td>
                        </tr>
                        <tr>
                            <th>Registration Date:</th>
                            <td><%= member.getRegistrationDate() %></td>
                        </tr>
                        <tr>
                            <th>Membership Expiry Date:</th>
                            <td><%= member.getExpiryDate() %></td>
                        </tr>
                        <tr>
                            <th>Status:</th>
                            <td><%= member.getStatus() %></td>
                        </tr>
                    </table>
                </div>
            <% } %>
        </main>
    </div>
</body>
</html>

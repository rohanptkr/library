<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register Member</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
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
                <form action="members" method="post">
                    <input type="hidden" name="action" value="register">
                    
                    <div class="form-group">
                        <label for="memberId">Member ID:</label>
                        <input type="text" id="memberId" name="memberId" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="name">Full Name:</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="phone">Phone:</label>
                        <input type="tel" id="phone" name="phone">
                    </div>
                    
                    <div class="form-group">
                        <label for="duration">Membership Duration (months):</label>
                        <select id="duration" name="duration" required>
                            <option value="1">1 Month</option>
                            <option value="3">3 Months</option>
                            <option value="6">6 Months</option>
                            <option value="12" selected>12 Months</option>
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

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Renew Membership - Library System</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Renew Membership</h1>
            <nav>
                <ul>
                    <li><a href="admin-dashboard.jsp">Dashboard</a></li>
                    <li><a href="members?action=new">Register Member</a></li>
                    <li><a href="members?action=renew" class="active">Renew Membership</a></li>
                    <li><a href="members?action=active">View Active Members</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <div class="form-container">
                <h2>Renew Member Subscription</h2>
                <form action="members" method="post">
                    <input type="hidden" name="action" value="renew">
                    
                    <div class="form-group">
                        <label for="memberId">Member ID:</label>
                        <input type="text" id="memberId" name="memberId" required placeholder="Enter Member ID">
                    </div>
                    
                    <div class="form-group">
                        <label for="duration">Extension Duration (months):</label>
                        <select id="duration" name="duration" required>
                            <option value="1">1 Month</option>
                            <option value="3">3 Months</option>
                            <option value="6">6 Months</option>
                            <option value="12">12 Months</option>
                        </select>
                    </div>
                    
                    <button type="submit" class="btn">Renew Membership</button>
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

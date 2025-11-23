<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Renew Membership - Library System</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        body {
            background-image: url('images/background.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            position: relative;
        }
        
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: -1;
        }
        
        .desktop-tabs {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        
        .desktop-tab {
            background: linear-gradient(135deg, #34495e 0%, #2c3e50 100%);
            padding: 12px 20px;
            border-radius: 8px;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.2);
            font-weight: 500;
        }
        
        .desktop-tab:hover {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            transform: translateY(-2px);
        }
        
        .desktop-tab.active {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>🔄 Renew Membership</h1>
            <nav>
                <ul>
                    <li><a href="admin-dashboard.jsp">🏠 Dashboard</a></li>
                    <li><a href="members?action=new">👤 Register Member</a></li>
                    <li><a href="members?action=renew" class="active">🔄 Renew Membership</a></li>
                    <li><a href="members?action=active">📋 View Active Members</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <div class="desktop-tabs">
                <a href="admin-dashboard.jsp" class="desktop-tab">🏠 Dashboard</a>
                <a href="members?action=new" class="desktop-tab">👤 Register Member</a>
                <a href="members?action=renew" class="desktop-tab active">🔄 Renew Membership</a>
                <a href="members?action=active" class="desktop-tab">📋 View Members</a>
            </div>
            
            <div class="form-container">
                <form action="members" method="post">
                    <input type="hidden" name="action" value="renew">
                    
                    <div class="form-group">
                        <label for="memberId">🆔 Member ID:</label>
                        <input type="text" id="memberId" name="memberId" required placeholder="Enter member ID to renew">
                    </div>
                    
                    <div class="form-group">
                        <label for="duration">⏰ Renewal Duration:</label>
                        <select id="duration" name="duration" required>
                            <option value="1">1 Month</option>
                            <option value="3">3 Months</option>
                            <option value="6">6 Months</option>
                            <option value="12" selected>12 Months</option>
                        </select>
                    </div>
                    
                    <button type="submit" class="btn">🔄 Renew Membership</button>
                </form>
                
                <% if (request.getAttribute("message") != null) { %>
                    <div class="success-message">
                        ✅ <%= request.getAttribute("message") %>
                    </div>
                <% } %>
                
                <% if (request.getAttribute("error") != null) { %>
                    <div class="error-message">
                        ❌ <%= request.getAttribute("error") %>
                    </div>
                <% } %>
            </div>
        </main>
    </div>
</body>
</html>

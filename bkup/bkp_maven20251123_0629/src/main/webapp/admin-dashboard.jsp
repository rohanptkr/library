<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Management System</title>
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
            padding: 15px 25px;
            border-radius: 8px;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.2);
            font-weight: 500;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }
        
        .desktop-tab:hover {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(52, 152, 219, 0.4);
        }
        
        .desktop-tab.active {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            box-shadow: 0 6px 18px rgba(52, 152, 219, 0.6);
        }
        
        .welcome-section {
            text-align: center;
            margin-bottom: 40px;
            padding: 30px;
            background: linear-gradient(135deg, rgba(44, 62, 80, 0.9) 0%, rgba(52, 73, 94, 0.9) 100%);
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .welcome-section h2 {
            color: #ecf0f1;
            margin-bottom: 15px;
            font-size: 2rem;
        }
        
        .welcome-section p {
            color: #bdc3c7;
            font-size: 1.1rem;
            max-width: 600px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>📚 Library Management System</h1>
            <nav>
                <ul>
                    <li><a href="admin-dashboard.jsp" class="active">🏠 Dashboard</a></li>
                    <li><a href="members?action=new">👤 Register Member</a></li>
                    <li><a href="members?action=renew">🔄 Renew Membership</a></li>
                    <li><a href="members?action=active">📋 View Active Members</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <div class="welcome-section">
                <h2>Welcome to Library Admin Portal</h2>
                <p>Manage your library members efficiently with our comprehensive dashboard</p>
            </div>
            
            <div class="desktop-tabs">
                <a href="members?action=new" class="desktop-tab">➕ Register New Member</a>
                <a href="members?action=renew" class="desktop-tab">🔄 Renew Membership</a>
                <a href="members?action=active" class="desktop-tab">👥 View Active Members</a>
            </div>
            
            <div class="dashboard-cards">
                <div class="card">
                    <h3>👤 Register New Member</h3>
                    <p>Add new members to the library system with complete details and membership duration</p>
                    <a href="members?action=new" class="btn">Register Member</a>
                </div>
                
                <div class="card">
                    <h3>🔄 Renew Membership</h3>
                    <p>Extend existing member subscriptions and manage membership expiry dates</p>
                    <a href="members?action=renew" class="btn">Renew Membership</a>
                </div>
                
                <div class="card">
                    <h3>📋 Active Members</h3>
                    <p>View all currently active members with their details and membership status</p>
                    <a href="members?action=active" class="btn">View Members</a>
                </div>
            </div>
        </main>
    </div>
</body>
</html>

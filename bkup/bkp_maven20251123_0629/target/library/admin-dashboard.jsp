<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Library Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        body {
            background-image: url('images/background.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        
        .container {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.3);
            margin: 20px auto;
            padding: 20px;
        }
        
        .dashboard-cards .card {
            background-color: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Library Management System</h1>
            <nav>
                <ul>
                    <li><a href="admin-dashboard.jsp" class="active">Dashboard</a></li>
                    <li><a href="members?action=new">Register Member</a></li>
                    <li><a href="members?action=renew">Renew Membership</a></li>
                    <li><a href="members?action=active">View Active Members</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <div class="dashboard-cards">
                <div class="card">
                    <h3>Register New Member</h3>
                    <p>Add new members to the library system</p>
                    <a href="members?action=new" class="btn">Register</a>
                </div>
                
                <div class="card">
                    <h3>Renew Membership</h3>
                    <p>Extend existing member subscriptions</p>
                    <a href="members?action=renew" class="btn">Renew</a>
                </div>
                
                <div class="card">
                    <h3>Active Members</h3>
                    <p>View all currently active members</p>
                    <a href="members?action=active" class="btn">View</a>
                </div>
            </div>
        </main>
    </div>
</body>
</html>

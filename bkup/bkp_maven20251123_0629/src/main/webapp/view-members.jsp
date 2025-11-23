<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Active Members - Library System</title>
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
        
        .members-count {
            background: linear-gradient(135deg, #27ae60 0%, #2ecc71 100%);
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 600;
            box-shadow: 0 4px 12px rgba(39, 174, 96, 0.4);
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>📋 Active Members</h1>
            <nav>
                <ul>
                    <li><a href="admin-dashboard.jsp">🏠 Dashboard</a></li>
                    <li><a href="members?action=new">👤 Register Member</a></li>
                    <li><a href="members?action=renew">🔄 Renew Membership</a></li>
                    <li><a href="members?action=active" class="active">📋 View Active Members</a></li>
                </ul>
            </nav>
        </header>
        
        <main>
            <div class="desktop-tabs">
                <a href="admin-dashboard.jsp" class="desktop-tab">🏠 Dashboard</a>
                <a href="members?action=new" class="desktop-tab">👤 Register Member</a>
                <a href="members?action=renew" class="desktop-tab">🔄 Renew Membership</a>
                <a href="members?action=active" class="desktop-tab active">📋 View Members</a>
            </div>
            
            <div class="members-count">
                📊 Total Active Members: ${not empty members ? members.size() : 0}
            </div>
            
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>🆔 Member ID</th>
                            <th>👤 Name</th>
                            <th>📧 Email</th>
                            <th>📞 Phone</th>
                            <th>📅 Registration Date</th>
                            <th>⏰ Expiry Date</th>
                            <th>🔰 Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="member" items="${members}">
                            <tr>
                                <td>${member.memberId}</td>
                                <td>${member.name}</td>
                                <td>${member.email}</td>
                                <td>${member.phone}</td>
                                <td>${member.registrationDate}</td>
                                <td>${member.expiryDate}</td>
                                <td><span class="status-active">${member.status}</span></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <c:if test="${empty members}">
                    <div class="no-data">
                        📭 No active members found. <a href="members?action=new" style="color: #3498db;">Register a new member</a>
                    </div>
                </c:if>
            </div>
        </main>
    </div>
</body>
</html>

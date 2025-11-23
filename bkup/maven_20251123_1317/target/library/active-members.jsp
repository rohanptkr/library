<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.library.model.Member" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Active Members - Library System</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        body {
            background-color: #000000;
            color: #ffffff;
        }
        .container {
            background-color: #000000;
        }
        .members-list {
            background: #1a1a1a;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: #000000;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #333;
            color: #ffffff;
        }
        th {
            background-color: #2d2d2d;
            font-weight: bold;
            color: #ffffff;
        }
        tr:hover {
            background-color: #2d2d2d;
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
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1 style="color: #ffffff;">Active Members</h1>
            <nav>
                <ul>
                    <li><a href="admin-dashboard.jsp">Dashboard</a></li>
                    <li><a href="members?action=new">Register Member</a></li>
                    <li><a href="members?action=renew">Renew Membership</a></li>
                    <li><a href="members?action=active" class="active">View Active Members</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <div class="members-list">
                <h2 style="color: #ffffff;">Currently Active Members</h2>
                
                <% 
                    List<Member> activeMembers = (List<Member>) request.getAttribute("activeMembers");
                    if (activeMembers == null || activeMembers.isEmpty()) {
                %>
                    <p style="color: #ffffff;">No active members found.</p>
                <% } else { %>
                    <table>
                        <thead>
                            <tr>
                                <th>Member ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Aadhar</th>
                                <th>Registration Date</th>
                                <th>Expiry Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Member member : activeMembers) { %>
                                <tr>
                                    <td><%= member.getMemberId() %></td>
                                    <td><%= member.getName() %></td>
                                    <td><%= member.getEmail() %></td>
                                    <td><%= member.getPhone() %></td>
                                    <td><%= member.getAadhar() %></td>
                                    <td><%= member.getRegistrationDate() %></td>
                                    <td><%= member.getExpiryDate() %></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } %>
            </div>
        </main>
    </div>
</body>
</html>

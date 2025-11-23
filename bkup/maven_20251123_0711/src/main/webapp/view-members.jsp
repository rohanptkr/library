<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Active Members</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>Active Members</h1>
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
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Member ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Registration Date</th>
                            <th>Expiry Date</th>
                            <th>Status</th>
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
                    <div class="no-data">No active members found.</div>
                </c:if>
            </div>
        </main>
    </div>
</body>
</html>

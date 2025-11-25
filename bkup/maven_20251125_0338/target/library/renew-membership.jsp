<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.library.model.Member" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Renew Membership - Library System</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        body {
            background-color: #000000;
            color: #ffffff;
        }
        .container {
            background-color: #000000;
        }
        .search-section {
            margin-bottom: 30px;
            padding: 20px;
            background: #1a1a1a;
            border-radius: 8px;
            border: 1px solid #333;
        }
        .search-form {
            display: flex;
            gap: 10px;
            align-items: end;
        }
        .search-form .form-group {
            flex: 1;
            margin-bottom: 0;
        }
        .form-container {
            background: #1a1a1a;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #333;
            margin-bottom: 30px;
        }
        .members-section {
            background: #1a1a1a;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #333;
        }
        .members-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: #000000;
        }
        .members-table th,
        .members-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #333;
            color: #ffffff;
        }
        .members-table th {
            background-color: #2d2d2d;
            font-weight: bold;
            color: #ffffff;
        }
        .members-table tr:hover {
            background-color: #2d2d2d;
        }
        .renew-btn {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }
        .renew-btn:hover {
            background-color: #218838;
        }
        .section-title {
            margin-top: 30px;
            margin-bottom: 15px;
            color: #ffffff;
            border-bottom: 2px solid #007bff;
            padding-bottom: 5px;
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
            padding: 10px;
            border-radius: 4px;
            margin: 10px 0;
        }
        .error-message {
            background-color: #721c24;
            color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            border-radius: 4px;
            margin: 10px 0;
        }
        .search-info {
            background-color: #004085;
            color: #cce7ff;
            border: 1px solid #b3d7ff;
            padding: 10px;
            border-radius: 4px;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1 style="color: #ffffff;">Renew Membership</h1>
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
            <!-- Search Section -->
            <div class="search-section">
                <h2 style="color: #ffffff;">Search Member</h2>
                <form class="search-form" action="members" method="get">
                    <input type="hidden" name="action" value="search">
                    <div class="form-group">
                        <label for="searchQuery" style="color: #ffffff;">Search by Name, Email, Phone or Member ID:</label>
                        <input type="text" id="searchQuery" name="searchQuery" 
                               placeholder="Enter name, email, phone or member ID" 
                               style="width: 100%;"
                               value="<%= request.getAttribute("searchQuery") != null ? request.getAttribute("searchQuery") : "" %>">
                    </div>
                    <button type="submit" class="btn">Search Member</button>
                </form>
            </div>

            <!-- Renew Form Section -->
            <div class="form-container">
                <h2 style="color: #ffffff;">Renew Member Subscription</h2>
                <form action="members" method="post">
                    <input type="hidden" name="action" value="renew">
                    
                    <div class="form-group">
                        <label for="memberId" style="color: #ffffff;">Member ID:</label>
                        <input type="text" id="memberId" name="memberId" required 
                               placeholder="Enter Member ID or select from list below">
                    </div>
                    
                    <div class="form-group">
                        <label for="duration" style="color: #ffffff;">Extension Duration (months):</label>
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

            <!-- Active Members List -->
            <div class="members-section">
                <h2 class="section-title">
                    <% if (request.getAttribute("searchQuery") != null) { %>
                        Search Results
                    <% } else { %>
                        Active Members
                    <% } %>
                </h2>
                
                <% if (request.getAttribute("searchQuery") != null && request.getAttribute("message") != null) { %>
                    <div class="search-info">
                        <%= request.getAttribute("message") %>
                    </div>
                <% } %>
                
                <% 
                    List<Member> activeMembers = (List<Member>) request.getAttribute("activeMembers");
                    if (activeMembers == null || activeMembers.isEmpty()) {
                %>
                    <p style="color: #ffffff;">No members found.</p>
                <% } else { %>
                    <table class="members-table">
                        <thead>
                            <tr>
                                <th>Member ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Registration Date</th>
                                <th>Expiry Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Member member : activeMembers) { %>
                                <tr>
                                    <td><%= member.getMemberId() %></td>
                                    <td><%= member.getName() %></td>
                                    <td><%= member.getEmail() %></td>
                                    <td><%= member.getPhone() %></td>
                                    <td><%= member.getRegistrationDate() %></td>
                                    <td><%= member.getExpiryDate() %></td>
                                    <td>
                                        <button class="renew-btn" 
                                                onclick="selectMember('<%= member.getMemberId() %>')">
                                            Select
                                        </button>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } %>
            </div>
        </main>
    </div>

    <script>
        // Auto-fill member ID when Select button is clicked
        function selectMember(memberId) {
            document.getElementById('memberId').value = memberId;
            // Scroll to the renew form
            document.querySelector('.form-container').scrollIntoView({ behavior: 'smooth' });
        }
    </script>
</body>
</html>

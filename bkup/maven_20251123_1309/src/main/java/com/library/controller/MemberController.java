package com.library.controller;

import com.library.dao.MemberDAO;
import com.library.model.Member;
import com.library.util.DatabaseConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/members")
public class MemberController extends HttpServlet {
    private MemberDAO memberDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            Connection connection = DatabaseConnection.getConnection();
            memberDAO = new MemberDAO(connection);
            System.out.println("MemberDAO initialized successfully");
        } catch (SQLException e) {
            System.err.println("Failed to initialize MemberDAO: " + e.getMessage());
            throw new ServletException("Failed to initialize database connection", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("Processing action: " + action);
        
        try {
            if ("new".equals(action)) {
                request.getRequestDispatcher("register-member.jsp").forward(request, response);
            } else if ("active".equals(action)) {
                // Get active members and forward to JSP
                List<Member> activeMembers = memberDAO.getAllActiveMembers();
                request.setAttribute("activeMembers", activeMembers);
                request.getRequestDispatcher("active-members.jsp").forward(request, response);
            } else if ("renew".equals(action)) {
                // Handle renew membership page - always load active members
                List<Member> activeMembers = memberDAO.getAllActiveMembers();
                request.setAttribute("activeMembers", activeMembers);
                request.getRequestDispatcher("renew-membership.jsp").forward(request, response);
            } else if ("search".equals(action)) {
                // Handle member search
                searchMembers(request, response);
            } else {
                // Default to registration page
                request.getRequestDispatcher("register-member.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("register-member.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("register".equals(action)) {
            registerMember(request, response);
        } else if ("renew".equals(action)) {
            renewMembership(request, response);
        }
    }
    
    private void searchMembers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("searchQuery");
        
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            // For now, we'll just show all active members and highlight matching ones
            // In a real application, you would implement actual search logic in MemberDAO
            List<Member> activeMembers = memberDAO.getAllActiveMembers();
            request.setAttribute("activeMembers", activeMembers);
            request.setAttribute("searchQuery", searchQuery);
            request.setAttribute("message", "Search functionality: Showing all active members. Search for '" + searchQuery + "'");
        } else {
            List<Member> activeMembers = memberDAO.getAllActiveMembers();
            request.setAttribute("activeMembers", activeMembers);
            request.setAttribute("error", "Please enter a search term");
        }
        
        request.getRequestDispatcher("renew-membership.jsp").forward(request, response);
    }
    
    private void registerMember(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String aadhar = request.getParameter("aadhar");
        String durationStr = request.getParameter("duration");
        
        // Server-side validation
        StringBuilder error = new StringBuilder();
        
        // Phone validation: exactly 10 digits
        if (phone == null || !phone.matches("\\d{10}")) {
            error.append("Phone number must be exactly 10 digits. ");
        } else if (memberDAO.isPhoneExists(phone)) {
            error.append("Phone number already registered. ");
        }
        
        // Aadhar validation: exactly 12 digits
        if (aadhar == null || !aadhar.matches("\\d{12}")) {
            error.append("Aadhar number must be exactly 12 digits. ");
        } else if (memberDAO.isAadharExists(aadhar)) {
            error.append("Aadhar number already registered. ");
        }
        
        // Email validation
        if (email == null || email.trim().isEmpty()) {
            error.append("Email is required. ");
        } else if (memberDAO.isEmailExists(email)) {
            error.append("Email already registered. ");
        }
        
        // Name validation
        if (name == null || name.trim().isEmpty()) {
            error.append("Name is required. ");
        }
        
        // If validation errors, return to form with error message
        if (error.length() > 0) {
            request.setAttribute("error", error.toString());
            request.getRequestDispatcher("register-member.jsp").forward(request, response);
            return;
        }
        
        try {
            int duration = Integer.parseInt(durationStr);
            LocalDate registrationDate = LocalDate.now();
            LocalDate expiryDate = registrationDate.plusMonths(duration);
            
            Member member = new Member(null, name, email, phone, aadhar, registrationDate, expiryDate, "ACTIVE");
            
            boolean success = memberDAO.addMember(member);
            
            if (success) {
                request.setAttribute("message", "Member registered successfully! Membership expires on: " + expiryDate);
            } else {
                request.setAttribute("error", "Failed to register member. Please try again.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid duration selected.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
        
        request.getRequestDispatcher("register-member.jsp").forward(request, response);
    }
    
    private void renewMembership(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String memberId = request.getParameter("memberId");
        String durationStr = request.getParameter("duration");
        
        try {
            int duration = Integer.parseInt(durationStr);
            boolean success = memberDAO.renewMembershipByMemberId(memberId, duration);
            
            if (success) {
                request.setAttribute("message", "Membership renewed successfully for " + duration + " months!");
            } else {
                request.setAttribute("error", "Failed to renew membership. Member ID not found.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid duration selected.");
        } catch (Exception e) {
            request.setAttribute("error", "Error renewing membership: " + e.getMessage());
        }
        
        // Reload active members and return to renew page
        List<Member> activeMembers = memberDAO.getAllActiveMembers();
        request.setAttribute("activeMembers", activeMembers);
        request.getRequestDispatcher("renew-membership.jsp").forward(request, response);
    }
    
    @Override
    public void destroy() {
        // Clean up resources if needed
    }
}

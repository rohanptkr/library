package com.library.controller;

import com.library.dao.MemberDAO;
import com.library.model.Member;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Date;
import java.util.Calendar;
import java.util.List;

@WebServlet("/members")
public class MemberController extends HttpServlet {
    private MemberDAO memberDAO;
    
    @Override
    public void init() {
        memberDAO = new MemberDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "renew":
                showRenewForm(request, response);
                break;
            case "active":
                listActiveMembers(request, response);
                break;
            case "all":
                listAllMembers(request, response);
                break;
            default:
                listActiveMembers(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("register".equals(action)) {
            registerMember(request, response);
        } else if ("renew".equals(action)) {
            renewMember(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/members");
        }
    }
    
    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/register-member.jsp");
        dispatcher.forward(request, response);
    }
    
    private void showRenewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/renew-member.jsp");
        dispatcher.forward(request, response);
    }
    
    private void listActiveMembers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Member> members = memberDAO.getActiveMembers();
        request.setAttribute("members", members);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view-members.jsp");
        dispatcher.forward(request, response);
    }
    
    private void listAllMembers(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Member> members = memberDAO.getAllMembers();
        request.setAttribute("members", members);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/view-members.jsp");
        dispatcher.forward(request, response);
    }
    
    private void registerMember(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        int duration = Integer.parseInt(request.getParameter("duration"));
        
        System.out.println("Registration attempt - Name: " + name + ", Email: " + email);
        
        // Validate input
        if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Name and Email are required fields.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/register-member.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        Date registrationDate = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(registrationDate);
        cal.add(Calendar.MONTH, duration);
        Date expiryDate = cal.getTime();
        
        // Create member with automatic ID generation
        Member member = new Member();
        member.setName(name.trim());
        member.setEmail(email.trim().toLowerCase());
        member.setPhone(phone != null ? phone.trim() : "");
        member.setRegistrationDate(registrationDate);
        member.setExpiryDate(expiryDate);
        member.setStatus("ACTIVE");
        
        boolean success = memberDAO.registerMember(member);
        if (success) {
            request.setAttribute("message", "Member registered successfully! Member ID: " + member.getMemberId());
        } else {
            request.setAttribute("error", "Failed to register member. Please try again or contact administrator.");
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/register-member.jsp");
        dispatcher.forward(request, response);
    }
    
    private void renewMember(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String memberId = request.getParameter("memberId");
        int duration = Integer.parseInt(request.getParameter("duration"));
        
        Member existingMember = memberDAO.getMemberById(memberId);
        if (existingMember == null) {
            request.setAttribute("error", "Member not found!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/renew-member.jsp");
            dispatcher.forward(request, response);
            return;
        }
        
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.MONTH, duration);
        java.util.Date newExpiryDateUtil = cal.getTime();
        
        // Convert java.util.Date to java.sql.Date
        java.sql.Date newExpiryDate = new java.sql.Date(newExpiryDateUtil.getTime());
        
        boolean success = memberDAO.renewMember(memberId, newExpiryDate);
        if (success) {
            request.setAttribute("message", "Membership renewed successfully!");
        } else {
            request.setAttribute("error", "Failed to renew membership.");
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/renew-member.jsp");
        dispatcher.forward(request, response);
    }
}

package com.library.dao;

import com.library.model.Member;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO {
    
    public boolean registerMember(Member member) {
        String sql = "INSERT INTO members (member_id, name, email, phone, registration_date, expiry_date, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, member.getMemberId());
            pstmt.setString(2, member.getName());
            pstmt.setString(3, member.getEmail());
            pstmt.setString(4, member.getPhone());
            
            // Convert java.util.Date to java.sql.Date
            java.sql.Date regDate = new java.sql.Date(member.getRegistrationDate().getTime());
            java.sql.Date expDate = new java.sql.Date(member.getExpiryDate().getTime());
            
            pstmt.setDate(5, regDate);
            pstmt.setDate(6, expDate);
            pstmt.setString(7, member.getStatus());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean renewMember(String memberId, java.sql.Date newExpiryDate) {
        String sql = "UPDATE members SET expiry_date = ?, status = 'ACTIVE' WHERE member_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setDate(1, newExpiryDate);
            pstmt.setString(2, memberId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Member> getActiveMembers() {
        List<Member> members = new ArrayList<>();
        String sql = "SELECT * FROM members WHERE status = 'ACTIVE' AND expiry_date >= CURDATE() ORDER BY expiry_date ASC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                Member member = new Member();
                member.setId(rs.getInt("id"));
                member.setMemberId(rs.getString("member_id"));
                member.setName(rs.getString("name"));
                member.setEmail(rs.getString("email"));
                member.setPhone(rs.getString("phone"));
                member.setRegistrationDate(rs.getDate("registration_date"));
                member.setExpiryDate(rs.getDate("expiry_date"));
                member.setStatus(rs.getString("status"));
                members.add(member);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return members;
    }
    
    public Member getMemberById(String memberId) {
        String sql = "SELECT * FROM members WHERE member_id = ?";
        Member member = null;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, memberId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                member = new Member();
                member.setId(rs.getInt("id"));
                member.setMemberId(rs.getString("member_id"));
                member.setName(rs.getString("name"));
                member.setEmail(rs.getString("email"));
                member.setPhone(rs.getString("phone"));
                member.setRegistrationDate(rs.getDate("registration_date"));
                member.setExpiryDate(rs.getDate("expiry_date"));
                member.setStatus(rs.getString("status"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return member;
    }
}

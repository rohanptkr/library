package com.library.dao;

import com.library.model.Member;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.io.IOException;

public class MemberDAO {
    private Connection connection;

    public MemberDAO(Connection connection) {
        this.connection = connection;
    }

    // Generate sequential PL member ID
    private String generateMemberId() {
        String sql = "SELECT MAX(member_id) FROM members WHERE member_id LIKE 'PL%'";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                String maxMemberId = rs.getString(1);
                if (maxMemberId != null && maxMemberId.startsWith("PL")) {
                    // Extract the number part and increment
                    String numberPart = maxMemberId.substring(2);
                    try {
                        int nextNumber = Integer.parseInt(numberPart) + 1;
                        return "PL" + nextNumber;
                    } catch (NumberFormatException e) {
                        // If parsing fails, start from 1
                        return "PL1";
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // If no existing PL members, start from PL1
        return "PL1";
    }

    // Method to create database backup
    private void createDatabaseBackup() {
        try {
            // Create backup directory if it doesn't exist
            ProcessBuilder mkdirPb = new ProcessBuilder("mkdir", "-p", "/home/ec2-user/bkup");
            Process mkdirProcess = mkdirPb.start();
            mkdirProcess.waitFor();

            // Create the backup using mysqldump
            String backupCommand = "mysqldump -u root -p1 library_db > /home/ec2-user/library_db_backup_$(date +%Y%m%d_%H%M%S).sql";
            ProcessBuilder pb = new ProcessBuilder("bash", "-c", backupCommand);
            Process process = pb.start();
            int exitCode = process.waitFor();
            
            if (exitCode == 0) {
                System.out.println("Database backup created successfully");
                
                // Move the backup to bkup directory
                String moveCommand = "mv /home/ec2-user/library_db_backup_*.sql /home/ec2-user/bkup/";
                ProcessBuilder movePb = new ProcessBuilder("bash", "-c", moveCommand);
                Process moveProcess = movePb.start();
                moveProcess.waitFor();
                
                System.out.println("Backup moved to /home/ec2-user/bkup/");
            } else {
                System.err.println("Failed to create database backup. Exit code: " + exitCode);
            }
        } catch (IOException | InterruptedException e) {
            System.err.println("Error creating database backup: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public boolean addMember(Member member) {
        String sql = "INSERT INTO members (member_id, name, email, phone, aadhar, registration_date, expiry_date, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String memberId = generateMemberId();
            stmt.setString(1, memberId);
            stmt.setString(2, member.getName());
            stmt.setString(3, member.getEmail());
            stmt.setString(4, member.getPhone());
            stmt.setString(5, member.getAadhar());
            stmt.setDate(6, Date.valueOf(member.getRegistrationDate()));
            stmt.setDate(7, Date.valueOf(member.getExpiryDate()));
            stmt.setString(8, member.getStatus());

            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Create database backup after successful member registration
                createDatabaseBackup();
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Add validation methods
    public boolean isPhoneExists(String phone) {
        if (phone == null || phone.trim().isEmpty() || !phone.matches("\\d{10}")) return false;

        String sql = "SELECT COUNT(*) FROM members WHERE phone = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, phone);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isAadharExists(String aadhar) {
        if (aadhar == null || aadhar.trim().isEmpty() || !aadhar.matches("\\d{12}")) return false;

        String sql = "SELECT COUNT(*) FROM members WHERE aadhar = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, aadhar);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isEmailExists(String email) {
        if (email == null || email.trim().isEmpty()) return false;

        String sql = "SELECT COUNT(*) FROM members WHERE email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Member> getAllActiveMembers() {
        List<Member> members = new ArrayList<>();
        String sql = "SELECT * FROM members WHERE status = 'ACTIVE' ORDER BY expiry_date";

        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Member member = extractMemberFromResultSet(rs);
                members.add(member);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return members;
    }

    public List<Member> searchMembers(String searchQuery) {
        List<Member> members = new ArrayList<>();
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            return getAllActiveMembers();
        }

        String sql = "SELECT * FROM members WHERE status = 'ACTIVE' AND " +
                    "(name LIKE ? OR email LIKE ? OR phone LIKE ? OR member_id LIKE ? OR aadhar LIKE ?) " +
                    "ORDER BY name";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchPattern = "%" + searchQuery + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            stmt.setString(5, searchPattern);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Member member = extractMemberFromResultSet(rs);
                members.add(member);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return members;
    }

    public boolean renewMembershipByMemberId(String memberId, int months) {
        String sql = "UPDATE members SET expiry_date = DATE_ADD(expiry_date, INTERVAL ? MONTH), status = 'ACTIVE' WHERE member_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, months);
            stmt.setString(2, memberId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean renewMembership(int memberId, int months) {
        String sql = "UPDATE members SET expiry_date = DATE_ADD(expiry_date, INTERVAL ? MONTH), status = 'ACTIVE' WHERE id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, months);
            stmt.setInt(2, memberId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Member extractMemberFromResultSet(ResultSet rs) throws SQLException {
        Member member = new Member();
        member.setId(rs.getInt("id"));
        member.setMemberId(rs.getString("member_id"));
        member.setName(rs.getString("name"));
        member.setEmail(rs.getString("email"));
        member.setPhone(rs.getString("phone"));
        member.setAadhar(rs.getString("aadhar"));
        member.setRegistrationDate(rs.getDate("registration_date").toLocalDate());
        member.setExpiryDate(rs.getDate("expiry_date").toLocalDate());
        member.setStatus(rs.getString("status"));
        member.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        return member;
    }
}

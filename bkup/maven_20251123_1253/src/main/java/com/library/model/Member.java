package com.library.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Member {
    private int id;
    private String memberId;
    private String name;
    private String email;
    private String phone;
    private String aadhar;
    private LocalDate registrationDate;
    private LocalDate expiryDate;
    private String status;
    private LocalDateTime createdAt;
    
    // Constructors
    public Member() {}
    
    public Member(String memberId, String name, String email, String phone, String aadhar, 
                  LocalDate registrationDate, LocalDate expiryDate, String status) {
        this.memberId = memberId;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.aadhar = aadhar;
        this.registrationDate = registrationDate;
        this.expiryDate = expiryDate;
        this.status = status;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getMemberId() { return memberId; }
    public void setMemberId(String memberId) { this.memberId = memberId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getAadhar() { return aadhar; }
    public void setAadhar(String aadhar) { this.aadhar = aadhar; }
    
    public LocalDate getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(LocalDate registrationDate) { this.registrationDate = registrationDate; }
    
    public LocalDate getExpiryDate() { return expiryDate; }
    public void setExpiryDate(LocalDate expiryDate) { this.expiryDate = expiryDate; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    // Helper method to check if member is active
    public boolean isActive() {
        return "ACTIVE".equals(status);
    }
}

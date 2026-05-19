
package com.advancedprogramming.foodsharehub.assignment.model;

public class Assignment {
    private int id;
    private int donationId;
    private Integer volunteerId; // nullable
    private String status;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getDonationId() { return donationId; }
    public void setDonationId(int donationId) { this.donationId = donationId; }

    public Integer getVolunteerId() { return volunteerId; }
    public void setVolunteerId(Integer volunteerId) { this.volunteerId = volunteerId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}

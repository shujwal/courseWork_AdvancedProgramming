package com.advancedprogramming.foodsharehub.assignment.model.dao;

import com.advancedprogramming.foodsharehub.assignment.model.Assignment;
import com.advancedprogramming.foodsharehub.utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AssignmentDao {

    // Get assignment by donation id (single)
    public Assignment getByDonationId(int donationId) {
        String sql = "SELECT * FROM assignment WHERE donation_id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, donationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return map(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Create assignment (returns generated id or -1)
    public int create(Assignment a) {
        String sql = "INSERT INTO assignment(donation_id, volunteer_id, status) VALUES(?, ?, ?)";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, a.getDonationId());
            if (a.getVolunteerId() == null) {
                ps.setNull(2, Types.INTEGER);
            } else {
                ps.setInt(2, a.getVolunteerId());
            }
            ps.setString(3, a.getStatus());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    int id = keys.getInt(1);
                    a.setId(id);
                    return id;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Update assignment (volunteer/status)
    public void update(Assignment a) {
        String sql = "UPDATE assignment SET volunteer_id = ?, status = ? WHERE donation_id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (a.getVolunteerId() == null) {
                ps.setNull(1, Types.INTEGER);
            } else {
                ps.setInt(1, a.getVolunteerId());
            }
            ps.setString(2, a.getStatus());
            ps.setInt(3, a.getDonationId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void assignVolunteer(int donationId, int volunteerId) {
        Assignment existing = getByDonationId(donationId);
        Assignment assignment = new Assignment();
        assignment.setDonationId(donationId);
        assignment.setVolunteerId(volunteerId);
        assignment.setStatus("pending");

        if (existing == null) {
            create(assignment);
        } else {
            assignment.setId(existing.getId());
            update(assignment);
        }
    }

    // Update status convenience method
    public void updateStatus(int donationId, String status) {
        String sql = "UPDATE assignment SET status = ? WHERE donation_id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, donationId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



    private Assignment map(ResultSet rs) throws SQLException {
        Assignment a = new Assignment();
        a.setId(rs.getInt("id"));
        a.setDonationId(rs.getInt("donation_id"));
        int vol = rs.getInt("volunteer_id");
        if (rs.wasNull()) {
            a.setVolunteerId(null);
        } else {
            a.setVolunteerId(vol);
        }
        a.setStatus(rs.getString("status"));
        return a;
    }
}
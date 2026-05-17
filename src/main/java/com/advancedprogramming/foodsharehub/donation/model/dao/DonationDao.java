package com.advancedprogramming.foodsharehub.donation.model.dao;

import com.advancedprogramming.foodsharehub.donation.model.Donation;
import com.advancedprogramming.foodsharehub.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DonationDao {

    // CREATE
    public void addDonation(Donation d) {
        try (Connection conn = DbConnection.getConnection()) {
            if (conn == null) {
                throw new RuntimeException("Failed to save donation: database connection is null");
            }
            String sql = "INSERT INTO donation(food_name, quantity, expiry_date, location, donor_id) VALUES(?,?,?,?,?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, d.getFoodName());
                ps.setInt(2, d.getQuantity());
                if (d.getExpiryDate() == null || d.getExpiryDate().isBlank()) {
                    throw new IllegalArgumentException("Expiry date is required");
                }
                ps.setDate(3, parseExpiryDate(d.getExpiryDate()));
                ps.setString(4, d.getLocation());
                ps.setInt(5, d.getDonorId());
                ps.executeUpdate();
            }
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to save donation: invalid expiry date format (expected YYYY-MM-DD)", e);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to save donation: " + e.getMessage(), e);
        }
    }

    // READ
    public List<Donation> getAllDonations() {
        List<Donation> list = new ArrayList<>();
        String sql = "SELECT d.*, a.id AS assignment_id, a.volunteer_id AS volunteer_id, a.status AS status FROM donation d LEFT JOIN assignment a ON d.id = a.donation_id ORDER BY d.id ASC";
        try (Connection conn = DbConnection.getConnection(); Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapDonation(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Donation> getDonationsByDonor(int donorId) {
        List<Donation> list = new ArrayList<>();
        String sql = "SELECT d.*, a.id AS assignment_id, a.volunteer_id AS volunteer_id, a.status AS status FROM donation d LEFT JOIN assignment a ON d.id = a.donation_id WHERE d.donor_id=? ORDER BY d.id ASC";
        try (Connection conn = DbConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, donorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapDonation(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Donation> getDonationsByVolunteer(int volunteerId) {
        List<Donation> list = new ArrayList<>();
        String sql = "SELECT d.*, a.id AS assignment_id, a.volunteer_id AS volunteer_id, a.status AS status FROM donation d JOIN assignment a ON d.id = a.donation_id WHERE a.volunteer_id=? ORDER BY d.id ASC";
        try (Connection conn = DbConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, volunteerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapDonation(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    private Donation mapDonation(ResultSet rs) throws Exception {
        Donation d = new Donation();
        d.setId(rs.getInt("id"));
        d.setFoodName(rs.getString("food_name"));
        d.setQuantity(rs.getInt("quantity"));
        d.setExpiryDate(rs.getString("expiry_date"));
        d.setLocation(rs.getString("location"));
        try { d.setStatus(rs.getString("status")); } catch (Exception ignored) {}
        try { d.setDonorId(rs.getInt("donor_id")); } catch (Exception ignored) {}
        try { d.setVolunteerId(rs.getInt("volunteer_id")); } catch (Exception ignored) {}
        return d;
    }

    private java.sql.Date parseExpiryDate(String expiryDate) {
        if (expiryDate.contains("/")) {
            String[] parts = expiryDate.split("/");
            if (parts.length == 3) {
                int month = Integer.parseInt(parts[0]);
                int day = Integer.parseInt(parts[1]);
                int year = Integer.parseInt(parts[2]);
                return java.sql.Date.valueOf(LocalDate.of(year, month, day));
            }
        }
        return java.sql.Date.valueOf(expiryDate);
    }

    // READ BY ID
    public Donation getDonationById(int id) {
        Donation donation = null;
        String sql = "SELECT d.*, a.id AS assignment_id, a.volunteer_id AS volunteer_id, a.status AS status FROM donation d LEFT JOIN assignment a ON d.id = a.donation_id WHERE d.id=?";
        try (Connection conn = DbConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    donation = mapDonation(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return donation;
    }

    // UPDATE
    public void updateDonation(Donation d) {
        try {
            String sql = "UPDATE donation SET food_name=?, quantity=?, expiry_date=?, location=? WHERE id=?";
            try (Connection conn = DbConnection.getConnection()) {
                if (conn == null) {
                    throw new RuntimeException("Failed to update donation: database connection is null");
                }
                try (PreparedStatement ps = conn.prepareStatement(sql)) {
                    ps.setString(1, d.getFoodName());
                    ps.setInt(2, d.getQuantity());
                    if (d.getExpiryDate() == null || d.getExpiryDate().isBlank()) {
                        ps.setNull(3, java.sql.Types.DATE);
                    } else {
                        ps.setDate(3, java.sql.Date.valueOf(d.getExpiryDate()));
                    }
                    ps.setString(4, d.getLocation());
                    ps.setInt(5, d.getId());
                    ps.executeUpdate();
                }
            }
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to update donation: invalid expiry date format (expected YYYY-MM-DD)", e);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to update donation: " + e.getMessage(), e);
        }
    }

    // DELETE
    public void deleteDonation(int id) {
        try (Connection conn = DbConnection.getConnection()) {
            String sql = "DELETE FROM donation WHERE id=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                ps.executeUpdate();
            }

            // Reset auto-increment if table is empty
            String countSql = "SELECT COUNT(*) FROM donation";
            try (Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(countSql)) {
                if (rs.next() && rs.getInt(1) == 0) {
                    try (Statement resetSt = conn.createStatement()) {
                        resetSt.executeUpdate("ALTER TABLE donation AUTO_INCREMENT = 1");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ASSIGN VOLUNTEER
    public void assignVolunteer(int donationId, int volunteerId) {
        try (Connection conn = DbConnection.getConnection()) {
            if (conn == null) {
                return;
            }

            String findSql = "SELECT id FROM assignment WHERE donation_id=?";
            try (PreparedStatement find = conn.prepareStatement(findSql)) {
                find.setInt(1, donationId);
                try (ResultSet rs = find.executeQuery()) {
                    if (rs.next()) {
                        String updateSql = "UPDATE assignment SET volunteer_id=?, status='pending' WHERE donation_id=?";
                        try (PreparedStatement update = conn.prepareStatement(updateSql)) {
                            update.setInt(1, volunteerId);
                            update.setInt(2, donationId);
                            update.executeUpdate();
                        }
                        return;
                    }
                }
            }

            String insertSql = "INSERT INTO assignment(donation_id, volunteer_id, status) VALUES(?,?, 'pending')";
            try (PreparedStatement insert = conn.prepareStatement(insertSql)) {
                insert.setInt(1, donationId);
                insert.setInt(2, volunteerId);
                insert.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // UPDATE STATUS
    public void updateStatus(int donationId, String status) {
        try (Connection conn = DbConnection.getConnection()) {
            if (conn == null) {
                return;
            }

            String sql = "UPDATE assignment SET status=? WHERE donation_id=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setInt(2, donationId);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
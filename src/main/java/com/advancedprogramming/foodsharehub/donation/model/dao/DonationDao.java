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
                bindDonationBaseFields(ps, d, false);
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
        String sql = "SELECT d.*, a.id AS assignment_id, a.volunteer_id AS volunteer_id, a.status AS status FROM donation d LEFT JOIN assignment a ON d.id = a.donation_id ORDER BY d.id ASC";
        return queryDonations(sql);
    }

    public List<Donation> getDonationsByDonor(int donorId) {
        String sql = "SELECT d.*, a.id AS assignment_id, a.volunteer_id AS volunteer_id, a.status AS status FROM donation d LEFT JOIN assignment a ON d.id = a.donation_id WHERE d.donor_id=? ORDER BY d.id ASC";
        return queryDonations(sql, donorId);
    }

    public List<Donation> getDonationsByVolunteer(int volunteerId) {
        String sql = "SELECT d.*, a.id AS assignment_id, a.volunteer_id AS volunteer_id, a.status AS status FROM donation d JOIN assignment a ON d.id = a.donation_id WHERE a.volunteer_id=? ORDER BY d.id ASC";
        return queryDonations(sql, volunteerId);
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

    private int bindDonationBaseFields(PreparedStatement ps, Donation d, boolean allowNullExpiry) throws Exception {
        ps.setString(1, d.getFoodName());
        ps.setInt(2, d.getQuantity());
        if (d.getExpiryDate() == null || d.getExpiryDate().isBlank()) {
            if (allowNullExpiry) {
                ps.setNull(3, java.sql.Types.DATE);
            } else {
                throw new IllegalArgumentException("Expiry date is required");
            }
        } else {
            ps.setDate(3, parseExpiryDate(d.getExpiryDate()));
        }
        ps.setString(4, d.getLocation());
        return 4;
    }

    private List<Donation> queryDonations(String sql, Object... params) {
        List<Donation> list = new ArrayList<>();
        try (Connection conn = DbConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            setParameters(ps, params);
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

    private Donation queryDonation(String sql, Object... params) {
        Donation donation = null;
        try (Connection conn = DbConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            setParameters(ps, params);
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

    private void setParameters(PreparedStatement ps, Object... params) throws Exception {
        for (int i = 0; i < params.length; i++) {
            ps.setObject(i + 1, params[i]);
        }
    }

    // READ BY ID
    public Donation getDonationById(int id) {
        String sql = "SELECT d.*, a.id AS assignment_id, a.volunteer_id AS volunteer_id, a.status AS status FROM donation d LEFT JOIN assignment a ON d.id = a.donation_id WHERE d.id=?";
        return queryDonation(sql, id);
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
                    bindDonationBaseFields(ps, d, true);
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

}
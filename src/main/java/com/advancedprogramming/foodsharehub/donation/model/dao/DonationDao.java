package com.advancedprogramming.foodsharehub.donation.model.dao;

import com.advancedprogramming.foodsharehub.donation.model.Donation;
import com.advancedprogramming.foodsharehub.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class DonationDao {

    // CREATE
    public void addDonation(Donation d) {
        try {
            Connection conn = DbConnection.getConnection();
            String sql = "INSERT INTO donation(food_name, quantity, expiry_date, location) VALUES(?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, d.getFoodName());
            ps.setInt(2, d.getQuantity());
            ps.setString(3, d.getExpiryDate());
            ps.setString(4, d.getLocation());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // READ
    public List<Donation> getAllDonations() {
        List<Donation> list = new ArrayList<>();
        try {
            Connection conn = DbConnection.getConnection();
            String sql = "SELECT * FROM donation";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);

            while (rs.next()) {
                Donation d = new Donation();
                d.setId(rs.getInt("id"));
                d.setFoodName(rs.getString("food_name"));
                d.setQuantity(rs.getInt("quantity"));
                d.setExpiryDate(rs.getString("expiry_date"));
                d.setLocation(rs.getString("location"));
                d.setStatus(rs.getString("status"));
                d.setDonorId(rs.getInt("donor_id"));
                d.setVolunteerId(rs.getInt("volunteer_id"));
                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // DELETE
    public void deleteDonation(int id) {
        try {
            Connection conn = DbConnection.getConnection();
            String sql = "DELETE FROM donations WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // UPDATE STATUS
    public void updateStatus(int id, String status, int volunteerId) {
        try {
            Connection conn = DbConnection.getConnection();
            String sql = "UPDATE donations SET status=?, volunteer_id=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, volunteerId);
            ps.setInt(3, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
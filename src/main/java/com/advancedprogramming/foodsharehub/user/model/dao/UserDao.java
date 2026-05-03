package com.advancedprogramming.foodsharehub.user.model.dao;

import com.advancedprogramming.foodsharehub.user.model.User;
import com.advancedprogramming.foodsharehub.utils.DbConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao {

    // REGISTER
    public boolean register(User user) throws Exception {
        try (Connection conn = DbConnection.getConnection()) {
            if (conn == null) {
                throw new Exception("Unable to connect to the database");
            }

            // Check if email exists
            String check = "SELECT * FROM user WHERE email=?";
            try (PreparedStatement ps1 = conn.prepareStatement(check)) {
                ps1.setString(1, user.getEmail());
                try (ResultSet rs = ps1.executeQuery()) {
                    if (rs.next()) {
                        return false; // already exists
                    }
                }
            }

            String sql = "INSERT INTO user(name, email, password, role) VALUES(?,?,?,?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, user.getFullName());
                ps.setString(2, user.getEmail());
                ps.setString(3, user.getPassword());
                String role = user.getRole();
                if (role == null || role.isEmpty()) {
                    role = "donor";
                }
                ps.setString(4, role);
                ps.executeUpdate();
            }

            return true;
        }
    }

    // LOGIN
    public User login(String email, String password) throws Exception {
        User user = null;
        try (Connection conn = DbConnection.getConnection()) {
            if (conn == null) {
                throw new Exception("Unable to connect to the database");
            }

            String sql = "SELECT * FROM user WHERE email=?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, email);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String hashedPassword = rs.getString("password");
                        if (BCrypt.checkpw(password, hashedPassword)) {
                            user = new User();
                            user.setId(rs.getInt("id"));
                            user.setFullName(rs.getString("name"));
                            user.setEmail(rs.getString("email"));
                            user.setRole(rs.getString("role"));
                        }
                    }
                }
            }
        }
        return user;
    }
}
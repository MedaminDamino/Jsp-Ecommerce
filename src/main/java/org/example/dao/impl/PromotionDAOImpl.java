package org.example.dao.impl;

import org.example.dao.PromotionDAO;
import org.example.model.Promotion;
import org.example.util.ConnectionFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PromotionDAOImpl implements PromotionDAO {

    @Override
    public List<Promotion> findActivePromotions() {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT * FROM promotions WHERE active = TRUE AND end_date >= CURDATE()";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                promotions.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return promotions;
    }

    @Override
    public List<Promotion> findAll() {
        List<Promotion> promotions = new ArrayList<>();
        String sql = "SELECT * FROM promotions";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                promotions.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return promotions;
    }

    @Override
    public int save(Promotion promotion) {
        String sql = "INSERT INTO promotions (title, description, active, discount_type, discount_value, end_date) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, promotion.getTitle());
            stmt.setString(2, promotion.getDescription());
            stmt.setBoolean(3, promotion.isActive());
            stmt.setString(4, promotion.getDiscountType().name());
            stmt.setDouble(5, promotion.getDiscountValue());
            stmt.setDate(6, Date.valueOf(promotion.getEndDate()));
            stmt.executeUpdate();
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public void saveProductPromotions(int promotionId, String[] productIds) {
        if (productIds == null || productIds.length == 0) return;
        
        String sql = "INSERT INTO product_promotions (product_id, promotion_id) VALUES (?, ?)";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            for (String productId : productIds) {
                stmt.setInt(1, Integer.parseInt(productId));
                stmt.setInt(2, promotionId);
                stmt.addBatch();
            }
            stmt.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteProductPromotions(int promotionId) {
        String sql = "DELETE FROM product_promotions WHERE promotion_id = ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, promotionId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Integer> getProductIdsForPromotion(int promotionId) {
        List<Integer> productIds = new ArrayList<>();
        String sql = "SELECT product_id FROM product_promotions WHERE promotion_id = ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, promotionId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    productIds.add(rs.getInt("product_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productIds;
    }

    @Override
    public void update(Promotion promotion) {
        String sql = "UPDATE promotions SET title = ?, description = ?, active = ?, discount_type = ?, discount_value = ?, end_date = ? WHERE id = ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, promotion.getTitle());
            stmt.setString(2, promotion.getDescription());
            stmt.setBoolean(3, promotion.isActive());
            stmt.setString(4, promotion.getDiscountType().name());
            stmt.setDouble(5, promotion.getDiscountValue());
            stmt.setDate(6, Date.valueOf(promotion.getEndDate()));
            stmt.setInt(7, promotion.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        // FK constraint will handle product_promotions if ON DELETE CASCADE is set
        String sql = "DELETE FROM promotions WHERE id = ?";
        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private Promotion mapRow(ResultSet rs) throws SQLException {
        return new Promotion(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("description"),
                rs.getBoolean("active"),
                Promotion.DiscountType.valueOf(rs.getString("discount_type")),
                rs.getDouble("discount_value"),
                rs.getDate("end_date").toLocalDate()
        );
    }
}

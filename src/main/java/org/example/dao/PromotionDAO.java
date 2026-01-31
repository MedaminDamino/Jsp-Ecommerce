package org.example.dao;

import org.example.model.Promotion;
import java.util.List;

public interface PromotionDAO {
    List<Promotion> findActivePromotions();
    List<Promotion> findAll();
    int save(Promotion promotion);
    void saveProductPromotions(int promotionId, String[] productIds);
    void deleteProductPromotions(int promotionId);
    List<Integer> getProductIdsForPromotion(int promotionId);
    void update(Promotion promotion);
    void delete(int id);
}

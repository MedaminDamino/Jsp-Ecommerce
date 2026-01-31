package org.example.service;

import org.example.model.Promotion;
import java.util.List;

public interface PromotionService {
    List<Promotion> getActivePromotions();
    List<Promotion> getAllPromotions();
    void addPromotion(Promotion promotion, String[] productIds);
    void updatePromotion(Promotion promotion, String[] productIds);
    List<Integer> getProductIdsForPromotion(int promotionId);
    void deletePromotion(int id);
}

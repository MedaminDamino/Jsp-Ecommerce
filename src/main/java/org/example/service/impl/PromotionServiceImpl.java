package org.example.service.impl;

import org.example.dao.PromotionDAO;
import org.example.dao.impl.PromotionDAOImpl;
import org.example.model.Promotion;
import org.example.service.PromotionService;

import java.util.List;

public class PromotionServiceImpl implements PromotionService {

    private final PromotionDAO promotionDAO;

    public PromotionServiceImpl() {
        this.promotionDAO = new PromotionDAOImpl();
    }

    @Override
    public List<Promotion> getActivePromotions() {
        return promotionDAO.findActivePromotions();
    }

    @Override
    public List<Promotion> getAllPromotions() {
        return promotionDAO.findAll();
    }

    @Override
    public void addPromotion(Promotion promotion, String[] productIds) {
        int id = promotionDAO.save(promotion);
        if (id != -1 && productIds != null) {
            promotionDAO.saveProductPromotions(id, productIds);
        }
    }

    @Override
    public void updatePromotion(Promotion promotion, String[] productIds) {
        promotionDAO.update(promotion);
        promotionDAO.deleteProductPromotions(promotion.getId());
        if (productIds != null) {
            promotionDAO.saveProductPromotions(promotion.getId(), productIds);
        }
    }

    @Override
    public List<Integer> getProductIdsForPromotion(int promotionId) {
        return promotionDAO.getProductIdsForPromotion(promotionId);
    }

    @Override
    public void deletePromotion(int id) {
        promotionDAO.delete(id);
    }
}

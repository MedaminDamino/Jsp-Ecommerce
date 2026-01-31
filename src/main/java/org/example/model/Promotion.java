package org.example.model;

import java.time.LocalDate;

public class Promotion {
    public enum DiscountType {
        PERCENTAGE, FIXED
    }

    private int id;
    private String title;
    private String description;
    private boolean active;
    private DiscountType discountType;
    private double discountValue;
    private LocalDate endDate;
    private String productIds; // Comma-separated IDs for DB display
    private java.util.List<String> productNames = new java.util.ArrayList<>();

    public Promotion(int id, String title, String description, boolean active, DiscountType discountType, double discountValue, LocalDate endDate) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.active = active;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.endDate = endDate;
    }

    public String getProductIds() { return productIds; }
    public void setProductIds(String productIds) { this.productIds = productIds; }

    public java.util.List<String> getProductNames() { return productNames; }
    public void setProductNames(java.util.List<String> productNames) { this.productNames = productNames; }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }

    public DiscountType getDiscountType() { return discountType; }
    public void setDiscountType(DiscountType discountType) { this.discountType = discountType; }

    public double getDiscountValue() { return discountValue; }
    public void setDiscountValue(double discountValue) { this.discountValue = discountValue; }

    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }
    
    // Helper to check validity
    public boolean isValid() {
        return active && (endDate == null || !LocalDate.now().isAfter(endDate));
    }
}

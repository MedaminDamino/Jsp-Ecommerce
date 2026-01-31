package org.example.model;

public class Product {
    private int id;
    private String name;
    private String description;
    private double price;
    private int categoryId;
    private String imageUrl;

    public Product(int id, String name, String description, double price, int categoryId, String imageUrl) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.categoryId = categoryId;
        this.imageUrl = imageUrl;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    // Discount features
    private double discountedPrice;
    private boolean hasDiscount;

    public double getDiscountedPrice() { return discountedPrice; }
    public void setDiscountedPrice(double discountedPrice) { this.discountedPrice = discountedPrice; }

    public boolean isHasDiscount() { return hasDiscount; }
    public void setHasDiscount(boolean hasDiscount) { this.hasDiscount = hasDiscount; }

    public void applyDiscount(String type, double value) {
        this.hasDiscount = true;
        if ("PERCENTAGE".equals(type)) {
            this.discountedPrice = this.price * (1 - value / 100.0);
        } else if ("FIXED".equals(type)) {
            this.discountedPrice = Math.max(0, this.price - value);
        } else {
            this.discountedPrice = this.price;
            this.hasDiscount = false;
        }
        // Round to 2 decimal places
        this.discountedPrice = Math.round(this.discountedPrice * 100.0) / 100.0;
    }
}

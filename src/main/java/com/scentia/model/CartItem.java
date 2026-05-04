package com.scentia.model;

public class CartItem {

    private int id;
    private String name;
    private String brand;
    private int quantity;
    private int score; // optional display
    private double price;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }
    
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}
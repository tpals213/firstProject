package com.sdm.ssm.pos.model.vo;

public class Menu {
    private int id;
    private String name;
    private double price;
    private String description; // 메뉴 설명을 추가했습니다.

    // 기본 생성자
    public Menu() {
    }

    // 모든 필드를 포함한 생성자
    public Menu(int id, String name, double price, String description) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description; // 생성자에 description 파라미터를 추가했습니다.
    }

    // Getter 및 Setter 메서드
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

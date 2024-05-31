package com.sdm.ssm.pos.model.vo;

public class Inventory {
    private int id; // 재고 아이템의 고유 식별자
    private int menuId; // 해당 재고가 속한 메뉴 항목의 ID
    private int quantity; // 해당 메뉴 항목의 재고 수량

    // 기본 생성자
    public Inventory() {
    }

    // 모든 필드를 포함한 생성자
    public Inventory(int id, int menuId, int quantity) {
        this.id = id;
        this.menuId = menuId;
        this.quantity = quantity;
    }

    // Getter 및 Setter 메서드
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMenuId() {
        return menuId;
    }

    public void setMenuId(int menuId) {
        this.menuId = menuId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}

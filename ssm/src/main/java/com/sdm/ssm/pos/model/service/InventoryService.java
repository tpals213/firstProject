package com.sdm.ssm.pos.model.service;

import java.util.List;
import com.sdm.ssm.pos.model.vo.Inventory;

public interface InventoryService {

    List<Inventory> getAllInventory();

    void updateInventory(Inventory inventory);

    void addInventory(Inventory inventory);

    void deleteInventory(int id);

    // 추가적인 재고 관련 기능에 대한 메소드를 선언할 수 있습니다.
}

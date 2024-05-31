package com.sdm.ssm.pos.model.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sdm.ssm.pos.model.dao.InventoryDAO;
import com.sdm.ssm.pos.model.vo.Inventory;

@Service
public class InventoryServiceImpl implements InventoryService {

    @Autowired
    private InventoryDAO inventoryDAO;

    @Override
    public List<Inventory> getAllInventory() {
        return inventoryDAO.getAllInventory();
    }

    @Override
    public void updateInventory(Inventory inventory) {
        inventoryDAO.updateInventory(inventory);
    }

    @Override
    public void addInventory(Inventory inventory) {
        inventoryDAO.addInventory(inventory);
    }

    @Override
    public void deleteInventory(int id) {
        inventoryDAO.deleteInventory(id);
    }

    // 추가적인 재고 관련 기능에 대한 메소드를 구현할 수 있습니다.
}

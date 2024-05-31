package com.sdm.ssm.pos.model.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.sdm.ssm.pos.model.vo.Inventory;

@Repository
public class InventoryDAOImpl implements InventoryDAO {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<Inventory> getAllInventory() {
        return sqlSession.selectList("inventoryMapper.getAllInventory");
    }

    @Override
    public void updateInventory(Inventory inventory) {
        sqlSession.update("inventoryMapper.updateInventory", inventory);
    }

    @Override
    public void addInventory(Inventory inventory) {
        sqlSession.insert("inventoryMapper.addInventory", inventory);
    }

    @Override
    public void deleteInventory(int id) {
        sqlSession.delete("inventoryMapper.deleteInventory", id);
    }

    // 추가적인 재고 관련 기능에 대한 메소드를 구현할 수 있습니다.
}

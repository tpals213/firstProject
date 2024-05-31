package com.sdm.ssm.pos.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.pos.model.dao.InventoryDAO;
import com.sdm.ssm.pos.model.dao.MenuDAO;
import com.sdm.ssm.pos.model.dao.PosDAO;
import com.sdm.ssm.pos.model.vo.Inventory;
import com.sdm.ssm.pos.model.vo.Menu;
import com.sdm.ssm.pos.model.vo.Table;

@Service("posService")
public class PosServiceImpl implements PosService {

    @Autowired
    private MenuDAO menuDAO;

    @Autowired
    private InventoryDAO inventoryDAO;
    
    @Autowired
    private PosDAO posDao;

    @Override
    public List<Menu> getAllMenus() {
        return menuDAO.getAllMenus();
    }

    @Override
    public List<Inventory> getAllInventory() {
        return inventoryDAO.getAllInventory();
    }

    @Override
    public void updateInventory(Inventory inventory) {
        inventoryDAO.updateInventory(inventory);
    }

    @Override
    public void addMenu(Menu menu) {
        menuDAO.addMenu(menu);
    }

    @Override
    public void updateMenu(Menu menu) {
        menuDAO.updateMenu(menu);
    }

    @Override
    public void deleteMenu(int id) {
        menuDAO.deleteMenu(id);
    }

	@Override
	public int insertTableInfo(Table table) {
		return posDao.insertTableInfo(table);
	}

	@Override
	public ArrayList<Table> selectTableList(String id) {
		return posDao.selectTableList(id);
	}

	@Override
	public int deleteTable(Table table) {
		// TODO Auto-generated method stub
		return posDao.deleteTable(table);
	}

    // 추가적인 POS 관련 기능에 대한 메소드를 구현할 수 있습니다.
}

package com.sdm.ssm.pos.model.dao;

import java.util.ArrayList;
import java.util.List;
import com.sdm.ssm.pos.model.vo.Inventory;
import com.sdm.ssm.pos.model.vo.Menu;
import com.sdm.ssm.pos.model.vo.Table;

public interface PosDAO {

    List<Menu> getAllMenus();

    List<Inventory> getAllInventory();

    void updateInventory(Inventory inventory);

    void addMenu(Menu menu);

    void updateMenu(Menu menu);

    void deleteMenu(int id);

	int insertTableInfo(Table table);

	ArrayList<Table> selectTableList(String id);

	int deleteTable(Table table);


    // 추가적인 POS 관련 기능에 대한 메소드를 선언할 수 있습니다.
}

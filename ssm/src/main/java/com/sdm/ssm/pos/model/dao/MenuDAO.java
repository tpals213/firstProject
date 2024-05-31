package com.sdm.ssm.pos.model.dao;

import java.util.List;

import com.sdm.ssm.pos.model.vo.Menu;

public interface MenuDAO {
    List<Menu> getAllMenus();
    void addMenu(Menu menu);
    void updateMenu(Menu menu);
    void deleteMenu(int id);
}

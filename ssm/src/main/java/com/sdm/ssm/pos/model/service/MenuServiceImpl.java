package com.sdm.ssm.pos.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdm.ssm.pos.model.dao.MenuDAO;
import com.sdm.ssm.pos.model.vo.Menu;

@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private MenuDAO menuDAO;

    @Override
    public List<Menu> getAllMenus() {
        return menuDAO.getAllMenus();
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
}

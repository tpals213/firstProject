package com.sdm.ssm.pos.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdm.ssm.pos.model.vo.Menu;

@Repository
public class MenuDAOImpl implements MenuDAO {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<Menu> getAllMenus() {
        return sqlSession.selectList("posMapper.getAllMenus");
    }

    @Override
    public void addMenu(Menu menu) {
        sqlSession.insert("posMapper.addMenu", menu);
    }

    @Override
    public void updateMenu(Menu menu) {
        sqlSession.update("posMapper.updateMenu", menu);
    }

    @Override
    public void deleteMenu(int id) {
        sqlSession.delete("posMapper.deleteMenu", id);
    }
}

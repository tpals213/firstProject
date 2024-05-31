package com.sdm.ssm.pos.model.dao;

import java.util.ArrayList;
import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.sdm.ssm.pos.model.vo.Inventory;
import com.sdm.ssm.pos.model.vo.Menu;
import com.sdm.ssm.pos.model.vo.Table;

@Repository
public class PosDAOImpl implements PosDAO {

    @Autowired
    private SqlSession sqlSession;

    @Override
    public List<Menu> getAllMenus() {
        return sqlSession.selectList("posMapper.getAllMenus");
    }

    @Override
    public List<Inventory> getAllInventory() {
        return sqlSession.selectList("posMapper.getAllInventory");
    }

    @Override
    public void updateInventory(Inventory inventory) {
        sqlSession.update("posMapper.updateInventory", inventory);
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

	@Override
	public int insertTableInfo(Table table) {
		return sqlSession.insert("posMapper.insertTable", table);
	}

	@Override
	public ArrayList<Table> selectTableList(String id) {
		List<Table> list = sqlSession.selectList("posMapper.selectTableList", id);
		return (ArrayList<Table>)list;
	}

	@Override
	public int deleteTable(Table table) {
		
		return sqlSession.delete("posMapper.deleteTable", table);
	}

    // 추가적인 POS 관련 기능에 대한 메소드를 구현할 수 있습니다.
}

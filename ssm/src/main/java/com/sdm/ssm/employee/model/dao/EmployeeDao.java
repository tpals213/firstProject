package com.sdm.ssm.employee.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sdm.ssm.common.Search;
import com.sdm.ssm.employee.model.vo.Employee;

@Repository("employeeDao")
public class EmployeeDao {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
    
    public List<Employee> selectEmpList() {
        return sqlSessionTemplate.selectList("employeeMapper.selectEmpList");
    }

    public ArrayList<Employee> employeeListMethod() {
        List<Employee> list = sqlSessionTemplate.selectList("employeeMapper.employeeListMethod");
        return new ArrayList<>(list);
    }

    public List<Employee> employeeSearchMethod(Search search) {
        List<Employee> list = sqlSessionTemplate.selectList("employeeMapper.employeeSearchMethod", search);
        return new ArrayList<>(list);
    }

    public String selectAllEmpMethod() {
        return sqlSessionTemplate.selectOne("employeeMapper.selectAllEmpMethod");
    }

    public int insertEmployee(Employee employee) {
        return sqlSessionTemplate.insert("employeeMapper.insertemployee", employee);
    }

    public int updateEmployee(Employee employee) {
        return sqlSessionTemplate.update("employeeMapper.updateemp", employee);
    }

    public int deleteEmployee(Employee employee) {
        return sqlSessionTemplate.delete("employeeMapper.deleteemp", employee);
    }


    public Employee getEmployeeDetails(int id, int empId) {
    	Map<String, Object> params = new HashMap<>();
    	params.put("id", id);
        params.put("empId", empId);
        return sqlSessionTemplate.selectOne("employeeMapper.getEmployeeDetails", params);
    }

	public List<Employee> getAllEmployees(int id) {
		return sqlSessionTemplate.selectList("employeeMapper.getAllEmployees", id);
	}

	public List<Employee> searchEmployeeByName(@Param("empName") String empName) {
	    return sqlSessionTemplate.selectList("employeeMapper.searchEmployeeByName", empName);
	}

	public Employee selectEmpInfo(Employee emp) {
		return sqlSessionTemplate.selectOne("employeeMapper.selectEmpname", emp);
	}

	public List<Employee> selectemployee(int id) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("employeeMapper.getEmployeeDetails",id);
	}


}

package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.bean.EmployeeExample.Criteria;
import com.atguigu.crud.controller.EmployeeController;
import com.atguigu.crud.dao.EmployeeMapper;


@Service
public class EmployeeService {
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	/*
	 * 
	 * 查询所有员工
	 */
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}
	/*
	 * 保存员工数据
	 */
	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}
	
	
	/**
	 * 
	 * @param empName
	 * @return true 代表当前姓名不重复  fasle表示重复
	 */
	public boolean checkUser(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample example=new EmployeeExample();
		Criteria criteria=example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count=employeeMapper.countByExample(example);
		return count==0;
	}
	
	/**
	 * 根据员工的id查询员工
	 */
	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee employee=employeeMapper.selectByPrimaryKey(id);
		System.out.println(id);
		return employee;
	}
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	/**
	 * 单个删除
	 * @param empId
	 */
	public void deleteSaith(Integer empId) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(empId);

	}
	/**
	 * 多选删除
	 * @param empId
	 */
	public void deleteBatch(List<Integer> empId) {
		// TODO Auto-generated method stub
		EmployeeExample emExample=new EmployeeExample();
		Criteria criteria=emExample.createCriteria();
		
		criteria.andEmpIdIn(empId);
		
		employeeMapper.deleteByExample(emExample);

	}

}

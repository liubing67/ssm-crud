package com.atguigu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.DepartmentService;
import com.github.pagehelper.PageInfo;



@Controller
public class DepartmentController {


	
	
	@Autowired
	private DepartmentService departmentService;
	
	/*
	 * 获取部门列表数据
	 * 
	 */

	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDeptsWithJson(){
		
		//startPage后面紧跟的这个查询就是一个分页查询
		List<Department> liDepartment=departmentService.getAllDepat();
		return Msg.success().add("depts", liDepartment);
	}
}

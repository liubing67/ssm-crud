package com.atguigu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;



/**
 * 测试dao层
 * @author Administrator
 *推荐spring的项目就可以使用spring的单元测试，可以自动注入我们需要的组件
 *
 *1.导入springtest模块
 *
 *2.@contextConfiguration指定spring配置文件的位置
 *
 *3.直接autowired使用中的组件
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	EmployeeMapper employeeMapper;
	@Test
	public void testCRUD(){
		
//		//1.创建springIoc容器
//		ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext.xml");
//		//2.从容器中获取mapper
//		DepartmentMapper bean=ioc.getBean(DepartmentMapper.class);
		
		//1.插入几个部门信息
//		departmentMapper.insertSelective(new Department(null,"测试部"));
//		System.out.println(departmentMapper);
//		departmentMapper.insertSelective(new Department(1,"开发部"));
		
		
		EmployeeMapper emMapper=sqlSession.getMapper(EmployeeMapper.class);
	
		for(int i=0;i<1000;i++){
			String uuid=UUID.randomUUID().toString().substring(0,5)+i;
			emMapper.insertSelective(new Employee(i, uuid, "M", uuid+"@atguigu.com", 1));
		}
	}
	
	
	
}

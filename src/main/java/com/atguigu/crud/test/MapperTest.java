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
 * ����dao��
 * @author Administrator
 *�Ƽ�spring����Ŀ�Ϳ���ʹ��spring�ĵ�Ԫ���ԣ������Զ�ע��������Ҫ�����
 *
 *1.����springtestģ��
 *
 *2.@contextConfigurationָ��spring�����ļ���λ��
 *
 *3.ֱ��autowiredʹ���е����
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
		
//		//1.����springIoc����
//		ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext.xml");
//		//2.�������л�ȡmapper
//		DepartmentMapper bean=ioc.getBean(DepartmentMapper.class);
		
		//1.���뼸��������Ϣ
//		departmentMapper.insertSelective(new Department(null,"���Բ�"));
//		System.out.println(departmentMapper);
//		departmentMapper.insertSelective(new Department(1,"������"));
		
		
		EmployeeMapper emMapper=sqlSession.getMapper(EmployeeMapper.class);
	
		for(int i=0;i<1000;i++){
			String uuid=UUID.randomUUID().toString().substring(0,5)+i;
			emMapper.insertSelective(new Employee(i, uuid, "M", uuid+"@atguigu.com", 1));
		}
	}
	
	
	
}

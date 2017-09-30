package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.junit.runners.Parameterized.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.test.annotation.Repeat;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/*
 * ����Ա����crud
 * 
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	
	
	/**
	 * ��ȡԱ���������б�
	 * @param pn
	 * @param model
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model){
		
		//����pagehelper��ҳ���
		//�ڲ�ѯ֮ǰֻ��Ҫ���ã�����ҳ�룬�Լ�ÿҳ�Ĵ�С
		PageHelper.startPage(pn,5);
		//startPage��������������ѯ����һ����ҳ��ѯ
		List<Employee> liEmployees=employeeService.getAll();
		//ʹ��pageinfo��װ��ѯ��Ľ��
		PageInfo pageInfo=new PageInfo(liEmployees,5);
		return Msg.success().add("pageInfo", pageInfo);
	}
	
	/*
	 * ����Ա��
	 *  * 1.֧��JSR303У��
	 * 2.����Hibernate-Validator
	 */

	@RequestMapping(value="/saveemp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		if(result.hasErrors()){
			Map<String,Object> map=new HashMap<String, Object>();
			//У��ʧ�ܣ�Ӧ�÷���ʧ�ܣ���ģ̬������ʾУ��ʧ�ܵ���Ϣ
			List<FieldError> errors=result.getFieldErrors();
			for(FieldError fieldError:errors){
				System.out.println(fieldError.getField());
				System.out.println(fieldError.getDefaultMessage());
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}
	/**
	 * У��Ա�������Ƿ��ظ�
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkUser(String empName){
		
		String regName ="(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regName)){
			return Msg.fail().add("va_msg","checkUser �û���������2-5λ���Ļ���6-16λӢ�ĺ����ֵ����");
		}
		
		
		boolean b=employeeService.checkUser(empName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg","checkUser �û���������,�����ظ�");
		}
	}
	
	/*
	 *����id��ѯԱ������ 
	 */
	
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		Employee employee=employeeService.getEmp(id);
		return Msg.success().add("emp",employee);
	}
	
	//����Ա����id�༭Ա������
	
	@RequestMapping(value="/update/{empId}",method=RequestMethod.POST)
	@ResponseBody
	public Msg updateEmp(Employee employee){
		
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	
	//����ɾ���Ͷ�ѡɾ��
	@RequestMapping(value="/delete/{ids}",method=RequestMethod.POST)
	@ResponseBody
	public Msg deteleEmp(@PathVariable("ids")String ids){
		
		if(ids.contains("-")){
			
			List<Integer> id_list=new ArrayList<Integer>();
			String[] id_str=ids.split("-");
			for (String s:id_str) {
				id_list.add(Integer.parseInt(s));
			}
			employeeService.deleteBatch(id_list);
			
		}else{
			Integer id=Integer.parseInt(ids);
			employeeService.deleteSaith(id);
		}
		
		
		
		return Msg.success();
	}
	
	
	
}

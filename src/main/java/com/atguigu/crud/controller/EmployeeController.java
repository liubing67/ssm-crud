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
 * 处理员工的crud
 * 
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	
	
	/**
	 * 获取员工的数据列表
	 * @param pn
	 * @param model
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model){
		
		//引入pagehelper分页插件
		//在查询之前只需要调用，传入页码，以及每页的大小
		PageHelper.startPage(pn,5);
		//startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> liEmployees=employeeService.getAll();
		//使用pageinfo包装查询后的结果
		PageInfo pageInfo=new PageInfo(liEmployees,5);
		return Msg.success().add("pageInfo", pageInfo);
	}
	
	/*
	 * 保存员工
	 *  * 1.支持JSR303校验
	 * 2.导入Hibernate-Validator
	 */

	@RequestMapping(value="/saveemp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		if(result.hasErrors()){
			Map<String,Object> map=new HashMap<String, Object>();
			//校验失败，应该返回失败，在模态框中显示校验失败的信息
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
	 * 校验员工名字是否重复
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkUser(String empName){
		
		String regName ="(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regName)){
			return Msg.fail().add("va_msg","checkUser 用户名可以是2-5位中文或者6-16位英文和数字的组合");
		}
		
		
		boolean b=employeeService.checkUser(empName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg","checkUser 用户名不可用,姓名重复");
		}
	}
	
	/*
	 *根据id查询员工数据 
	 */
	
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		Employee employee=employeeService.getEmp(id);
		return Msg.success().add("emp",employee);
	}
	
	//根据员工的id编辑员工资料
	
	@RequestMapping(value="/update/{empId}",method=RequestMethod.POST)
	@ResponseBody
	public Msg updateEmp(Employee employee){
		
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	
	//单歌删除和多选删除
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

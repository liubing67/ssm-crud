<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<link rel="stylesheet"
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css">
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript"
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">

		<!-- 标题 -->
		<div class="row">

			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>


		<!-- 按钮-->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all">删除</button>
			</div>
		</div>

		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all"></th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>


		<!-- 显示分页信息-->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area">当前</div>
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">

						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="empName_add_input"
									name="empName" placeholder="empName"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="email_add_input"
									name="email" placeholder="email@163.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">dept</label>
							<div class="col-sm-4">

								<!-- 部门提交提交部门id -->
								<select class="form-control" name="dId" id="dept_add_select">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 员工更新的模态框 -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">

						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_input"></p>

							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="email_update_input"
									name="email" placeholder="email@163.com"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="M"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="inputPassword3" class="col-sm-2 control-label">dept</label>
							<div class="col-sm-4">

								<!-- 部门提交提交部门id -->
								<select class="form-control" name="dId" id="dept_update_select">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		//定义一个全局变量来记录总记录数
		var totalRecord, currentPage;
		//1、页面加载完成以后，直接去发送ajax请求，要到分页数据 -->
		$(function() {
			to_page(1);
		});

		//根据页数请求数据
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//1、解析并显示员工数据
					//2、解析并显示分页显示
					build_emps_table(result);

					//解析显示分页信息
					build_page_info(result);
					//解析显示分页条
					build_page_nav(result);

				}
			});
		}

		function build_emps_table(result) {

			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$
					.each(
							emps,
							function(index, item) {

								var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
								var empIdTd = $("<td></td>").append(item.empId);
								var empNameTd = $("<td></td>").append(
										item.empName);
								var empGenderTd = $("<td></td>").append(
										item.gender == "M" ? "男" : "女");
								var empEmailTd = $("<td></td>").append(
										item.email);
								var empDeptNameTd = $("<td></td>").append(
										item.department.deptName);

								var editBtn = $("<button></button>")
										.addClass(
												"btn btn-primary btn-sm edit_btn")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-pencil"))
										.append("编辑");
								editBtn.attr("empid", item.empId);
								var delBtn = $("<button></button>")
										.addClass(
												"btn btn-danger btn-sm delete_btn")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-trash"))
										.append("删除");
								delBtn.attr("empid", item.empId);
								var btn = $("<td></td>").append(editBtn)
										.append(" ").append(delBtn);
								$("<tr></tr>").append(checkBoxTd).append(
										empIdTd).append(empNameTd).append(
										empGenderTd).append(empEmailTd).append(
										empDeptNameTd).append(btn).appendTo(
										"#emps_table tbody");
							});
		}

		//解析显示分页信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前" + result.extend.pageInfo.pageNum + "页,总"
							+ result.extend.pageInfo.pages + "页,总"
							+ result.extend.pageInfo.total + "记录");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}

		//解析显示分页条
		function build_page_nav(result) {

			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));

			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));

			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}

			ul.append(firstPageLi).append(prePageLi);

			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));

				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});

				ul.append(numLi);
			});

			ul.append(nextPageLi).append(lastPageLi);

			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}

		//点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function() {

			reset_form("#empAddModal form");
			getDepts("#dept_add_select");
			//getDepts("#empAddModal select");
			//弹出模态框
			$("#empAddModal").modal({
				backdrop : "static",
				keyboard : true

			});

		});

		//校验员工姓名是否重复
		$("#empName_add_input").change(
				function() {

					var empName = this.value;
					$.ajax({
						url : "${APP_PATH}/checkuser",
						data : "empName=" + empName,
						type : "POST",
						success : function(result) {

							if (result.code == 100) {
								show_validate_msg("#empName_add_input",
										"success", "姓名可用");
								$("#emp_save_btn").attr("ajax-va", "success");
							} else if (result.code == 200) {
								show_validate_msg("#empName_add_input",
										"error", result.extend.va_msg);
								$("#emp_save_btn").attr("ajax-va", "error");
							}
						}

					});
				});

		//点击新增模态框中的保存按钮
		$("#emp_save_btn")
				.click(
						function() {
							//先对要提交给服务器的数据进行校验
							if (!validate_add_form()) {
								return false;
							}
							//判断之前的姓名是否校验成功
							if ($(this).attr("ajax-va") == "error") {
								show_validate_msg("#empName_add_input",
										"error", "姓名重复");
								return false;
							}
							$
									.ajax({
										url : "${APP_PATH}/saveemp",
										type : "POST",
										data : $("#empAddModal form")
												.serialize(),
										success : function(result) {
											if (result.code == 100) {
												$("#empAddModal").modal("hide");

												//跳转到最后一页显示新增的数据
												to_page(totalRecord);
											} else {
												console.log(result);
												console
														.log(result.extend.errorFields);
												if (undefined != result.extend.errorFields.email) {
													//显示邮箱错误信息
													show_validate_msg(
															"#email_add_input",
															"error",
															result.extend.errorFields.email);
												}
												if (undefined != result.extend.errorFields.empName) {
													//显示邮箱错误信息
													show_validate_msg(
															"#empName_add_input",
															"error",
															result.extend.errorFields.empName);
												}
											}

										}
									});
						});

		//点击编辑按钮弹出编辑模态框

		//1.我们是按钮创建之前就绑定了click,所以绑定不上
		//1.我们可以在创建按钮的时候绑定事件.  2.绑定点击 live
		//jquery新版没有live,使用on进行替代
		//
		$(document).on("click", ".edit_btn", function() {

			//获取部门的数据
			getDepts("#dept_update_select");
			//弹出模态框
			//获取员工的数据
			getEmp($(this).attr("empid"));
			$("#emp_update_btn").attr("empid", $(this).attr("empid"));
			$("#empUpdateModal").modal({
				backdrop : "static",
				keyboard : true

			});
		});

		//点击更新保存员工数据
		$("#emp_update_btn").click(function() {

			var email = $("#email_update_input").val();
			var regemail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

			if (!regemail.test(email)) {
				show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_update_input", "success", "");
			}
			$.ajax({
				url : "${APP_PATH}/update/" + $(this).attr("empid"),
				type : "POST",
				data : $("#empUpdateModal form").serialize(),
				success : function(result) {
					$("#empUpdateModal").modal("hide");
					to_page(currentPage);
				}
			});
		});

		//点击单个删除
		$(document).on("click", ".delete_btn", function() {
			var empName = $(this).parents("tr").find("td:eq(2)").text();

			if (confirm("确认删除[" + empName + "]吗?")) {
				$.ajax({
					url : "${APP_PATH}/delete/" + $(this).attr("empid"),
					type : "POST",
					success : function() {
						to_page(currentPage);
					}
				});
			}

		});

		//完成全选全不选
		$("#check_all").click(function() {

			$(".check_item").prop("checked", $(this).prop("checked"));
		});
		//点击单个checkbox
		$(document)
				.on(
						"click",
						".check_item",
						function() {

							var flag = $(".check_item:checked").length == $(".check_item").length;
							$("#check_all").prop("checked", flag);

						});

		//点击删除按钮
		$("#emp_delete_all").click(
				function() {
					var empNames = "";
					var del_ids = "";
					$.each($(".check_item:checked"), function() {

						//寻找标签下第三个td标签
						empNames += ($(this).parents("tr").find("td:eq(2)")
								.text())
								+ ",";

						del_ids += ($(this).parents("tr").find("td:eq(1)")
								.text())
								+ "-";

					});

					empNames = empNames.substring(0, empNames.length - 1);
					del_ids = del_ids.substring(0, del_ids.length - 1);

					if ((empNames != "") && (del_ids != "")) {
						if (confirm("确定删除" + empNames + "吗?")) {
							$.ajax({
								url : "${APP_PATH}/delete/" + del_ids,
								type : "POST",
								success : function() {
									to_page(currentPage);
								}

							});
						}

					} else {
						alert("请选择员工");
					}

				});

		//查出所有部门的信息并显示在列表中
		function getDepts(id) {
			$(id).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {
					console.log(result);
					$.each(result.extend.depts, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						optionEle.appendTo(id);
					});

				}
			});
		}
		/*
		 *添加员工校验数据是否正确格式
		 */

		function validate_add_form() {

			var empName = $("#empName_add_input").val();
			//小写或者大写的a-z或者0-9   或者_或者-  3到16位  或者中文2到5位
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;

			if (!regName.test(empName)) {
				show_validate_msg("#empName_add_input", "error",
						"用户名可以是2-5位中文或者6-16位英文和数字的组合");
				return false;
			} else {

				show_validate_msg("#empName_add_input", "success", "");
			}

			var email = $("#email_add_input").val();
			var regemail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

			if (!regemail.test(email)) {
				show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
				return false;
			} else {
				show_validate_msg("#email_add_input", "success", "");
			}
			return true;

		}

		//显示验证信息
		function show_validate_msg(ele, status, msg) {
			//清除当前元素的检验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text(" ");
			if (status == "success") {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}

		}
		//清空表单样式集内容
		function reset_form(ele) {
			//清除表单数据
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}

		//根据员工的id获取员工的数据
		function getEmp(id) {
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				success : function(result) {
					console.log(result);
					if (result.code == 100) {
						var empDate = result.extend.emp;
						$("#empName_update_input").text(empDate.empName);
						$("#email_update_input").val(empDate.email);
						$("#empUpdateModal input[name=gender]").val(
								[ empDate.gender ]);
						$("#empUpdateModal select").val([ empDate.dId ]);
					}
				}
			});
		}
	</script>
</body>
</html>
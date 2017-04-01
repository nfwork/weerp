<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="dbfound-tags" prefix="d"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<d:includeLibrary />
	</head>
	<script type="text/javascript">
		function login() {
			if (loginForm.form.isValid()) {
				$D.request( {
					url : 'sys/login.execute',
					param : loginForm.getData(),
					callback : function(obj) {
						if (obj.success == true) {
							parent.location.href="index.jsp";
						} else{
							parent.$D.showMessage(obj.message)
						}
					}
				});
			}
		}

		function reset() {
			loginForm.form.reset();
		}
		
		function loadBook(){
			bsSet.baseParams["user_code"] = loginForm.getData().user_code;
			bsSet.reload();
		}
	</script>
	<body style="overflow:hidden">
	
		<d:dataSet id="bsSet" modelName="gl/bookSet" loadData="false" fields="book_set_name,book_set_id" queryName="combo"></d:dataSet>
		
	    <div class="top_table_leftbg" align="center" style="background-color:#306091;height:50px;" >
			<font style="width:200px; height:28px;padding: 5px;" color="#ffffff" size="6"><b>WeERP财务在线</b></font>
		  </div>
		<d:form id="loginForm" labelWidth="60">
			<d:line columnWidth="1">
                 <d:field name="user_code" value="${cookie.user_code.value}" required="true" editor="textfield" prompt="用户名" />
			</d:line>
			<d:line columnWidth="1">
				<d:field name="password" required="true" editor="password" prompt="密码">
				  <d:event name="enter" handle="login"/>
				</d:field>
			</d:line>
			<d:line columnWidth="1">
				<d:field name="book_set_id" options="bsSet" valueField="book_set_id" displayField="book_set_name" required="true" editor="combo" prompt="账套">
				  <d:event name="focus" handle="loadBook"/>
				</d:field>
			</d:line>
			<d:toolBar>
				<d:formButton action="" title="登 录" beforeAction="login"></d:formButton>
				<d:formButton action="" title="重 置" beforeAction="reset"></d:formButton>
			</d:toolBar>
		</d:form>
		<script>
			loginForm.reset();
		</script>
	</body>
</html>

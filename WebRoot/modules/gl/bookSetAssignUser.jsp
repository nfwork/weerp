<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="dbfound-tags" prefix="d"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<d:includeLibrary />
		<style type="text/css">
		 .aa{vertical-align: middle;}
		</style>
	</head>
	<script type="text/javascript">
		function enable(){
			
			var param={"GridData":userGrid1.getSelectionsData()}
			$D.request({
				url:"gl/bookSetAssignUser.execute!enabled?book_set_id=${param.book_set_id}",
				param:param,
				callback:function(){
					userGrid1.query();
					userGrid2.query();
				}
			});
		}
		
		function disable(){
			var param={"GridData":userGrid2.getSelectionsData()}
			$D.request({
				url:"gl/bookSetAssignUser.execute!disabled?book_set_id=${param.book_set_id}",
				param:param,
				callback:function(){
					userGrid1.query();
					userGrid2.query();
				}
			});
		}
	</script>
	<body style="overflow: hidden">
		<d:grid selectFirstRow="false" style="float:left;" width="230" queryUrl="gl/bookSetAssignUser.query!disabled?book_set_id=${param.book_set_id}" title="未分配权限用户" id="userGrid1" height="400" autoQuery="true" navBar="false">
			<d:columns>
				<d:column name="user_id" prompt="用户编号" width="120" />
				<d:column name="user_code" prompt="用户名" width="120" />
			</d:columns>
		</d:grid>
		
		<div style="float:left;width:70px;vertical-align: middle;padding-top:160px;">
			<d:buttonGroup>
				<d:button id="query1" click="enable" width="50"  title="=>" />
			</d:buttonGroup>
			<d:buttonGroup>
				<d:button id="query2" click="disable" width="50" title="<=" />
			</d:buttonGroup>
		</div>
		
		<d:grid selectFirstRow="false" style="float:left;" width="230" queryUrl="gl/bookSetAssignUser.query!enabled?book_set_id=${param.book_set_id}" title="已分配权限用户" id="userGrid2" height="400" autoQuery="true" navBar="false">
			<d:columns>
				<d:column name="user_id" prompt="用户编号" width="100" />
				<d:column name="user_code" prompt="用户名" width="120" />
			</d:columns>
		</d:grid>
	</body>
</html>

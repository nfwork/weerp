<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="dbfound-tags" prefix="d"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<d:includeLibrary />
	</head>
	<script type="text/javascript">
		function query() {
			listGrid.query();
		}
		
		function reset() {
			queryForm.reset();
		}
		
		function isCellEditable(col, row,name,record) {
			if (record.json && ( name == "book_set_code")) {
				return false;
			}else {
				return true;
			}
		}

		var statusStore = new Ext.data.SimpleStore( {
			data : [ [ "Y", "打开" ], [ "N", "关闭" ]],
			fields : [ "status_code", "status_name" ]
		});

		function initData(record,grid){
			record.set("status","N");
		}

		function reload(){
			listGrid.getStore().reload();
		}
		
		//打开分配窗口
		function openAssignWindow(){
			var json = listGrid.getCurrentRecordData();
			url = "modules/gl/bookSetAssignUser.jsp?book_set_id=" + json.book_set_id;
			DBFound.open("assign_window","分配用户",570,450,url);
		}
		
		function operatorRenderer(value, cellmeta, record, row, col, store){
			value = "<a href=" + '"javaScript:openAssignWindow()"'
			+ ">" + "分配用户" + "</a>";
			return value;
		}
	</script>
	<body>
		<d:form id="queryForm" title="查询条件" labelWidth="90">
			<d:line columnWidth="0.33">
				<d:field name="book_set_code" anchor="85%" editor="textfield" lovHeight="445" lovWidth="600" prompt="账套编码">
					 <d:event name="enter" handle="query"/>
				</d:field>
				<d:field name="book_set_name"  anchor="85%" editor="textfield" prompt="账套名称">
				   <d:event name="enter" handle="query"/>
				</d:field>
				<d:field name="status" anchor="85%" editor="combo" options="statusStore" displayField="status_name" valueField="status_code"  prompt="状态" />
			</d:line>
		</d:form>
		
		<d:buttonGroup>
			<d:button id="query" title="查询" click="query" />
			<d:button title="重置" click="reset" />
		</d:buttonGroup>
		
		<d:grid id="listGrid" selectFirstRow="false" forceFit="true" pagerSize="20" autoQuery="true" title="账套列表" model="gl/bookSet" height="$D.getFullHeight('listGrid')" isCellEditable="isCellEditable" queryForm="queryForm" >
			<d:toolBar>
				<d:gridButton type="add" afterAction="initData"/>
				<d:gridButton type="save"/>
			</d:toolBar>
			<d:columns>
				<d:column name="book_set_code" width="150" sortable="true" required="true" editor="textfield"  prompt="账套编码" />
				<d:column name="book_set_name" width="250" sortable="true" required="true" editor="textfield" prompt="账套名称" />
				<d:column name="status" required="true" width="120" align="center" editor="combo" options="statusStore" displayField="status_name" valueField="status_code" prompt="状态" />
				<d:column name="operator" align="center" sortable="true" required="true" prompt="操作" width="80" renderer="operatorRenderer" />
				<d:column name="last_update_date" align="center" prompt="最后修改时间" width="120" />
				<d:column name="last_update_user" align="center" prompt="最后经手人" width="130" />
			</d:columns>
		</d:grid>
		
	</body>
</html>

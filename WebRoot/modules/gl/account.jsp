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
			if (record.json && ( name == "account_code" ||  name == "account_type")) {
				return false;
			} else {
				return true;
			}
		}

		var balanceDirectionStore = new Ext.data.SimpleStore( {
			data : [ [ "借", "借" ], [ "贷", "贷" ] ],
			fields : [ "code", "name" ]
		});
		
		var endAdjustStore = new Ext.data.SimpleStore( {
			data : [ [ "是", "是" ], [ "否", "否" ] ],
			fields : [ "code", "name" ]
		});
	</script>
	<body>
		
		<d:initProcedure>
			<d:set name="code" value="ACCOUNTTYPE" scope="param"/>
	    	<d:dataSet id="accountTypeStore" modelName="fnd/sourceCode" queryName="combo"/>
	    </d:initProcedure>
	    
		<d:form id="queryForm" title="查询条件" labelWidth="90">
			<d:line columnWidth="0.25">
				<d:field name="account_code" anchor="85%" editor="textfield" lovHeight="445" lovWidth="600" prompt="科目编码">
					 <d:event name="enter" handle="query"/>
				</d:field>
				<d:field name="account_name"  anchor="85%" editor="textfield" prompt="科目名称">
				   <d:event name="enter" handle="query"/>
				</d:field>
				<d:field name="account_type" anchor="85%" editor="combo" options="accountTypeStore" displayField="code_name" valueField="code_value" prompt="科目类型" >
					 <d:event name="select" handle="query"/>
				</d:field>
			</d:line>
		</d:form>
		
		<d:buttonGroup>
			<d:button id="query" title="查询" click="query" />
			<d:button title="重置" click="reset" />
		</d:buttonGroup>
		
		<d:grid id="listGrid" selectFirstRow="false" forceFit="true"  pagerSize="10" autoQuery="true" title="费用科目列表" model="gl/account" height="$D.getFullHeight('listGrid')" isCellEditable="isCellEditable" queryForm="queryForm" >
			<d:toolBar>
				<d:gridButton type="add"/>
				<d:gridButton type="save"/>
				<d:gridButton type="excel"/>
			</d:toolBar>
			<d:columns>
				<d:column name="account_code" width="110" sortable="true" required="true" editor="textfield"  prompt="科目编码" />
				<d:column name="account_name" width="150" sortable="true" required="true" editor="textfield" prompt="科目名称" />
				<d:column name="account_type" required="true" width="90" editor="combo" options="accountTypeStore" displayField="code_name" valueField="code_value" prompt="科目类型" />
				<d:column name="balance_direction" editable="false" width="70" editor="combo" options="balanceDirectionStore" displayField="name" valueField="code" prompt="余额方向" />
				<d:column name="end_adjust" width="70" editable="false" editor="combo" options="endAdjustStore" displayField="name" valueField="code" prompt="期末调汇" />
				<d:column name="account_description" width="300" editor="textfield" prompt="科目描述" />
				<d:column name="last_update_date" align="center" prompt="最后修改时间" width="120" />
				<d:column name="last_update_user" align="center" prompt="最后经手人" width="100" />
			</d:columns>
		</d:grid>
		
	</body>
</html>

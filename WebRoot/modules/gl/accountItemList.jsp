<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="dbfound-tags" prefix="d"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<d:includeLibrary />
		<jsp:include page="../base/numberFormat.jsp"></jsp:include>
	</head>
	<script type="text/javascript">

		var index = 0;
	
		function query() {
			itemGrid.query();
		}
		function formReset() {
			queryForm.reset();
		}
		function openAddWindow(){
			var url = "modules/gl/accountItemDetail.jsp";
			DBFound.open("update_window","费用明细",750,500,url);
		}
		function openUpdateWindow(){
			var datas = itemGrid.getSelectionsData(true);
			if(datas.length==0){
				$D.showMessage("必须选中一行数据");
				return;
			}
			var url = "modules/gl/accountItemDetail.jsp?item_id="+datas[0].item_id;
			DBFound.open("update_window","费用明细",750,500,url);
		}
		function reload(){
			itemGrid.getStore().reload();
		}
		function moveLast(){
			index = -1;
			var bar = itemGrid.getBottomToolbar();
			if(bar.store.data.length>0){
				bar.moveLast();
			}else{
				bar.moveFirst();
			}
		}
		
		function statusRenderer(value, cellmeta, record, row, col, store){
			if(value == 'N'){
				return "新建";
			}else if(value == 'B'){
				return "已打回";
			}else if(value == 'P'){
				return "<font color='green'>已审核</font>"
			}else if(value == 'S'){
				return "已提交";
			}else if(value == 'C'){
				return "<font color='red'>已取消</font>";
			}
		}
		
		var statusStore = new Ext.data.SimpleStore( {
			data : [ [ "N", "新建" ], [ "S", "已提交" ] , [ "P", "已审核" ] , [ "B", "已打回" ], [ "C", "已取消" ]],
			fields : [ "status_code", "status_name" ]
		});
	</script>
	<body>
	    <d:initProcedure>
		    <d:dataSet id="periodStore" modelName="gl/period" queryName="comboAll" />
		    <d:query rootPath="periods" modelName="gl/public" queryName="getDefaultPeriod"/>
		    <d:dataSet id="accountStore" modelName="gl/account" queryName="combo" />
	    </d:initProcedure>
	    
	    <d:form id="queryForm" title="查询条件" labelWidth="80">
			<d:line columnWidth="0.25">
				<d:field editor="numberfield" name="item_num" prompt="凭证号" anchor="95%">
					<d:event name="enter" handle="query"></d:event>
				</d:field>
				<d:field editor="textfield" name="description" prompt="凭证抬头" anchor="95%">
					<d:event name="enter" handle="query"></d:event>
				</d:field>
				<d:field name="timefrom" anchor="95%" editor="datefield" prompt="费用日期从" />
				<d:field name="timeto" anchor="95%" editor="datefield" prompt="费用日期到" />
			</d:line>
			<d:line columnWidth="0.25">
				<d:field name="period_id" editable="false" options="periodStore" valueField ="period_id" displayField="period_name" anchor="95%" editor="combo" prompt="会计期间" />
				<d:field name="account_id" editable="false" options="accountStore" anchor="95%" valueField ="account_id" displayField="account_desc" editor="combo" prompt="会计科目" />
				<d:field name="status" anchor="95%" editor="combo" options="statusStore" displayField="status_name" valueField="status_code"  prompt="状态" />
			</d:line>
		</d:form>
		
		<d:buttonGroup>
			<d:button id="query" title="查询" click="query" />
			<d:button title="重置" click="formReset" />
		</d:buttonGroup>
		
	    <d:grid id="itemGrid" title="凭证查询" forceFit="false" singleSelect="true" selectFirstRow="false" pagerSize="10" queryForm="queryForm" model="gl/accountItemList" autoQuery="true" height="$D.getFullHeight('itemGrid')">
			<d:toolBar>
			   <d:gridButton type="excel" />
			</d:toolBar>
			<d:columns>
				<d:column name="item_num" sortable="true" prompt="凭证号" width="90" />
				<d:column name="period_name" sortable="true" prompt="会计期间" width="90" />
				<d:column name="exp_time" sortable="true" prompt="费用日期" width="90" />
				<d:column name="account_desc" sortable="true" prompt="科目名称" width="180" />
				<d:column name="dr_amount"  renderer="formatCurrency" align="right" sortable="true" prompt="借方金额（元）" width="110" />
				<d:column name="cr_amount"  renderer="formatCurrency" align="right" sortable="true" prompt="贷方金额（元）" width="110" />
				<d:column name="description" prompt="凭证抬头" width="200" />
				<d:column name="line_description" prompt="行描述" width="200" />
				<d:column name="status" renderer="statusRenderer" sortable="true" prompt="状态" width="70" />
				<d:column name="regiest_user" sortable="true" prompt="登记人" width="60" />
				<d:column name="regist_time" sortable="true" prompt="登记时间" width="140" />
				<d:column name="approve_user" sortable="true" prompt="审批人" width="60" />
				<d:column name="approve_time" sortable="true" prompt="审批时间" width="140" />
			</d:columns>
		</d:grid>
	</body>
</html>

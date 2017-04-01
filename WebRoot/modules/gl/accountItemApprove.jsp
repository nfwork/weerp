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
	</script>
	<body>
	     <d:initProcedure>
		    <d:dataSet id="periodStore" modelName="gl/period" queryName="combo" />
		    <d:query rootPath="periods" modelName="gl/public" queryName="getDefaultPeriod"/>
	    </d:initProcedure>
	    
	    <d:form id="queryForm" title="查询条件" labelWidth="80">
			<d:line columnWidth="0.2">
				<d:choose>
					<d:field name="period_id" editable="false" required="true" value="${periods[0].period}" options="periodStore" valueField ="period_id" displayField="period_name" anchor="95%" editor="combo" prompt="会计期间" />
				</d:choose>
				<d:field editor="numberfield" name="item_num" prompt="凭证号" anchor="95%">
					<d:event name="enter" handle="query"></d:event>
				</d:field>
				<d:field editor="textfield" name="description" prompt="凭证抬头" anchor="95%">
					<d:event name="enter" handle="query"></d:event>
				</d:field>
				<d:field name="timefrom" anchor="95%" editor="datefield" prompt="费用日期从" />
				<d:field name="timeto" anchor="95%" editor="datefield" prompt="费用日期到" />
				<d:field editor="hidden" name="status" value="S"></d:field>
			</d:line>
		</d:form>
		
		<d:buttonGroup>
			<d:button id="query" title="查询" click="query" />
			<d:button title="重置" click="formReset" />
		</d:buttonGroup>
		
	    <d:grid id="itemGrid" title="凭证登记" selectFirstRow="false" pagerSize="10" queryForm="queryForm" model="gl/accountItemApprove" autoQuery="true" height="310">
			<d:toolBar>
			   <d:gridButton icon="DBFoundUI/images/check.png" title="审核" action="gl/accountItemOpear.execute!approve" afterAction="query" />
			   <d:gridButton icon="DBFoundUI/images/remove.gif" title="打回" action="gl/accountItemOpear.execute!return" afterAction="query" />
			</d:toolBar>
			<d:columns>
				<d:column name="item_num" sortable="true" prompt="凭证号" width="80" />
				<d:column name="period_name" sortable="true" prompt="会计期间" width="80" />
				<d:column name="exp_time" sortable="true" prompt="费用日期" width="100" />
				<d:column name="description" prompt="凭证抬头" width="300" />
				<d:column name="regiest_user" sortable="true" prompt="登记人" width="100" />
				<d:column name="regist_time" sortable="true" prompt="登记时间" width="120" />
			</d:columns>
		</d:grid>
		
		<d:grid id="lineGrid" navBar="false" selectFirstRow="false" queryForm="queryForm" title="凭证明细" pagerSize="10" model="gl/accountItemLine" height="$D.getFullHeight('lineGrid')">
			<d:columns>
				<d:column name="account_desc" sortable="true" prompt="科目名称" width="180" />
				<d:column name="dr_amount" renderer="formatCurrency" align="right" sortable="true" prompt="借方金额（元）" width="130" />
				<d:column name="cr_amount" renderer="formatCurrency" align="right" sortable="true" prompt="贷方金额（元）" width="130" />
				<d:column name="description" prompt="行描述" width="400" />
				<d:column name="regiest_user" sortable="true" prompt="登记人" width="130" />
				<d:column name="regist_time" sortable="true" prompt="登记时间" width="150" />
			</d:columns>
		</d:grid>
	    
	    <script type="text/javascript">
	    	itemGrid.getSelectionModel().on("rowselect",function(){
				var item_id = itemGrid.getCurrentRecordData().item_id;
				if(item_id!=null){
					queryForm.setData({item_id:item_id});
					lineGrid.query();
				}
			});
			itemGrid.on("rowclick",function(grid,rowIndex){index = rowIndex;});
	    	itemGrid.getStore().on("load",function(){
		    	if(index == -1){
		    		itemGrid.getSelectionModel().selectLastRow();
		    	}else{
	    			itemGrid.getSelectionModel().selectRow(index);
		    	}
		    });
		</script>
	</body>
</html>

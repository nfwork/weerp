<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="dbfound-tags" prefix="d"%>

<!DOCTYPE HTML>
<html>
	<head>
		<d:includeLibrary />
		<script type="text/javascript" src="DBFoundUI/chart/jquery.min.js"></script>
		<script src="DBFoundUI/chart/highcharts.js"></script>
	</head>
	<d:initProcedure>
		    <d:query rootPath="periods" modelName="gl/public" queryName="getDefaultPeriod"/>
		    <d:dataSet id="dataStore" loadData="false" modelName="report/amountAnalysis" />
	 </d:initProcedure>

	<script type="text/javascript">
		function query() {
			dataStore.baseParams["period_id"]="${periods[0].period}";
			dataStore.reload();
		}
		var yAxis = [ {
			name : '本期费用分布',
			field : 'emerge_amount'
		}];
		var xAxis = {
			name : '元',
			field : 'account_name'
		};
		Ext.onReady(query);

	</script>
	<body>
			<d:barChart style="margin-right:0px" valueSuffix="元" title="本期费用柱状图" rotation="-60" yAxis="yAxis" xAxis="xAxis" height="550" bindTarget="dataStore" />
	</body>
</html>

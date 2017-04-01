<title>WeERP财务在线</title>
<base href="${basePath}"/>
<script type='text/javascript' src='${basePath}DBFoundUI/ext-base.js' charset='utf-8'></script>
<script type='text/javascript' src='${basePath}DBFoundUI/ext-all.js' charset='utf-8'></script>
<script type='text/javascript' src='${basePath}DBFoundUI/ext-lang-zh_CN.js' charset='utf-8'></script>
<script type='text/javascript' src='${basePath}DBFoundUI/dbfound-base.js' charset='utf-8'></script>
<script type="text/javascript" src="${basePath}DBFoundUI/dbfound-grid.js" charset='utf-8'></script>
<script type="text/javascript" src="${basePath}DBFoundUI/plugin/SpinnerField.js" charset='utf-8'></script>
<script type="text/javascript" src="${basePath}DBFoundUI/plugin/DateTimeField.js" charset='utf-8'></script>
<script type="text/javascript" src="${basePath}DBFoundUI/plugin/LovCombo.js" charset='utf-8'></script>
<link rel='stylesheet' href='${basePath}DBFoundUI/resources/css/ext-all.css'type='text/css'/>
<link rel='stylesheet' href='${basePath}DBFoundUI/resources/css/dbfound.css'type='text/css'/>
<script type="text/javascript">
	Ext.Ajax.on("requestcomplete",function(conn,response,option){
		var obj = Ext.util.JSON.decode(response.responseText);
		if(obj.timeout){DBFound.open("login_window","登录超时，请重新登录",400,250,"${basePath}relogin.jsp?ajax=1");}
	});
</script>
<style>
	a{text-decoration: none;}
	a:hover{text-decoration:underline}
</style>
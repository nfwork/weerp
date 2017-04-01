<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="dbfound-tags" prefix="d"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<d:includeLibrary />
</head>
<script type="text/javascript">
	function importAccount() {
		if (uploadform.form.isValid()) {
			Ext.getBody().mask('正在上传附件，请耐心等待.......', 'x-mask-loading');
			uploadform.form.submit({
				url : 'gl/accountImport.execute',
				method : 'post',
				success : function(response, action) {
					Ext.getBody().unmask();
					$D.showMessage("科目初始化导入完成");
				},
				failure : function(response, action) {
					Ext.getBody().unmask();
					alert(action.result.message + "!");
				}
			});
		} else {
			$D.showMessage('请选择上传文件！');
		}
	}
	
	function reset(){
		uploadform.reset();
	}
</script>
<body>

	<d:form title="客户导入" id="uploadform" width="400" labelWidth="70" fileUpload="true">
		<d:line columnWidth="1">
			<d:field name="file" width="280" required="true" prompt="excel文件" editor="file" />
		</d:line>
	</d:form>

	<d:buttonGroup>
		<d:button id="query" title="提交" click="importAccount" />
		<d:button title="重置" click="reset" />
	</d:buttonGroup>

</body>
</html>

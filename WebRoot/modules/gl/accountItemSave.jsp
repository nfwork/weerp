<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="dbfound-tags" prefix="d"%>
<d:controlBody>
	<d:execute modelName="gl/accountItemRegist" executeName="save" />
	<d:batchExecute modelName="gl/accountItemLine" sourcePath="param.lineDatas"></d:batchExecute>
</d:controlBody>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<title>MyERP财务系统</title>
<script type="text/javascript">
	function add(num1,num2){
       var r1,r2,m;
       try{r1 = num1.toString().split('.')[1].length;}catch(e){r1 = 0;}
       try{r2=num2.toString().split(".")[1].length;}catch(e){r2=0;}
       m=Math.pow(10,Math.max(r1,r2));
       // return (num1*m+num2*m)/m;
       return Math.round(num1*m+num2*m)/m;
    }
	
	function getFullHeight(){
		var height = 0;
		if(document.documentElement && document.documentElement.clientHeight>height){
			height = document.documentElement.clientHeight;
		}
		if(document.body && document.body.clientHeight>height){
			height=document.body.clientHeight;
		}
		return height;
	}
	 
</script>
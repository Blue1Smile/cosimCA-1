<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commons/cloud/global.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>协同服务</title>
    <script type="text/javascript">    
    	function getQueryString(name){
    	    var url = top.location.href;
    	    url = url.substring(url.indexOf("?")+1);
    	    var paras = url.split("&");
    	    var params = {};
    	    for(var i=0;i<paras.length;i++){
    	        var str = paras[i];
    	        var l = str.indexOf("=");
    	        params[str.substring(0,l)] = str.substring(l+1); 
    	    }
    	    var value = params[name];
    	    if(typeof(value) == "undefined")
    	        return "";
    	    
    	    return value;
    	}
    	
    	var target = getQueryString('target');
    	if(target){
    		location.href='${ctx}' + target;
    	}
    </script>
  </head>
  <body>
  	欢迎页面
  </body>
</html>

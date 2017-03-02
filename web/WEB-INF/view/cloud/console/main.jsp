<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/commons/cloud/global.jsp"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>协同设计</title>
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

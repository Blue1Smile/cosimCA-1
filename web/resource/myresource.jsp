<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/common/global.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String service = (String)request.getAttribute("software");	
    String userName = (String)request.getAttribute("userName");	
    String VM_IP_Address=(String)request.getAttribute("VM_IP_Address");
    String userPw = (String)request.getAttribute("userPw");
	String _uri= request.getParameter("_uri");
	String url="";
	if(userName==null){
		url= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/resource/abc.action";
	}
	String jsp_action_url=VM_IP_Address+"/cloud/hpc/com.portal.services.xml?_uri=//com.portal.services/login";
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<%@ include file="/common/meta.jsp"%>
<title>汽车行业软件</title>
<script type="text/javascript" src="${ctx}/js/jquery-1.2.4b.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var url="<%=url%>";
		if(url.length > 0 ){
			    $(".sq_left_img01").click(function(){
					$("#mainframe").attr("src","<%=url%>");
			    });
				
				$(".sq_left_img02").click(function(){
					$("#mainframe").attr("src","<%=url%>");
				});
				
				$(".sq_left_img03").click(function(){
					$("#mainframe").attr("src","<%=url%>");
				});
				
				 $(".sq_left_img04").click(function(){
					 $("#mainframe").attr("src","<%=url%>");
				});
		}else{
			    $(".sq_left_img01").click(function(){
	/*				$("#mainframe").attr("src","<%=VM_IP_Address%>"+"/cloud/hpc/efviews_desktop_th.xml?_uri=//efviews_desktop/config");*/
					$("#mainframe").attr("src","<%=VM_IP_Address%>"+"/cloud/hpc/efviews_desktop_th.xml?_uri=//efviews_desktop/efviews.list.sessions&_ui=&_filter=");
			    });
				
				$(".sq_left_img02").click(function(){
					$("#mainframe").attr("src","<%=VM_IP_Address%>"+"/cloud/hpc/com.portal.services_th.xml?_uri=//com.cloud.grid/list.jobs&EF_GRIDML_COMPRESS=yes");
				});
				
				$(".sq_left_img03").click(function(){
					$("#mainframe").attr("src","<%=VM_IP_Address%>"+"/cloud/hpc/com.data.system_th.xml?_uri=//com.data.system/list.spoolers&_ui=&_countHiddenFiles=false");
				});
				
				 $(".sq_left_img04").click(function(){
						$("#mainframe").attr("src","<%=VM_IP_Address%>"+"/cloud/hpc/com.cluster.monitor.th.xml?_uri=//com.cluster.monitor/list.hosts");
				});	
		}
		$(".sq_left_content01").click(function(){
			$("#mainframe").attr("src","${ctx}/resource/softList.action?softType=fluent_normal&VM_IP_Address="+"<%=VM_IP_Address%>");
		});
		
		$(".sq_left_content02").click(function(){
			$("#mainframe").attr("src","${ctx}/resource/softList.action?softType=abaqus&VM_IP_Address="+"<%=VM_IP_Address%>");
		});
		
		$(".sq_left_content03").click(function(){
			$("#mainframe").attr("src","${ctx}/resource/softList.action?softType=ansys&VM_IP_Address="+"<%=VM_IP_Address%>");
		});
		
		$(".sq_left_content04").click(function(){
			$("#mainframe").attr("src","${ctx}/resource/softList.action?softType=nastran&VM_IP_Address="+"<%=VM_IP_Address%>");
		});
		
		$(".sq_left_content05").click(function(){
			$("#mainframe").attr("src","${ctx}/resource/softList.action?softType=fastran&VM_IP_Address="+"<%=VM_IP_Address%>");
		});
		
		$(".sq_left_content06").click(function(){
			$("#mainframe").attr("src","${ctx}/resource/softList.action?softType=feko&VM_IP_Address="+"<%=VM_IP_Address%>");
		});
	});
</script>
</head>
<body   onload="loginSubmit();">
<script language="javascript">
function loginSubmit()
{
	var loginform=document.forms["loginform"];
	loginform._username.value="<%=userName%>";
	loginform._password.value="<%=userPw%>";
	loginform.submit();
}
</script>

<form action="<%=jsp_action_url%>" target="hiddenIframe" method="post" name="loginform">
<input name="_username" type="hidden" />
<input name="_password" type="hidden" />
</form>
<iframe  src="" id="hiddenIframe" name="hiddenIframe" style="display:none;"></iframe>
<%@include file="/common/top.jsp"%>

<!-- 页面主体  开始 -->
<div id="main">
	<div style="margin:0 auto; width:150px; float:left; ">
		<div id="sq_left"><!--
		    <div class="sq_left_img04"><div class="sq_btn01"><a href="#" class="linkblue">资源监控</a></div></div>
            <div class="clear_10"></div>
        	<div class="sq_left_img01"><div class="sq_btn01"><a href="#" class="linkblue">桌面管理</a></div></div>
            <div class="clear_10"></div>
            --><div class="sq_left_img02"><div class="sq_btn01"><a href="#" class="linkblue">作业管理</a></div></div>
            <div class="clear_10"></div>
            <div class="sq_left_img03"><div class="sq_btn01"><a href="#" class="linkblue">数据管理</a></div></div>
            <div class="clear_10"></div>
            <div class="sq_left_img05"><div class="sq_btn01"><a href="#" class="linkblue">虚拟应用</a></div></div>
            <div class="clear_10"></div>
            
            <div class="sq_left_title">常用软件</div>
            <div class="sq_left_content">
                <div class="sq_left_content01"><a href="#" class="link04">Fluent</a></div>
                <div class="sq_left_content02"><a href="#" class="link04">Abaqus</a></div>
                <div class="sq_left_content03"><a href="#" class="link04">Ansys</a></div>
                <div class="sq_left_content04"><a href="#" class="link04">Nastran</a></div>
                <div class="sq_left_content05"><a href="#" class="link04">Fastran</a></div>
                <div class="sq_left_content06"><a href="#" class="link04">Feko</a></div>
                <div class="sq_left_content01"><a href="#" class="link04">HFSS</a></div>
                <div class="sq_left_content01"><a href="#" class="link04">CST</a></div>
                <div class="sq_left_content01"><a href="#" class="link04">UG NX</a></div>
                <div class="sq_left_content01"><a href="#" class="link04">Pro/E</a></div>
                <div class="sq_left_content01"><a href="#" class="link04">Catia</a></div>
                <div class="sq_left_content01"><a href="#" class="link04">Openworks</a></div>
            </div>
        </div>

    </div>
    <div style="margin:0 auto; width:865px; float:right;height:100%;">
        	<iframe  id="mainframe" border="0"  src="${ctx}/resource/softList.action?softType=fluent_normal&VM_IP_Address=<%=VM_IP_Address%>" style="width:100%;height:640px;overflow-x:hidden" frameborder="0" scrolling="auto"></iframe>
   	  </div>
    </div>
<!-- 页面主体  结束 -->
<!-- 底部版权区  开始 -->
<%@ include file="/commons/cloud/foot.jsp"%>
<!-- 底部版权区  结束 -->
</body>
</html>

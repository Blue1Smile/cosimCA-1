<%@ include file="/commons/cloud/checkIE.jsp"%>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
.header_input{
	width:475px; height:22px; font-size:14px; color:#999; padding:4px; line-height:22px;
}
.header_input1{
	width:370px; height:22px; font-size:14px; color:#999; padding:4px; line-height:22px;
}
.sel{
   color: #999;font-size:14px;height:32px;line-height:32px;
}
.null{display: none;font-size:14px;}
</style>
<script type="text/javascript">
var svalue="搜索企业";
$(document).ready(function(){	
	 	$(".sel").addClass("null");
		$("#resource").click(function(){
		    $(".header_input").removeClass("header_input1");
		    $(".sel").addClass("null");
			$(".header_input").val("搜索资源");
			$("#search1 form").attr("action","${ctx}/cloud/config/cloudSrc/search.ht");
			svalue = "搜索资源";
		});
		
		$("#ability").click(function(){
		    $(".header_input").removeClass("header_input1");
		    $(".sel").addClass("null");
		  
			$(".header_input").val("搜索能力");
			$("#search1 form").attr("action","${ctx}/cloud/config/capability/search.ht");
			svalue = "搜索能力";
		});
		
		$("#chance").click(function(){
		    $(".header_input").addClass("header_input1"); 
	        $(".sel").removeClass("null");
			$(".header_input").val("搜索商机");
			$("#search1 form").attr("action","${ctx}/cloud/config/business/search.ht");
			svalue = "搜索商机";
		});
		
		$("#company").click(function(){
			$(".header_input").removeClass("header_input1");
			$(".header_input").addClass("header_input");
		    $(".sel").addClass("null");
			$(".header_input").val("搜索企业");
			$("#search1 form").attr("action","${ctx}/cloud/system/enterprises/search.ht");
			svalue = "搜索企业";
		});
		
		$(".header_input").focus(function(){
		    $(".sel").addClass("null");
		   
			var type = $(".header_input").attr("value");
			if (type==svalue){
				this.value='';
				this.className='header_input';
			}
			if(svalue == "搜索商机"){
				$(".sel").removeClass("null");
				$(".header_input").addClass("header_input1");
			}
			 
			  
		});
		
		$(".header_input").blur(function(){
			var type = $(".header_input").attr("value");
			if (type==''){
				this.value=svalue;
			}
		});
		
		$("#company").addClass("tab_menu_focus");
		$(".tab_menu").click(function(){
			var index = $(".tab_menu").index($(this));
			$(".tab_menu").removeClass("tab_menu_focus");
			$(".tab_menu:eq("+index+")").addClass("tab_menu_focus");
		});
	});
	
</script>

<style type="text/css">
	#header .serch .serch_01{
	float:left; width:550px; height:38px; vertical-align:bottom; padding-left:49px;
	*height:20px; /* ie6 Hack */
	}
	#header .tab{
	float:left;
	margin-top: 16px;
	padding-left:0px;
	*padding-left:40px; *margin:0; /* ie6 Hack */
}
</style>
<!-- 顶部浮动层  开始 -->
<div id="status_bar">
  <div class="status_bar_01">
    <div class="status_bar_02"><a href="${ctx}/index.ht" class="link01">首页</a></div>
    <div class="status_bar_02"><c:if test="${not empty SPRING_SECURITY_LAST_USERNAME}">欢迎您，<sec:authentication property="principal.fullname" />，

    <a href="${ctx}/logout" class="link01">注销</a></c:if></div>
    <!-- 
    <div class="status_bar_03">
    	<select class="input_0427">
    		<option>中文</option>
    		<option>English</option>
    		<option>Japanese</option>
    	</select>
    </div>
     -->
  <div class="status_bar_03"><a href="${ctx}/contactus.jsp" class="link01">联系客服</a></div>
   	<div class="status_bar_03"><a href="${ctx}/help/help_about01.jsp" class="link01" target="_blank">帮助中心</a></div>
    <div class="status_bar_03"><a href="${ctx}/cloud/console/home.ht" class="link01">个人主页</a></div>
  </div>
</div>
<div class="clear_25"></div>
<!-- 顶部浮动层  结束 -->
<!-- header  开始 -->
<div id="header">
  <div class="logo"><a href="${ctx}/index.ht"><img src="${ctx}/images/tianhe_logo.png" width="252" height="52"  longdesc="返回首页" style="border:0" /></a></div>
  <div class="logo2">
  </div>
  <div class="serch">
    <div class="serch_01">
      <ul class="tab">
        <li class="tab_menu" id="company">企业</li>
        <li class="tab_menu" id="chance">商机</li>        
        <li class="tab_menu" id="ability">能力</li>
         <li class="tab_menu" id="resource">资源</li>
      </ul>
    </div>
    <div id="search1" class="serch_02">
      <form action="${ctx}/cloud/system/enterprises/search.ht" method="post">
        <span class="serch_03">
		        <select class="sel" name="select" style="font-size:14px; color:#999; padding:4px; line-height:22px; border:#1f73b9 2px solid;">
		        	<option value="caigou">采购商机</option>
		        	<option value="yingxiao">营销商机</option>
		        	<option value="shengchan">生产商机</option>
		        	<option value="fuwu">服务商机</option>
		        	<option value="yanfa">研发商机</option>
		        </select>
		        <input class="header_input" value="搜索企业" name="username">
		    </span>
	        <span class="serch_04">
	        	<input type="submit" class="header_btn" id="button" value="" border="0" />
	        </span>
      </form>
      </div>
  </div>
</div>
<div class="clear_10"></div>
<!-- header  结束 -->
<!-- 主导航  开始 -->
<div id="nav">
  <div class="navbar">
    <ul class="nav01">  
    <!-- 
    <li>
      	<a href="${ctx}/cloud/console/outline.ht?resId=${resourcesItem.resId}" class="nav02">个人主页</a>
    </li>
    <li>
      	<a href="${ctx}/cloud/console/outline.ht?resId=${resourcesItem.resId}" class="nav02">商圈管理</a>
    </li>
     -->    
    <c:forEach items="${resourcesList}" var="resourcesItem">
    <c:if test="${resourcesItem.parentId==0}">
      <li>
      <c:choose>
      	<c:when test="${empty resourcesItem.defaultUrl}">
      	<a href="${ctx}/cloud/console/outline.ht?resId=${resourcesItem.resId}" class="nav02">
      	</c:when>
      	<c:otherwise>
      	<c:choose>      	
      	<c:when test="${fn:indexOf(resourcesItem.defaultUrl,'?')!=-1}"> 
      		<a href="${ctx}${resourcesItem.defaultUrl}&resId=${resourcesItem.resId}" class="nav02">
      	</c:when>
      	<c:otherwise>
      		<a href="${ctx}${resourcesItem.defaultUrl}?resId=${resourcesItem.resId}" class="nav02">
      	</c:otherwise>
      	</c:choose>
      	</c:otherwise>
      </c:choose>
      ${resourcesItem.resName}</a></li>
    </c:if>
	</c:forEach> 
	<!-- 
	<div class="gg_521"><span style="color:red;font-size:14px;"><MARQUEE onmouseout=this.start()   onmouseover=this.stop()>最新商机统计：${chanceCount}条 最新业务量统计：1123条</MARQUEE></span></div>
	 -->
    </ul>    
  </div>
</div>
<div class="clear_10"></div>
<!-- 主导航  结束 -->
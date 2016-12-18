<%@ include file="/commons/cloud/checkIE.jsp"%>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
.header_input{
	width:475px; height:22px; font-size:14px; color:#999; padding:4px; line-height:22px;
}
.header_input1{
	width:373px; height:22px; font-size:14px; color:#999; padding:4px; line-height:22px;
}
.sel{
   color: #999;font-size:14px;height:32px;line-height:32px;
}
.null{display: none;font-size:14px;}


* { 
padding:0; 
margin:0; 
} 

#navigation, #navigation li ul { 
list-style-type:none; 
} 
#navigation { 
margin:20px; 

} 
#navigation li { 
float:left; 
text-align:center; 
position:relative; 
z-index:1;
font-size: 14px;
font-weight: bold;
} 
#navigation li a:link, #navigation li a:visited { 
display:block; 
text-decoration:none; 
color:#000; 
width:102px; 
height:30px; 
line-height:40px; 
border:1px solid #fff; 
border-width:1px 1px 0 0; 
background:#c5dbf2; 
padding-left:10px; 
} 
#navigation li a:hover { 
color:#fff; 
background:#2687eb; 
} 
#navigation li ul li a:hover { 
color:#fff; 
background:#6b839c; 
} 
#navigation li ul { 
display:none; 
position:absolute; 
top:40px; 
left:0; 
margin-top:1px; 
width:120px; 
} 
#navigation li ul li ul { 
display:none; 
position:absolute; 
top:0px; 
left:130px; 
margin-top:0; 
margin-left:1px; 
width:120px; 
} 

#navigation{ 
display:none; 
} 


</style>

<script type="text/javascript">


function displaySubMenu(li) { 
var subMenu = li.getElementsByTagName("ul")[0]; 
subMenu.style.display = "block"; 
} 
function hideSubMenu(li) { 
var subMenu = li.getElementsByTagName("ul")[0]; 
subMenu.style.display = "none"; 
} 


$("selectId1").toggle( 
  function () { 
    $(this).addClass("curr"); 
  }, 
  function () { 
    $(this).removeClass("curr"); 
  } 
); 
$("selectId2").toggle( 
  function () { 
    $(this).addClass("curr"); 
  }, 
  function () { 
    $(this).removeClass("curr"); 
  } 
); 
$("selectId3").toggle( 
  function () { 
    $(this).addClass("curr"); 
  }, 
  function () { 
    $(this).removeClass("curr"); 
  } 
); 
$("selectId4").toggle( 
  function () { 
    $(this).addClass("curr"); 
  }, 
  function () { 
    $(this).removeClass("curr"); 
  } 
); 

</script>
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
<!-- 顶部浮动层  开始 -->
<div id="status_bar">
  <div class="status_bar_01">
    <div class="status_bar_02"><a href="${ctx}/index.ht" class="link01">首页</a></div>
    <div class="status_bar_02">
    	<c:if test="${not empty SPRING_SECURITY_LAST_USERNAME}">欢迎您，<sec:authentication property="principal.fullname" />，<a href="${ctx}/logout" class="link01">注销</a></c:if>
    	<c:if test="${empty SPRING_SECURITY_LAST_USERNAME}">请<a href="${ctx}/loginCloud.ht" class="link01">登录</a> │ <a href="${ctx}/reg.ht" class="link01">注册</a></c:if>    
    </div>
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
<div id="header" style="*margin-top:30px;">
	<div class="logo">
		<a href="${ctx}/index.ht"><img id="logo" src="${ctx}/images/tianhe_logo.png" width="252" height="52" longdesc="返回首页" style="border:0"></a>
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
	      <form action="${ctx}/cloud/system/enterprises/search.ht" method="post" name="form1">
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
	        <span class="serch_04"><input type="submit" class="header_btn" id="button" value="" border="0" /></span>
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
    	<li><a href="${ctx}/index.ht" class="nav02" id="firstpage">首页</a></li>
    	<li><a href="${ctx}/cloud/config/businessDevchase/businessChance_list.ht" class="nav02">在线商机</a></li>
        <li><a href="${ctx}/cloud/config/capabilityClass/listClasses.ht" class="nav02">在线能力</a></li>
        <li><a href="${ctx}/cloud/cloudresource/resource.ht" class="nav02">在线资源</a></li>
		<li onmouseover="displaySubMenu(this)" onmouseout="hideSubMenu(this)"><a href="#" class="nav02">在线业务</a> 
			<ul id="navigation"> 
				<li><a href="#">研发商机</a></li> 
				<li><a href="#">采购商机</a></li> 
				<li><a href="#">生产商机</a></li> 
				<li><a href="#">营销商机</a></li>
				<li><a href="#">服务商机</a></li> 
				<li><a href="#">在线供应链</a></li>  
			</ul> 
		</li> 
       
    </ul>
     <div class="gg_521">
        	<iframe src="${ctx}/topMarquee.ht" style="width:300px;height:100px;border:0;" frameborder="0" scrolling="no" allowTransparency="false"></iframe>
        </div>
    </div>
</div>
<div class="clear_10"></div>
<!-- 主导航  结束 -->
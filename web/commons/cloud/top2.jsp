<%@ include file="/commons/cloud/checkIE.jsp"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<div id="head">
		<div id="top_info">
			<span>				
				<a href="${ctx}/contactus.jsp" class="link01">联系客服</a>
   				<%-- <a href="${ctx}/help.html" class="link01" target="_blank">帮助中心</a> --%>
    			<a href="${ctx}/cloud/console/home.ht" class="link01">个人主页</a>
			</span>
			<c:if test="${not empty SPRING_SECURITY_LAST_USERNAME}">欢迎您，<a id="username" href="#"><sec:authentication property="principal.fullname" /></a>，<a href="${ctx}/logout" class="link01">注销</a></c:if>
    		<c:if test="${empty SPRING_SECURITY_LAST_USERNAME}">请<a href="${ctx}/loginCloud.ht" class="link01">登录</a> │ <a href="${ctx}/reg.ht" class="link01">注册</a></c:if>
			<!--会员信息框-->
			<div id="userinfobox">
				<a href="#"><img src="${ctx}/skins/avatar.jpg" /></a>
				<p><a href="#">会员名称</a></p>
				<p><a href="#">会员注销</a></p>
			</div>
		</div>
	</div>
	<p class="clear"></p>
	
	<!--搜索表单开始 -->
	<div id="logo_zone">
		<div id="logo_zone_left"><a href="#"><img src="${ctx}/images/tianhe_logo.png"/></a></div>
		<div id="logo_zone_right">
		<form method="" action="${ctx}/cloud/system/enterprises/search.ht">
			<table width="100%">
				<tr>
				<td class="link_type" id="link_type" colspan="2"><a class="on" href="javascript:">企业</a><a href="javascript:">商机</a><a href="javascript:">能力</a><a href="javascript:">资源</a></td>
				
				</tr>
				<tr>
					<td id="typeselecttd" style="display:none">
					<select class="sel" name="select" id="typeselect">
						<option value="caigou">采购商机</option>
						<option value="yingxiao">营销商机</option>
						<option value="shengchan">生产商机</option>
						<option value="fuwu">服务商机</option>
						<option value="yanfa">研发商机</option>
					</select>
					</td>
					<td valign="top"><input fs="搜索商机" id="searchinput" type="text" class="text" name="searchinput"><input class="timg" type="image" src="${ctx}/skins/bg_search.jpg">
					</td>
				</tr>
			</table>
		</form>
	</div>
		<p class="clear"></p>
	</div>
	<!--搜索表单结束 -->
	
	<!--主导航菜单 开始-->
	<div id="mainnav">
		<ul>
			<!--选中状态为class=on<a class="on" href="#">首页</a></li>-->
			<li><a href="${ctx}/index.ht" class="nav02" id="firstpage">首页</a></li>
    		<li><a href="${ctx}/cloud/config/businessDevchase/businessChance_list.ht" class="nav02">在线商机</a></li>
        	<li><a href="${ctx}/cloud/config/capabilityClass/listClasses.ht" class="nav02">在线能力</a></li>
        	<li><a href="${ctx}/cloud/cloudresource/resource.ht" class="nav02">在线资源</a></li>
        	<li><a target="_blank" href="http://www.shangtengwang.com" class="nav02">在线供应链</a></li>
			<p class="clear"></p>
		</ul>
		<iframe src="${ctx}/topMarquee.ht" style=" float:right; width:340px; height:34px;" frameborder="0" scrolling="no" allowTransparency="false"></iframe>

		<script src="${ctx}/skins/slides.min.jquery.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(function(){
				$('#ppt').slides({
					play: 5000,
					pause: 2500,
					generatePagination: true ,
					hoverPause:false
				});
				
				//鼠标点击菜单上的时候
				var cindex=0,changet;
				$('#onlinemenu .ui_tabs_nav a').click(function(){
					
					var index=$('#onlinemenu .ui_tabs_nav a').index($(this))*1+1;
					cindex=index-1;
					$('.tabbox').hide();
					$('#tabbox_'+index).show();
					$('#onlinemenu a.more').attr('href',$(this).attr('link'));
				})
				
				//鼠标放到菜单上面的时候
				$('#onlinemenu .ui_tabs_nav a').mouseover(function(){
					$('#onlinemenu .ui_tabs_nav a').removeClass('on');
					$(this).addClass('on');
					window.clearInterval(changet);
				})
				
				//鼠标移走的时候
				$('#onlinemenu .ui_tabs_nav a').mouseleave(function(){
					changet=window.setInterval(function(){autoshow()},5000)
				})
				
				function autoshow(){
					var bcount=$('#onlinechange .tabbox').size();
					var current=$('#onlinemenu .ui_tabs_nav').find('.on');
					if(!current) {
						cindex=0;
					}else{
						cindex=$('#onlinemenu .ui_tabs_nav a').index(current)+1;
					}
					$('#onlinemenu .ui_tabs_nav a').removeClass('on');
					
					var $menua=$('#onlinemenu .ui_tabs_nav a:eq('+cindex+')');
					$menua.addClass('on');
					//设置更多的连接
					$('#onlinemenu a.more').attr('href',$menua.attr('link'));
					
					$('.tabbox').hide();
					$('#tabbox_'+cindex).show();
					if( cindex==bcount ) {
						$('#onlinemenu .ui_tabs_nav a:first').addClass('on');
					}
				}
				changet=window.setInterval(function(){autoshow()},5000)
			})
	</script>
</div>
<!-- 主导航菜单 结束 -->
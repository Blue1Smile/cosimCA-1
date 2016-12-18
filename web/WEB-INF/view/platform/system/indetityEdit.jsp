<%--
	time:2012-02-03 14:40:59
	desc:edit the 流水号生成
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 流水号生成</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/servlet/ValidJs?form=indetity"></script>
	<script type="text/javascript">
		$(function() {
			function showRequest(formData, jqForm, options) { 
				return true;
			} 
			valid(showRequest,showResponse);
			$("a.save").click(function() {
				$('#indetityForm').submit(); 
			});
			function showResponse(responseText)  { 
				var obj=new com.hotent.form.ResultMessage(responseText);
				if(obj.isSuccess()){//成功
					$.ligerMessageBox.confirm('提示信息',obj.getMessage()+',继续操作吗?',function(rtn){
						if(!rtn){
							var returnUrl=$("#returnUrl").val();
							if($("#returnUrl").length>0 && returnUrl!=""){
								location.href=returnUrl;
								return;
							}
							var linkBack=$("a.back");
							if(linkBack.length>0){
								var returnUrl=linkBack.attr("href");
								if(returnUrl!=""){
									location.href=returnUrl;
									return;
								}
							}
						}
						else{
							if(${indetity.id==0}){
								__valid.resetForm();
							}
						}
					});
					
			    }else{//失败
			    	$.ligerMessageBox.error('出错了',obj.getMessage());
			    }
			} 
		});
	</script>
</head>
<body>
<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">
					<c:choose>
						<c:when test="${indetity.id == 0}">
							添加流水号定义
						</c:when>
						<c:otherwise>
							编辑流水号定义  
						</c:otherwise>
					</c:choose>
				</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<div class="group"><a class="link save" id="dataFormSave" href="#">保存</a></div>
					<div class="l-bar-separator"></div>
					<div class="group"><a class="link back" href="list.ht">返回</a></div>
				</div>
			</div>
		</div>
		<div class="panel-body">
				<form id="indetityForm" method="post" action="save.ht">
					
						<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<th width="20%">名称: </th>
								<td><input type="text" id="name" name="name" value="${indetity.name}"  class="inputText"/></td>
							</tr>
							<tr>
								<th width="20%">别名: </th>
								<td><input type="text" id="alias" name="alias" value="${indetity.alias}"  class="inputText"/></td>
							</tr>
							<tr>
								<th width="20%">规则: </th>
								<td>
									
									<c:choose>
										<c:when test="${indetity.id == 0}">
											<input type="text" id="rule" name="rule" size="80" value="{yyyy}{MM}{dd}{NO}"  class="inputText"/>
										</c:when>
										<c:otherwise>
											<input type="text" id="rule" name="rule" size="80" value="${indetity.rule}"  class="inputText"/>
										</c:otherwise>
									</c:choose>
									<br>
									{yyyy}{MM}{dd}{NO}
									<ul>
										<li>{yyyy}表示年份</li>
										<li>{MM}表示月份，如果月份小于10，则加零补齐，如1月份表示为01。</li>
										<li>{mm}表示月份，月份不补齐，如1月份表示为1。</li>
										<li>{DD}表示日，如果小于10号，则加零补齐，如1号表示为01。</li>
										<li>{dd}表示日，日期不补齐，如1号表示为1。</li>
										<li>{NO}表示流水号，后面补零。</li>
										<li>{no}表示流水号，前面补零。</li>
									</ul>
									
									
								</td>
							</tr>
							<tr>
								<th width="20%">每天生成: </th>
								<td>
									<c:choose>
										<c:when test="${indetity.id == 0}">
											<input type="radio"  name="genEveryDay" checked="checked" value="1"  />是
											<input type="radio"  name="genEveryDay" value="0" />否
										</c:when>
										<c:otherwise>
											<input type="radio"  name="genEveryDay" <c:if test="${indetity.genEveryDay==1}">checked="checked"</c:if>  value="1" />是
											<input type="radio"  name="genEveryDay" <c:if test="${indetity.genEveryDay==0}">checked="checked"</c:if> value="0" />否
											
										</c:otherwise>
									</c:choose>
									
									<br>
									流水号生成规则：
									<ul>
										<li>1.每天生成。每天从初始值开始计数。</li>
										<li>2.递增，流水号一直增加。</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th width="20%">流水号长度: </th>
								
								<td>
									<c:choose>
										<c:when test="${indetity.id == 0}">
											<input type="text" id="noLength" name="noLength" value="5"  class="inputText"/>
										</c:when>
										<c:otherwise>
											<input type="text" id="noLength" name="noLength" value="${indetity.noLength}"  class="inputText"/>
										</c:otherwise>
									</c:choose>
									<br>
									这个长度表示当前流水号的长度数，只包括流水号部分{NO},如果长度为5，当前流水号为5，则在流水号前补4个0，表示为00005。<br>
									{no}如果长度为5，当前流水号为501，则在流水号后面补5个0，表示为50100000，如果长度为1，则流水号一直递增。
								</td>
							</tr>
							<tr>
								<th width="20%">初始值: </th>
								<td>
									<c:choose>
										<c:when test="${indetity.id == 0}">
											<input type="text" id="initValue" name="initValue" value="1"  class="inputText"/>
										</c:when>
										<c:otherwise>
											<input type="text" id="initValue" name="initValue" value="${indetity.initValue}"  class="inputText"/>
										</c:otherwise>
									</c:choose>
									
								</td>
							</tr>
							<tr>
								<th width="20%">步长: </th>
								<td>
									<c:choose>
										<c:when test="${indetity.id == 0}">
											<input type="text" id="step" name="step" value="1"  class="inputText"/>
										</c:when>
										<c:otherwise>
											<input type="text" id="step" name="step" value="${indetity.step}"  class="inputText"/>
										</c:otherwise>
									</c:choose>
									<br>
									流水号每次递加的数字，默认步长为1。比如步长为2，则每次获取流水号则在原来的基础上加2。
								</td>
							</tr>
							
						</table>
						<input type="hidden" name="id" value="${indetity.id}" />
					
				</form>
		</div>
</div>
</body>
</html>

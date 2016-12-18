<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>浏览邮件</title>
	<%@include file="/commons/include/getById.jsp" %>
</head>
<body>
	<div class="panel">
		<div class="panel-top">
			<div class="tbar-title">
				<span class="tbar-label">浏览邮件</span>
			</div>
			<div class="panel-toolbar">
				<div class="toolBar">
					<c:if test="${outMail.types==1}">
						<div class="group"><a class="link update" href="reply.ht?mailId=${outMail.mailId}&isReply=1&outMailSetId=${outMailSetId}">回复</a></div>
						<div class="l-bar-separator"></div>
					</c:if>
					<div class="group">
						<a class="link back" href="list.ht?id=${outMailSetId}&types=${outMail.types}">返回</a>
					</div>
				</div>
			</div>
		</div>
		<div class="panel-body">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<th width="15%">主题:</th>
					<td>${outMail.title}</td>
				</tr>
				<tr>
					<th width="15%">发件人:</th>
					<td>(${outMail.senderName})${outMail.senderAddresses}</td>
				</tr>
				<tr>
					<th width="15%">收件人:</th>
					<td>${outMail.receiverAddresses}</td>
				</tr>
				<tr>
					<th width="15%">日期:</th>
					<td><fmt:formatDate value='${outMail.mailDate}' type="both"/></td>
				</tr>					
				<tr>
					<th width="15%">内容:</th>
					<td colspan="2">${outMail.content}</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>

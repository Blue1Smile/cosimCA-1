<%--
	time:2013-08-23 10:02:06
	desc:edit the cloud_finance_gathering
--%>
<%@page language="java" pageEncoding="UTF-8"%>
<%@include file="/commons/include/html_doctype.html"%>
<html>
<head>
	<title>编辑 cloud_finance_gathering</title>
	<%@include file="/commons/include/form.jsp" %>
	<script type="text/javascript" src="${ctx}/js/hotent/CustomValid.js"></script>
	<script type="text/javascript" src="${ctx}/js/hotent/formdata.js"></script>
	<script type="text/javascript" src="${ctx}/js/hotent/subform.js"></script>
	<script type="text/javascript" src="${ctx}/js/hotent/platform/form/CommonDialog.js"></script>
	<script type="text/javascript" src="${ctx}/js/hotent/platform/system/IconDialog.js"></script>
	<script type="text/javascript">
		$(function() {
			var options={};
			if(showResponse){
				options.success=showResponse;
			}
			var frm=$('#finGatheringForm').form();
			$("a.save").click(function() {
				frm.setData();
				frm.ajaxForm(options);
				if(frm.valid()){
					form.submit();
				}
			});
		});
 
		function add_supp(){
			CommonDialog("ware_finStatement",
					function(order) {
						var purids = "";
						var purcode = "";
						for(var i = 0; i<order.length;i++){
							var oid = order[i].id +",";
							var ocd = order[i].code + ",";
							purids += oid;
							purcode += ocd;
						}
						$("#sourceformId").val(purids);
						$("#sourceformCode").val(purcode);
						$("#rows").empty();
						$.ajax({
							type : 'post',
							dataType : 'json',
							url : '${ctx}/cloud/finance/FinGathering/getOrderDetails.ht',
							data : {value : purids},
							success : function(rows){
								//判断是否有值
								if(rows.length>0){
									for(var i=0;i<rows.length;i++){
										var serialnumber = i + 1 ;
										var materielId=rows[i].materielId;
										var materialcode = rows[i].materielCode;
										var materialname = rows[i].materielName;
										var attributedes = rows[i].attributeNote;
										var units = rows[i].unite;
										var receivedamount = rows[i].orderNum2;
										var price = rows[i].price;
										var sumprice = rows[i].sumPrise;
										
										if(materielId==null){
											materielId="";
										}
										if(materialcode==null){
											materialcode="";
										}
										if(materialname==null){
											materialname="";
										}
										if(attributedes==null){
											attributedes="";
										}
										if(units==null){
											units="";
										}
										if(receivedamount==null){
											receivedamount="";
										}
										if(price==null){
											price="";
										}
										if(sumprice==null){
											sumprice="";
										}
										appendRow(materielId,serialnumber,materialcode,attributedes,units,materialname,receivedamount,price,sumprice);
									};
								}
							}
						});
			});
		}
		function appendRow(materielId,serialnumber,materialcode,attributedes,units,materialname,receivedamount,price,sumprice){
			var str = '<tr type="subdata">';
			str += '<td><input type="checkbox" name="check" value=""/></td>';
			str += '<td><input style="width: 80px;" type="text" name="materielId"  value="'+materielId+'"/></td>';
			str += '<td><input style="width: 80px;" type="text" name="invoice"  value=""/></td>';
			str += '<td><input style="width: 80px;" type="text" name="product"  value="'+materialname+'"/></td>';
			str += '<td><input style="width: 80px;" type="text" name="spec"  value=""/></td>';
			str += '<td><input style="width: 80px;" type="text" name="unite"  value="'+units+'"/></td>';
			//str += '<td><input style="width: 50px;" type="text" name="consignmentNum"  value=""/></td>';
			str += '<td><input style="width: 50px;" type="text" name="receiveNum"  value="'+receivedamount+'" onblur="getSumPrice(this);"/></td>';
			//str += '<td><input style="width: 50px;" type="text" name="checkNum"  value=""/></td>';
			str += '<td><input style="width: 80px;" type="text" name="price"  value="'+price+'" onblur="getSumPrice(this);"/></td>';
			str += '<td><input style="width: 50px;" type="text" name="zk"  value="" onblur="getSumPrice(this);"/></td>';
			str += '<td><input style="width: 80px;" readonly type="text" name="sumPrice"  value="'+sumprice+'" onblur="getSumPrice(this);"/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="balancePrice"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="invoicePrice"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="receivePrice"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="nonreceivePrice"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="currentGetprice"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="consignmentDate"  value="<fmt:formatDate value='${finGatheringDetailItem.consignmentDate}' pattern='yyyy-MM-dd'/>" class="inputText date" validate="{date:true}" "/></td>';
			str += '<td><input style="width: 80px;" type="text" name="arriveDate"  value="<fmt:formatDate value='${finGatheringDetailItem.arriveDate}' pattern='yyyy-MM-dd'/>" class="inputText date" validate="{date:true}" "/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="sellBill"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="balanceBill"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="arriveBill"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="remark"  value=""/></td>';
			str += '</tr>';
			$('#rows').append(str);
		}
		//增加一行
		function add_onesupps(){
			var str = '<tr type="subdata">';
			str += '<td><input type="checkbox" name="check" value=""/></td>';
			str += '<td><input style="width: 80px;" type="text" name="invoice"  value=""/></td>';
			str += '<td><input style="width: 80px;" type="text" name="product"  value=""/></td>';
			str += '<td><input style="width: 80px;" type="text" name="spec"  value=""/></td>';
			str += '<td><input style="width: 80px;" type="text" name="unite"  value=""/></td>';
			//str += '<td><input style="width: 50px;" type="text" name="consignmentNum"  value=""/></td>';
			str += '<td><input style="width: 50px;" type="text" name="receiveNum"  value="" onblur="getSumPrice(this);"/></td>';
			//str += '<td><input style="width: 50px;" type="text" name="checkNum"  value=""/></td>';
			str += '<td><input style="width: 80px;" type="text" name="price"  value="" onblur="getSumPrice(this);"/></td>';
			str += '<td><input style="width: 80px;" readonly type="text" name="sumPrice"  value="" onblur="getSumPrice(this);"/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="balancePrice"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="invoicePrice"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="receivePrice"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="nonreceivePrice"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="currentGetprice"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="consignmentDate"  value="<fmt:formatDate value='${finGatheringDetailItem.consignmentDate}' pattern='yyyy-MM-dd'/>" class="inputText date" validate="{date:true}" "/></td>';
			str += '<td><input style="width: 80px;" type="text" name="arriveDate"  value="<fmt:formatDate value='${finGatheringDetailItem.arriveDate}' pattern='yyyy-MM-dd'/>" class="inputText date" validate="{date:true}" "/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="sellBill"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="balanceBill"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="arriveBill"  value=""/></td>';
			//str += '<td><input style="width: 80px;" type="text" name="remark"  value=""/></td>';
			str += '</tr>';
			$('#rows').append(str);
    	}
	    	
	    	
	    function delproduct(){
			$("[name=check]:checkbox").each(function() {
				if (this.checked) {
					$(this).parent().parent().remove();
				}
			});
		}
		/**
		*全选/反选
		*/
	 	function checkall() {
			$("[name=check]:checkbox").each(function() {
				if (this.checked) {
					 $("[name=check]:checkbox").attr('checked', false);
				}else{
					 $("[name=check]:checkbox").attr('checked', true);
				}
			});
		}
	
	
	function add_info(){
		CommonDialog("org_info_list",
				function(info){
				$("#payenterpName").val(info.NAME);
				$("#payenterpId").val(info.SYS_ORG_INFO_ID);
		});
		
	}
function getSumPrice(obj) {
		
			//物品ID
		var materialId=$(obj).closest("tr").find('input[name="materielId"]').val();
		if(materialId==0||materialId==null){
			$.ligerMessageBox.alert("提示信息","未获取到物品ID");
			return;
		}
		//收款企业ID
		var enterpriseId=$('#payeeenterpId').val();
		if(enterpriseId==0||enterpriseId==null){
			$.ligerMessageBox.alert("提示信息","未获取到收款企业ID");
			return;
		}
		//付款企业ID
		var payenterpId=$('#payenterpId').val();
		if(payenterpId==0||payenterpId==null){
			
			$.ligerMessageBox.alert("提示信息","请选择付款企业");
			return;
		}
		var discount=0;
		$.ajax({
			type : 'post',
			dataType : 'json',
			url : '${ctx}/cloud/config/priceStrategy/getDiscount.ht',
			data : {materialId : materialId,enterpriseId:enterpriseId,payenterpId:payenterpId},
			success : function(rows){
				//判断是否有值
				if(rows.length>0){
					for(var i=0;i<rows.length;i++){
						  discount=rows[i].discount;
					}
				}else{
					discount=1;
					
				}
				$(obj).closest("tr").find('input[name="zk"]').val(discount);
				 
				var price=$(obj).closest("tr").find('input[name="price"]').val();
var orderNum=$(obj).closest("tr").find('input[name="receiveNum"]').val();
if(!isNaN(price)&&!isNaN(orderNum)){
	var sumPrice=$(obj).closest("tr").find('input[name="sumPrice"]').val();
	if(price!=""&&orderNum!=""){
		sumPrice=orderNum*price*discount;
		price=parseFloat(price);
		$(obj).closest("tr").find('input[name="sumPrice"]').val(sumPrice.toFixed(2));
		$(obj).closest("tr").find('input[name="price"]').val(price.toFixed(2));
	}
}else{
	$.ligerMessageBox.alert("请输入数字!");
}
			}
		});
	}	
	</script>
</head>
<body>
<div class="panel">
	<div class="panel-top">
		<div class="tbar-title">
		   
			        <span class="tbar-label">添加应收单据</span>
			    
		</div>
		 
	</div>
	<div class="panel-body">
		<form id="finGatheringForm" method="post" action="save.ht">
			<table class="table-detail" cellpadding="0" cellspacing="0" border="0" type="main">
				<tr>
					<th width="20%">单证号: </th>
					<td><input type="text" id="code" name="code" value="${finGathering.code}"  class="inputText" validate="{required:true,maxlength:96}"  /></td>
					<th width="20%">制单日期: </th>
					<td><input type="text" id="operateDate" name="operateDate" value="<fmt:formatDate value='${finGathering.operateDate}' pattern='yyyy-MM-dd'/>" class="inputText date" validate="{date:true}" /></td>
				</tr>
				<tr>
					<th width="20%">制单人: </th>
					<td><input type="text" id="operaterName" name="operaterName" value="${finGathering.operaterName}"  class="inputText" validate="{required:true,maxlength:96}"  /></td>
					<th width="20%">收款类型: </th>
					<td>
				 
					 <input type="text" id="payeeenterpType" name="payeeenterpType" value="${finPayment.payType}"  class="inputText" validate="{required:false,maxlength:96}"  /> 
					</td>
				</tr>
				<tr>
					<th width="20%">来源单据类型: </th>
					<td><input type="text" id="sourceformType" name="sourceformType" value="采购结算"  class="inputText" validate="{required:true,maxlength:96}"  /></td>
					<th width="20%">来源单据号: </th>
					<td><input type="text" id="sourceformCode" name="sourceformCode" value="${finPayment.sourceformCode}"  class="inputText" validate="{required:true,maxlength:512}"  />
						 </td>
					</tr>
				<tr>
					<th width="20%">收款企业名称: </th>
					<td><input type="text" id="payeeenterpName" name="payeeenterpName" value="${finPayment.payeeenterpName}"  class="inputText" validate="{required:true,maxlength:96}"  /></td>
					<th width="20%">收款人: </th>
					<td><input type="text" id="payeeenterpUsername" name="payeeenterpUsername" value="${finPayment.payeeenterpUsername}"  class="inputText" validate="{required:true,maxlength:96}"  /></td>
				</tr>
				<tr>
					<th width="20%">付款企业名称: </th>
					<td><input type="text" id="payenterpName" name="payenterpName" value="${finPayment.payenterpName}"  class="inputText" validate="{required:true,maxlength:96}"  />
						 </td>
					<th width="20%">付款人: </th>
					<td><input type="text" id="payenterpUsername" name="payenterpUsername" value="${finPayment.payenterpUsername}"  class="inputText" validate="{required:true,maxlength:96}"  /></td>
				</tr>
				<tr>
					<th width="20%">付款日期: </th>
					<td><input type="text" id="payeeenterpDate" name="payeeenterpDate" value="<fmt:formatDate value='${finPayment.payDate}' pattern='yyyy-MM-dd'/>" class="inputText" validate="{date:true}" /></td>
					<th width="20%">付款方式: </th>
					<td>
				 
					 <input type="text" id="payenterpModel" name="payenterpModel" value="${finPayment.payMode}"  class="inputText" validate="{required:false,maxlength:96}"  /> 
					</td>
				</tr>
				<tr>
					<th width="20%">币种: </th>
					<td><input type="text" id="currencyType" name="currencyType" value="${finPayment.currencyType}"  class="inputText" validate="{required:false,maxlength:96}"  /></td>
					<th width="20%">汇率: </th>
					<td><input type="text" id="exchangeRate" name="exchangeRate" value="${finPayment.exchangeRate}"  class="inputText" validate="{required:false,maxlength:96}"  /></td>
				</tr>
				<tr>
					<th width="20%">收款银行: </th>
					<td><input type="text" id="gatheringBank" name="gatheringBank" value="${finPayment.gatherBank}"  class="inputText" validate="{required:false,maxlength:192}"  /></td>
					<th width="20%">收款账号: </th>
					<td><input type="text" id="gatheringCode" name="gatheringCode" value="${finPayment.gatherNumber}"  class="inputText" validate="{required:false,maxlength:96}"  /></td>
				</tr>
				<tr>
					<th width="20%">付款银行: </th>
					<td><input type="text" id="paymentBank" name="paymentBank" value="${finPayment.payenterpBank}"  class="inputText" validate="{required:false,maxlength:192}"  /></td>
					<th width="20%">付款账号: </th>
					<td><input type="text" id="paymentCode" name="paymentCode" value="${finPayment.payenterpNumber}"  class="inputText" validate="{required:false,maxlength:96}"  /></td>
				</tr>
				<tr>
					<th width="20%">票据号: </th>
					<td><input type="text" id="ticketBill" name="ticketBill" value="${finPayment.noteCode}"  class="inputText" validate="{required:false,maxlength:96}"  /></td>
					<th width="20%">付款金额: </th>
					<td><input type="text" id="gatheringPrice" name="gatheringPrice" value="${finPayment.payPrice}"  class="inputText" validate="{required:true,number:true }"  /></td>
				</tr>
				<tr>
					<th width="20%">备注: </th>
					<td colspan="3"><textarea cols="95" rows="3" id="remark" name="remark" class="inputText" validate="{required:false,maxlength:768}"  >${finGathering.remark}</textarea></td>
				</tr>
				<tr>
					<!--<th width="20%">付款人id: </th>-->
					<input type="hidden" id="payenterpUserid" name="payenterpUserid" value="${finGathering.payenterpUserid}"  class="inputText" validate="{required:false,number:true }"  />
					<input type="hidden" id="state" name="state" value="生效"   />
					<!--<th width="20%">付款企业ID: </th>-->
					<input type="hidden" id="payenterpId" name="payenterpId" value="${finPayment.payenterpId}"  class="inputText" validate="{required:false,number:true }"  />
					<!--<th width="20%">收款人ID: </th>-->
					<input type="hidden" id="payeeenterpUserid" name="payeeenterpUserid" value="${finGathering.payeeenterpUserid}"  class="inputText" validate="{required:false,number:true }"  />
					<!--<th width="20%">收款企业ID: </th>-->
					<input type="hidden" id="payeeenterpId" name="payeeenterpId" value="${finPayment.payeeenterpId}"  class="inputText" validate="{required:false,number:true }"  />
					<!--<th width="20%">来源单据ID: </th>-->
					<input type="hidden" id="sourceformId" name="sourceformId" value="${finGathering.sourceformId}"  class="inputText" validate="{required:false,maxlength:512}"  />
					<!--<th width="20%">制单人ID: </th>-->
					<input type="hidden" id="operaterId" name="operaterId" value="${finGathering.operaterId}"  class="inputText" validate="{required:false,number:true }"  />
				</tr>
			</table>
			<table class="table-grid table-list" cellpadding="1" cellspacing="1" id="finGatheringDetail" formType="window" type="sub">
				<tr>
					<td colspan="21">
						<div class="group" align="left" style="display:none">
								<a href="javascript:void(0)" onclick="add_onesupps();"   style="text-decoration: none;">
											<img src="${ctx}/images/iconadd3.jpg" width="52" height="18"
												onmouseover="src='${ctx}/images/iconadd4.jpg'"
												onmouseout="src='${ctx}/images/iconadd3.jpg'"
												style="border: 0;"> </a>&nbsp;&nbsp;
								  <a href="javascript:void(0)"  onclick="delproduct();"   style="text-decoration: none;">
											<img src="${ctx}/images/icon_del2.jpg" height="18" width="52"
												onmouseover="src='${ctx}/images/icon_del.jpg'"
												onmouseout="src='${ctx}/images/icon_del2.jpg'"
												style="border: 0;"> </a>&nbsp;&nbsp;
			    		</div>
			    		<div align="center">
						应收单据详细信息
			    		</div>
		    		</td>
				</tr>
				<tr>
				<th>物品ID</th>
				<th>发票号</th>
				<th>产品</th>
				<th>规格</th>
				<th>单位</th>
				<th>数量</th>
				<th>单价</th>
				<th>折扣</th>
				<th>金额</th>
				<th>到货日期</th>
				<tbody id="rows">
				<c:forEach items="${finPaymentDetailList}" var="finGatheringDetailItem" varStatus="status">
				    <tr type="subdata">
				    	 
					    <td style="text-align: center" name="invoice">${finGatheringDetailItem.invoice}</td>
					    <td style="text-align: center" name="product">${finGatheringDetailItem.product}</td>
					    <td style="text-align: center" name="spec">${finGatheringDetailItem.spec}</td>
					    <td style="text-align: center" name="unite">${finGatheringDetailItem.unite}</td>
					    <td style="text-align: center" name="receiveNum">${finGatheringDetailItem.receiveNum}</td>
					    <td style="text-align: center" name="price">${finGatheringDetailItem.price}</td>
					    <td style="text-align: center" name="sumPrice">${finGatheringDetailItem.sumPrice}</td>
						<td style="text-align: center" name="arriveDate"><fmt:formatDate value='${finGatheringDetailItem.arriveDate}' pattern='yyyy-MM-dd'/></td>								
						<input type="hidden" name="invoice" value="${finGatheringDetailItem.invoice}"/>
						<input type="hidden" name="product" value="${finGatheringDetailItem.product}"/>
						<input type="hidden" name="spec" value="${finGatheringDetailItem.spec}"/>
						<input type="hidden" name="unite" value="${finGatheringDetailItem.unite}"/>
						<input type="hidden" name="receiveNum" value="${finGatheringDetailItem.receiveNum}"/>
						<input type="hidden" name="price" value="${finGatheringDetailItem.price}"/>
						<input type="hidden" name="sumPrice" value="${finGatheringDetailItem.sumPrice}"/>
					    <input type="hidden" name="arriveDate" value="<fmt:formatDate value='${finGatheringDetailItem.arriveDate}' pattern='yyyy-MM-dd'/>" class="inputText date"/>
				    </tr>
				</c:forEach>
				</tbody>
				<tr type="append">
			    	<td style="text-align: center" name="invoice"></td>
			    	<td style="text-align: center" name="product"></td>
			    	<td style="text-align: center" name="spec"></td>
			    	<td style="text-align: center" name="unite"></td>
			    	<td style="text-align: center" name="receiveNum"></td>
			    	<td style="text-align: center" name="price"></td>
			    	<td style="text-align: center" name="sumPrice"></td>
					<td style="text-align: center" name="arriveDate"></td>								
			 
			    	<input type="hidden" name="invoice" value=""/>
			    	<input type="hidden" name="product" value=""/>
			    	<input type="hidden" name="spec" value=""/>
			    	<input type="hidden" name="unite" value=""/>
			    	<input type="hidden" name="receiveNum" value=""/>
			    	<input type="hidden" name="price" value=""/>
			    	<input type="hidden" name="sumPrice" value=""/>
			    	<input type="hidden" name="arriveDate" value="" class="inputText date"/>
		 		</tr>
		    </table>
			<input type="hidden" name="id" value="${finGathering.id}" />
		</form>
		
	</div>
	<form id="FinGatheringDetailForm" style="display:none">
		<table class="table-detail" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<th width="20%">发票号: </th>
				<td><input type="text" name="invoice" value=""  class="inputText" validate="{required:false,number:true }"/></td>
			</tr>
			<tr>
				<th width="20%">产品: </th>
				<td><input type="text" name="product" value=""  class="inputText" validate="{required:false,maxlength:96}"/></td>
			</tr>
			<tr>
				<th width="20%">规格: </th>
				<td><input type="text" name="spec" value=""  class="inputText" validate="{required:false,maxlength:96}"/></td>
			</tr>
			<tr>
				<th width="20%">单位: </th>
				<td><input type="text" name="unite" value=""  class="inputText" validate="{required:false,maxlength:72}"/></td>
			</tr>
			<tr>
				<th width="20%">发货数量: </th>
				<td><input type="text" name="consignmentNum" value=""  class="inputText" validate="{required:false,number:true }"/></td>
			</tr>
			<tr>
				<th width="20%">接受数量: </th>
				<td><input type="text" name="receiveNum" value=""  class="inputText" validate="{required:false,number:true }"/></td>
			</tr>
			<tr>
				<th width="20%">合格品数量: </th>
				<td><input type="text" name="checkNum" value=""  class="inputText" validate="{required:false,number:true }"/></td>
			</tr>
			<tr>
				<th width="20%">单价: </th>
				<td><input type="text" name="price" value=""  class="inputText" validate="{required:false,number:true }"/></td>
			</tr>
			<tr>
				<th width="20%">金额: </th>
				<td><input type="text" name="sumPrice" value=""  class="inputText" validate="{required:false,number:true }"/></td>
			</tr>
			<tr>
				<th width="20%">结算金额: </th>
				<td><input type="text" name="balancePrice" value=""  class="inputText" validate="{required:false,number:true }"/></td>
			</tr>
			<tr>
				<th width="20%">开票金额: </th>
				<td><input type="text" name="invoicePrice" value=""  class="inputText" validate="{required:false,number:true }"/></td>
			</tr>
			<tr>
				<th width="20%">已收金额: </th>
				<td><input type="text" name="receivePrice" value=""  class="inputText" validate="{required:false,number:true }"/></td>
			</tr>
			<tr>
				<th width="20%">未收金额: </th>
				<td><input type="text" name="nonreceivePrice" value=""  class="inputText" validate="{required:false,number:true }"/></td>
			</tr>
			<tr>
				<th width="20%">本次收款额: </th>
				<td><input type="text" name="currentGetprice" value=""  class="inputText" validate="{required:false,number:true }"/></td>
			</tr>
			<tr>
				<th width="20%">发货日期: </th>
				<td><input type="text" name="consignmentDate" value="" class="inputText date" validate="{date:true}"/></td>
			</tr>
			
			<tr>
				<th width="20%">到货日期: </th>
				<td><input type="text" name="arriveDate" value="" class="inputText date" validate="{date:true}"/></td>
			</tr>
			
			<tr>
				<th width="20%">销售订单号: </th>
				<td><input type="text" name="sellBill" value=""  class="inputText" validate="{required:false,maxlength:72}"/></td>
			</tr>
			<tr>
				<th width="20%">结算单号: </th>
				<td><input type="text" name="balanceBill" value=""  class="inputText" validate="{required:false,maxlength:72}"/></td>
			</tr>
			<tr>
				<th width="20%">到货单号: </th>
				<td><input type="text" name="arriveBill" value=""  class="inputText" validate="{required:false,maxlength:72}"/></td>
			</tr>
			<tr>
				<th width="20%">备注: </th>
				<td><input type="text" name="remark" value=""  class="inputText" validate="{required:false,maxlength:384}"/></td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>

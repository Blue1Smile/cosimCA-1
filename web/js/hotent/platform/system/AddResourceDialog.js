function AddResourceDialog(conf)
{
	if(!conf){
		$.ligerMessageBox.error("错误","添加资源请求，要求传入适当的参数!");
		return;
	}
	var addUrl=conf.addUrl;
	if(!addUrl){
		$.ligerMessageBox.error("错误","添加资源请求，要求传入要添加的资源的URL!");
		return;
	}
	
	var url=__ctx + "/platform/system/resources/addResource.ht";
	
	
	var dialogWidth=900;
	var dialogHeight=600;
	
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:0,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	url=url.getNewUrl();
	var params={
		addUrl:addUrl	
	};
	
	if(conf.name){
		params.name=conf.name;
	}
	
	var rtn=window.open(url,params,winArgs);
	if(rtn!=undefined){
		if(conf.callback){
			conf.callback.call(this,rtn);
		}
	}
}
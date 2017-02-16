function ScriptDialog(conf)
{
	
	if(!conf) conf={};	
	//var url=__ctx + "/platform/system/script/dialog.ht";	//常用脚本选择器
	var url=__ctx + "/platform/expression/expression.ht";	//脚本设计器
	
	
	var dialogWidth=800;
	var dialogHeight=560;
	
	conf=$.extend({},{dialogWidth:dialogWidth ,dialogHeight:dialogHeight ,help:0,status:0,scroll:1,center:1},conf);

	var winArgs="dialogWidth="+conf.dialogWidth+"px;dialogHeight="+conf.dialogHeight
		+"px;help=" + conf.help +";status=" + conf.status +";scroll=" + conf.scroll +";center=" +conf.center;
	url=url.getNewUrl();
	var rtn=window.open(url,"",winArgs);
	if(rtn!=undefined){
		if(conf.callback){
			conf.callback.call(this,rtn);
		}
	}
	
}
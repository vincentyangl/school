<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>个人信息</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="stylesheet" type="text/css" href="/ztree/css/demo.css" />
<link rel="stylesheet" type="text/css"
	href="/ztree/css/zTreeStyle/zTreeStyle.css" />
	<link rel="stylesheet" type="text/css" href="/common/layui/css/layui.css"  media="all" >
	<link rel="stylesheet" type="text/css" href="/common/bootstrap/css/bootstrap.css"  media="all">
	<link rel="stylesheet" type="text/css" href="/common/global.css"  media="all">
	<link rel="stylesheet" type="text/css" href="/css/personal.css"  media="all">
<script src="/ztree/js/jquery-1.4.4.min.js" type="text/javascript"
	charset="utf-8"></script>
  <script type="text/javascript" src="/js/jquery.js"></script>
<script src="/ztree/js/jquery.ztree.core.js" type="text/javascript"
	charset="utf-8"></script>
<script src="/ztree/js/jquery.ztree.excheck.js" type="text/javascript"
	charset="utf-8"></script>
<script src="/ztree/js/jquery.ztree.exedit.js" type="text/javascript"
	charset="utf-8"></script>
<style>
#myTree {
	width: 100%;
	height: 100%;
}
.zTreeDemoBackground{
    margin-left: 500px;
}
.layui-input-inline{
    margin-left: 500px;
}
</style>
<script type="text/javascript">
var setting = {
		check: {
			enable: true
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback:{     
			onCheck:onCheck    
			} 
	};

	var zNodes =${permissions};

	var code;

	function setCheck() {
		var zTree = $.fn.zTree.getZTreeObj("myTree"),
		py = $("#py").attr("checked")? "p":"",
		sy = $("#sy").attr("checked")? "s":"",
		pn = $("#pn").attr("checked")? "p":"",
		sn = $("#sn").attr("checked")? "s":"",
		type = { "Y":py + sy, "N":pn + sn};
		zTree.setting.check.chkboxType = type;
		showCode('setting.check.chkboxType = { "Y" : "' + type.Y + '", "N" : "' + type.N + '" };');
	}
	function showCode(str) {
		if (!code) code = $("#code");
		code.empty();
		code.append("<li>"+str+"</li>");
	}

	$(document).ready(function(){
		$.fn.zTree.init($("#myTree"), setting, zNodes);
		setCheck();
		$("#py").bind("change", setCheck);
		$("#sy").bind("change", setCheck);
		$("#pn").bind("change", setCheck);
		$("#sn").bind("change", setCheck);
	});
	
	function onCheck(e,treeId,treeNode){    
		var treeObj=$.fn.zTree.getZTreeObj("myTree"),    
		nodes=treeObj.getCheckedNodes(true),    
		v="";    
		for(var i=0;i<nodes.length;i++){    
		    v+=nodes[i].name + ",";    
		   // alert(nodes[i].id); //获取选中节点的值   
		    }   
		 } 
</script>
</head>
<body>

		<form action="" method="post"  id="myForm">
		    <div class="layui-input-inline">
		    	<input value="" placeholder="请输入关键字" class="layui-input search_input" type="text">
		    </div>
		    <a class="layui-btn search_btn">查询</a>
		</form>   

<div class="zTreeDemoBackground ">
		<ul id="myTree" class="ztree"></ul>
	</div>
<input type="checkbox" id="py" class="checkbox first" checked style="display:none;" />    
<input type="checkbox" id="sy" class="checkbox first" checked style="display:none;"/>    
<input type="checkbox" id="pn" class="checkbox first" checked style="display:none;"/>    
<input type="checkbox" id="sn" class="checkbox first" checked style="display:none;"/>         

</body>
</html>
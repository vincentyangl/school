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
<link rel="stylesheet" type="text/css"
	href="/common/bootstrap/css/bootstrap.css" media="all">
<script src="/ztree/js/jquery-1.4.4.min.js" type="text/javascript"
	charset="utf-8"></script>
<script type="text/javascript" src="/js/jquery.js"></script>
<script src="/ztree/js/jquery.ztree.core.js" type="text/javascript"
	charset="utf-8"></script>
<script src="/ztree/js/jquery.ztree.excheck.js" type="text/javascript"
	charset="utf-8"></script>
<script src="/ztree/js/jquery.ztree.exedit.js" type="text/javascript"
	charset="utf-8"></script>
<script type="text/javascript" charset="utf-8" src="/common/bootstrap/js/bootstrap.js"></script>
<style>
#myTree {
	width: 100%;
	height: 100%;
}

.zTreeDemoBackground {
	margin-left: 500px;
}
</style>
<script type="text/javascript">
	var id = 0;
	var name;
	var setting = {
		check : {
			enable : true
		},
		data : {
			simpleData : {
				enable : true
			}
		},
		callback : {
			beforeClick : zTreeBeforeClick
		}
	};

	var zNodes = ${permissions};

	var code;

	function setCheck() {
		var zTree = $.fn.zTree.getZTreeObj("myTree"), py = $("#py").attr(
				"checked") ? "p" : "", sy = $("#sy").attr("checked") ? "s" : "", pn = $(
				"#pn").attr("checked") ? "p" : "", sn = $("#sn")
				.attr("checked") ? "s" : "", type = {
			"Y" : py + sy,
			"N" : pn + sn
		};
		zTree.setting.check.chkboxType = type;
		showCode('setting.check.chkboxType = { "Y" : "' + type.Y + '", "N" : "'
				+ type.N + '" };');
	}
	function showCode(str) {
		if (!code)
			code = $("#code");
		code.empty();
		code.append("<li>" + str + "</li>");
	}

	$(document).ready(function() {
		var rootNode = {id:-1,name:"系统管理",pId:null,open:true};
		zNodes.push(rootNode);
		$.fn.zTree.init($("#myTree"), setting, zNodes);
		setCheck();
		$("#py").bind("change", setCheck);
		$("#sy").bind("change", setCheck);
		$("#pn").bind("change", setCheck);
		$("#sn").bind("change", setCheck);
	});

	function zTreeBeforeClick(treeId, treeNode, clickFlag) {
		id = treeNode.id;
		name = treeNode.name;
	};

	function toAdd() {
		if (id == 0) {
			alert("请选择添加板块");
		}
		if (id != 0) {
			 $("#myModal").modal("show");
		}
	}
	
	function add(){
		var qname= $("#name").val();
		if(qname==null||qname.trim().length==0){
			alert("不能为空!");
		}else{
			$("#pId").val(id);
			document.forms[0].action="/permissions/addPermissions";
			document.forms[0].submit();
		}
	}
	
	function toUpdate(){
		if (id == 0) {
			alert("请选择修改板块");
		}
		if (id != 0) {
			 $("#updateModal").modal("show");
			 $("#uname").val(name);
		}
	}
	
	function update(){
		var uname= $("#uname").val();
		if(uname==null||uname.trim().length==0){
			alert("不能为空!");
		}else{
			$("#uid").val(id);
			document.forms[1].action="/permissions/updatePermissions";
			document.forms[1].submit();
		}
	}
	
	function del(){
		if (id == 0) {
			alert("请选择删除板块");
		}
		if (id != 0) {
			 $.post("/permissions/isDelete",{id:id},function(msg){
				 if(msg.length==0){
					 window.location.href="/permissions/delete/"+id;
				 }
				 if(msg.length>0){
					 alert("有子元素，不能删除");
				 }
			 },"json");
		}
	}
	
</script>
</head>
<body>

	<div>
		<a href="#" class="btn btn-default " onclick="toAdd()">添加</a>
        <a href="#" class="btn btn-default " onclick="toUpdate()">修改</a> 
		<a href="#" class="btn btn-default " onclick="del()">删除</a>
	</div>

	<div class="zTreeDemoBackground ">
		<ul id="myTree" class="ztree"></ul>
	</div>

<!-- 添加  -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">添加权限</h4>
      </div>
      <div class="modal-body">

					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-3 control-label">权限名称:</label>
							<div class="col-sm-9">
							    <input type="hidden" class="form-control" id="pId"  name="pId">
								<input type="text" class="form-control" id="name"  name="name">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-3 control-label">权限别名:</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="per_newName"  name="per_newName">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-3 control-label">权限路径:</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="per_url"  name="per_url">
							</div>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-3 control-label">是否菜单:</label>
							<div class="col-sm-9">
								<select class="form-control"  name="per_menu">
									<option value="1">是</option>
									<option value="2">否</option>
								</select>
							</div>
						</div>
					</form>

				</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary"  onclick="add()">确定</button>
      </div>
    </div>
  </div>
</div>

<!-- 修改  -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">修改权限</h4>
      </div>
      <div class="modal-body">

					<form class="form-horizontal">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-3 control-label">权限名称:</label>
							<div class="col-sm-9">
							    <input type="hidden" class="form-control" id="uid"  name="id">
								<input type="text" class="form-control" id="uname"  name="name">
							</div>
						</div>
					</form>

				</div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
        <button type="button" class="btn btn-primary"  onclick="update()">确定</button>
      </div>
    </div>
  </div>
</div>



</body>
</html>
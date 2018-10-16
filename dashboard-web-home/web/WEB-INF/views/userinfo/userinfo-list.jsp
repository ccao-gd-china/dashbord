<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<c:set value="${pageContext.request.contextPath}" var="base" />
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="${base}/assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${base}/assets/bootstrap/demo.css">
<script src="${base}/assets/jquery.min.js"></script>
<script src="${base}/assets/bootstrap/js/bootstrap.min.js"></script>
<style type="text/css">
table {
	table-layout: fixed;
	word-wrap: break-word;
}
</style>
<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="${base}/assets/html5shiv.js"></script>
<![endif]-->
<script type="text/javascript">
function gotoPage(pageNum){
	jQuery("#pageNumEle").val(pageNum);
	jQuery("#dataFormEle").submit();
}

function jumpPage(){
	jQuery("#pageNumEle").val(jQuery("#jumpPageNumEle").val());
	jQuery("#dataFormEle").submit();
}
</script>
<title>用户info-列表</title>
</head>
<body>

	<ol class="breadcrumb">
	  <li><a href="#"><a href="${base}/userinfo/edit" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span> 新增</a></a></li>
	</ol>
	<form class="form-inline" role="search" action="${base}/userinfo/list" method="post" id="dataFormEle">
	<input type="hidden" id="pageNumEle" name="pageNum" value="${pageNum}">
	<table class="table table-condensed table-bordered">
		<thead>
			<tr>
				<th>用户名</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${data.itemList}" var="userinfo" varStatus="vst">
				<tr>
						<td><a href="${base}/userinfo/view?id=${userinfo.id}">
						${userinfo.username}
						</a></td>
					<td>
					 <a href="${base}/userinfo/edit?id=${userinfo.id}">编辑</a>&nbsp;
					 <a href="${base}/userinfo/del?id=${userinfo.id}" onclick="javascript:return window.confirm('确定要删除吗？');">删除</a>&nbsp;
    				</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<c:if test="${data.pageCount > 1}">
	<div class="row pull-right">
		<ul class="pagination" style="margin-top: 5px; margin-bottom: 5px;">
			<li ${data.isCurPage(1)?"class=\"disabled\"":""}><a href="#" onclick="gotoPage(1);return false;">&laquo;</a></li>
			<c:if test="${data.getSlider(8)[0] > 1}">
			<li ${data.isCurPage(1)?"class=\"active\"":""}><a href="#" onclick="gotoPage(1);return false;">1</a></li>
			</c:if>
			<c:if test="${data.getSlider(8)[0] > 2}">
			<li class="disabled"><a href="#" onclick="javascript:return false;">...</a></li>
			</c:if>
			<c:forEach items="${data.getSlider(8)}" var="sd">
			<li ${data.isCurPage(sd)?"class=\"active\"":""}><a href="#" onclick="gotoPage(${sd})">${sd}</a></li>
			</c:forEach>
			<c:if test="${data.getSlider(8)[7] < (data.pageCount -1) }">
			<li class="disabled"><a href="#" onclick="gotoPage(1);return false;">...</a></li>
			</c:if>
			<li ${data.isCurPage(data.pageCount)?"class=\"disabled\"":""}><a href="#" onclick="gotoPage(${data.pageCount});return false;">&raquo;</a></li>
			<li><input type="jumpPageNum" id="jumpPageNumEle" style="display: inline; height: 34px; width: 60px;margin-left: 5px;" />
			<button class="btn btn-default" onclick="jumpPage();">go</button></li>
		</ul>
	</div>
	</c:if>
	</form>

</body>

</html>
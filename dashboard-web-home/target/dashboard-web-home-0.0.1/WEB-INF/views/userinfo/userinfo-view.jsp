<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<c:set value=" ${pageContext.request.contextPath}" var="base" />
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="${base}/assets/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="${base}/assets/bootstrap/demo.css">
<script src="${base}/assets/jquery.min.js"></script>
<script src="${base}/assets/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
	
</script>
<title>用户info-查看</title>
</head>
<body>
	<ol class="breadcrumb">
	  <li><a href="${base}">Home</a></li>
	  <li><a href="${base}/userinfo/list">列表</a></li>
	  <li class="active">View</li>
	</ol>
	<div style="width: 600px">
		<c:if test="!empty fmsg">
		<div class="alert alert-success alert-dismissable">
			<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>${fmsg}
		</div>
		</c:if>
		<table class="table table-bordered">
			<tr>
				<th>用户名</th>
				<td>${userinfo.username}</td>
			</tr>
		</table>
	</div>

</body>

</html>
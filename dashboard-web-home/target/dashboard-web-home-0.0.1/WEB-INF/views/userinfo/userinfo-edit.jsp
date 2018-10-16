<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<c:set value="${pageContext.request.contextPath}" var="base" />
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" href="${base}/assets/bootstrap/css/bootstrap.min.css">
<script src="${base}/assets/jquery.min.js"></script>
<script src="${base}/assets/bootstrap/js/bootstrap.min.js"></script>
<style type="text/css">

</style>
<title>用户info-编辑</title>
</head>
<body>
	<ol class="breadcrumb">
	  <li><a href="${base}">Home</a></li>
	  <li><a href="${base}/userinfo/list">列表</a></li>
	  <li class="active">编辑</li>
	</ol>
	<c:set var = "isUpdated" scope = "page" value = "${userinfo.id gt 0}"/>
	<form action="${base}/userinfo/submit.htm" method="post" style="width: 600px" class="form-horizontal" role="form">
		<c:if test="${userinfo.id gt 0}">
		<input type="hidden" name="id" value="${userinfo.id}">
		</c:if>
		<c:if test="${status.error}">
			<div id="message" class="error">Form has errors</div>
		</c:if>
		<s:hasBindErrors name="userinfo">
			<c:if test="${errors.fieldErrorCount > 0}">
        字段错误：<br />
				<c:forEach items="${errors.fieldErrors}" var="error">
					<s:message var="message" code="${error.code}" arguments="${error.arguments}" text="${error.defaultMessage}" />
            ${error.field}------${message}<br />
				</c:forEach>
			</c:if>
		</s:hasBindErrors>

		<form:errors cssClass="errorBox" />
		<div class="form-group">
			<label for="usernameEle" class="col-sm-3 control-label">用户名</label>
			<div class="col-sm-9">
				<input type="text" name="username" id="usernameEle" class="form-control"
					placeholder="Enter..." value="${userinfo.username}">
			</div>
		</div>
		<div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <button type="submit" class="btn btn-primary">提交</button>
		    </div>
		</div>
	</form>

</body>
</html>
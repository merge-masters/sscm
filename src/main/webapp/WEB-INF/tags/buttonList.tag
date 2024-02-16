<%@ tag body-content="empty" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ attribute name="print" required="true" %>
<%@ attribute name="excel" required="true" %>
<%@ attribute name="create" required="true" %>
<%@ attribute name="update" required="true" %>
<%@ attribute name="delete" required="true" %>
<%@ attribute name="menuId" required="true" rtexprvalue="true" %>

<%@ attribute name="addText" required="false" %>
<%@ attribute name="addFunction" required="false" %>
<%@ attribute name="ulId" required="false" rtexprvalue="true" %>
<%@ attribute name="divId" required="false" %>
<%@ attribute name="divStyle" required="false" %>

<%--
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags" %>
<tf:buttonList print="console.log('T');" excel="console.log('T2');" create="console.log('T3');" update="console.log('T4');" delete="console.log('T5');" menuId="" addFunction="" addText=""/>

<c:if test="${empty divId}">
	<c:set target="${divIdValue}" value="${menuId}" />
</c:if>
<c:if test="${not empty divId}">
	<c:set target="${divIdValue}" value="${divId}" />
</c:if>
 --%>
<c:if test="${empty menuId}">
<div class="pos_a p_right" style="${divStyle}">
	<c:if test="${not empty ulId}">
	<ul id="${ulId}" name="${ulId}" class="btnwrap">
	</c:if>
	<c:if test="${empty ulId}">
	<ul class="btnwrap">
	</c:if>
		<c:if test="${not empty addText}">
			<c:forEach var="addTextArr" items="${fn:split(addText, '|')}" varStatus="status">
				<c:set var="addFunctionValue" value="${fn:split(addFunction, '|')}" />
				<c:set var="index" value="${status.count}" />
				<c:set var="addFunctionValue2" value="${addFunctionValue[index-1]}" />
				<li><button class="btn white" tabindex="-1" onclick="${addFunctionValue2}"><fmt:message key="${addTextArr}" /></button></li>
			</c:forEach>
		</c:if>

	 	<c:if test="${not empty print}">
	 	<li><button class="btn white" tabindex="-1" onclick="${print}"><fmt:message key="추가" /></button></li>
	 	</c:if>
		<c:if test="${not empty excel}">
		<li><button class="btn white" tabindex="-1" onclick="${excel}"><fmt:message key="추가" /></button></li>
		</c:if>
		<c:if test="${C eq 'Y' and not empty create}">
		<li><button class="btn white" tabindex="-1" onclick="${create}"><fmt:message key="추가" /></button></li>
		</c:if>
		<c:if test="${D eq 'Y' and not empty delete}">
		<li><button class="btn white" tabindex="-1" onclick="${delete}"><fmt:message key="삭제" /></button></li>
		</c:if>
		<c:if test="${U eq 'Y' and not empty update}">
		<li><button class="btn black" tabindex="-1" onclick="${update}"><fmt:message key="수정" /></button></li>
		</c:if>
	</ul>
</div>
</c:if>
<c:if test="${not empty menuId}">
	<c:if test="${not empty divId}">
		<c:set var="divValue" value="${divId}" />
	</c:if>
	<c:if test="${empty divId}">
		<c:set var="divValue" value="buttonList${menuId}" />
	</c:if>
	<script name="scriptFunction" type="text/javascript">
		$(window).load(function () {
			gf_CreateButtonList(gf_GetCrudCode(${menuId}), {"print" : "${print}", "excel" : "${excel}", "create" : "${create}", "delete" : "${delete}", "update" : "${update}"}
			, "${addText}", "${addFunction}", "${divValue}", "${ulId}");
			$("script[name=scriptFunction]").remove();
		});
	</script>
	<div id="${divValue}" class="pos_a p_right">
	</div>
</c:if>
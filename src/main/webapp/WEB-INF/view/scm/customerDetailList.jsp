<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${customerCount eq 0 }">
	<tr>
		<td colspan="7">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${customerCount > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
	<c:forEach items="${customerList}" var="list">
		<tr onClick="selectCustomerDetail('${list.company_name}','${list.manager_name}')">
			<td>${list.user_type}</td>
			<td>${list.company_name}</td>
			<td>${list.manager_name}</td>
			<td>${list.phone_number}</td>
	<!-- 	<td><a class="btnType3 color1" -->
	<%-- 	href="javascript:fn_editComnGrpCod('${list.grp_cod}');"><span>수정</span></a> --%>
	<!-- 	</td> -->
		</tr>
		
<%-- 		<c:set var="nRow" value="${nRow + 1}" /> --%>
	</c:forEach>
</c:if>

<input type="hidden" id="totalCustomerCount" name="totalCustomerCount"
	value="${customerCount}" />
	
	
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${totalCount eq 0}">
  <tr>
    <td colspan="7">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<c:if test="${totalCount > 0}">
  <c:set var="nRow" value="${pageSize*(currentPage - 1)}" />
  <c:forEach items="${purchaseList}" var="purchase">
    <tr class="purchaseList">
      <td>${purchase.product_code}</td>
      <td>${purchase.product_model_name}</td>
      <td>${purchase.company_class_name}</td>
      <td>${purchase.order_date}</td>
      <td>${purchase.count}</td>
    </tr>
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value="${totalCount}" />

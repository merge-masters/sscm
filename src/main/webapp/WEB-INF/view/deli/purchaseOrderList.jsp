<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${totalCount eq 0}">
  <tr>
    <td colspan="7">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<c:if test="${totalCount > 0}">
  <c:set var="nRow" value="${pageSize*(currentPage - 1)}" />
  <c:forEach items="${purchaseOrderList}" var="purchase">
    <tr class="purchaseOrderList">
      <td><a href="javascript:purchaseOrderDetailList('${purchase.purchase_code }');">${purchase.purchase_code}</a></td>
      <td>${purchase.company_class_name}</td>
      <td>${purchase.purchase_total_price}</td>
      <td>${purchase.purchase_end_date}</td>
    </tr>
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value="${totalCount}" />

<!-- <a href="javascript:fPopModalDeliStart('${purchase.purchase_code }','${purchase.product_code }','${purchase.product_name }','${purchase.product_model_number }','${purchase.product_model_name }','${purchase.produce_company_name }','${purchase.purchase_total_price }')">${purchase.purchase_code}</a> -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:if test="${totalCount eq 0}">
  <tr>
    <td colspan="4">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>

<c:if test="${totalCount > 0}">
  <c:set var="nRow" value="${pageSize*(currentPage - 1)}" />
  <c:forEach items="${questionList}" var="question">
    <tr>
      <td>${question.notice_code}</td>
      <td><a href="javascript:fadeInModal('r','${question.notice_code}')">${question.notice_title}</a></td>
      <td><fmf:formatDate pattern="yyyy-MM-dd" value="${question.write_date}"/></td>
<%--       <td>${notice.view_cnt}</td> --%>
      <!-- List에 있는 js 함수 호출가능 이거 그대로 가지고 가기 때문에 !!  -->
    </tr>
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value="${totalCount}" />

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script type="text/javascript">
  // 페이징 설정
  
  /* OnLoad event */
  $(function() {
  });
  
 
  
</script>
</head>
<body>
  <form id="myForm" action="" method="">
    <input type="hidden" id="currentPageCod" value="1"> <input type="hidden" id="currentPageComnDtlCod" value="1"> <input type="hidden" id="tmpGrpCod" value=""> <input type="hidden" id="tmpGrpCodNm" value=""> <input type="hidden" name="action" id="action" value="">
    <!-- 모달 배경 -->
    <div id="mask"></div>
    <div id="wrap_area">
      <h2 class="hidden">header 영역</h2>
      <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
      <h2 class="hidden">컨텐츠 영역</h2>
      <div id="container">
        <ul>
          <li class="lnb">
            <!-- lnb 영역 --> <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
          </li>
          <li class="contents">
            <!-- contents -->
            <h3 class="hidden">contents 영역</h3> <!-- content -->
            <div class="content">
              <p class="conTitle">
                <span>메인</span>
              </p>
<!--               <div class="divComGrpCodList"> -->
<!--                 <table class="col"> -->
<%--                   <caption>caption</caption> --%>
<%--                   <colgroup> --%>
<%--                     <col width="10%"> --%>
<%--                     <col width="50%"> --%>
<%--                     <col width="30%"> --%>
<%--                     <col width="20%"> --%>
<%--                   </colgroup> --%>
<!--                   <thead> -->
<!--                     <tr> -->
<!-- <!--                       <th scope="col">글번호</th> --> 
<!-- <!--                       <th scope="col">제목</th> --> 
<!-- <!--                       <th scope="col">작성일</th> --> 
<!-- <!--                       <th scope="col">조회수</th> --> 
<!--                     </tr> -->
<!--                   </thead> -->
<!--                   <tbody id="noticeList"></tbody> -->
<!--                 </table> -->
<!--               </div> -->
<!--               <div class="paging_area" id="pagination"></div> -->
              <div class="btn-wrap">
                <c:if test="${sessionScope.userType eq 'E'}">
                </c:if>
              </div>
              <h3 class="hidden">풋터 영역</h3>
              <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
          </li>
        </ul>
      </div>
    </div>
  </form>
</body>
</html>
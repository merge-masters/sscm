<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 공급처 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

</script>

</head>
<body>
<form id="myForm" action=""  method="">
  
  <!-- 모달 배경 -->
  <div id="mask"></div>

  <div id="wrap_area">

    <h2 class="hidden">header 영역</h2>
    <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

    <h2 class="hidden">컨텐츠 영역</h2>
    <div id="container">
      <ul>
        <li class="lnb">
          <!-- lnb 영역 --> 
          <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
        </li>
        <li class="contents">
          <!-- contents -->
          <h3 class="hidden">contents 영역</h3> <!-- content -->
          <div class="content">

            <p class="Location">
              <a href="#" class="btn_set home">메인으로</a> <span
                class="btn_nav bold">기준 정보</span> <span class="btn_nav bold">공급처 관리
                </span> <a href="../scm/supplierInfo.do" class="btn_set refresh">새로고침</a>
            </p>

            <p class="conTitle">
              <span>납품 업체</span> <span class="fr"> 
              </span>
            </p>
            
            <div class="div">
              <table class="col">
                <caption>caption</caption>
                <colgroup>
                  <col width="25%">
                  <col width="20%">
                  <col width="20%">
                  <col width="15%">
                  <col width="30%">
                </colgroup>
  
                <thead>
                  <tr>
                    <th scope="col">납품업체명</th>
                    <th scope="col">LOGIN ID</th>
                    <th scope="col">패스워드</th>
                    <th scope="col">담당자명</th>
                    <th scope="col">담당자 연락처</th>
                  </tr>
                </thead>
                <tbody id="list"></tbody>
              </table>
            </div>
  
            <div class="paging_area"  id="Pagination"> </div>
            
            
            
            <table style="margin-top: 10px" width="100%" cellpadding="5" cellspacing="0" border="1"
                        align="left"
                        style="collapse; border: 1px #50bcdf;">
                        <tr style="border: 0px; border-color: blue">
                           <td width="80" height="25" style="font-size: 120%;">&nbsp;&nbsp;</td>
                           <td width="50" height="25" style="font-size: 100%; text-align:left; padding-right:25px;">
                            <select id="searchKey" name="searchKey" style="width: 150px;" v-model="searchKey">
                  <option value="" >납품업체명</option>
                  <option value="" >제품명</option>
              </select> 
              
                             <input type="text" style="width: 300px; height: 25px;" id="sname" name="sname">                    
                             <a href="" class="btnType blue" id="btnSearchSupplier" name="btn"><span>검  색</span></a>
                           </td> 
                           
                        </tr>
                     </table> 
                     
            <p class="conTitle mt50">
              <span>상세 정보</span> <span class="fr"> 
              </span>
            </p>
  
            <div class="">
              <table class="col">
                <caption>caption</caption>
                <colgroup>
                  <col width="10%">
                  <col width="5%">
                  <col width="5%">
                </colgroup>
  
                <thead>
                  <tr>
                    <th scope="col">제품번호</th>
                    <th scope="col">제품명</th>
                    <th scope="col">납품단가</th>
                  </tr>
                </thead>
                <tbody id="">
                  <tr>
                    <td colspan="12">납품 업체를 선택해 주세요.</td>
                  </tr>
                </tbody>
              </table>
            </div>
            
            <div class="paging_area"  id=""> </div>

          </div> <!--// content -->

          <h3 class="hidden">풋터 영역</h3>
            <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
        </li>
      </ul>
    </div>
  </div>

  
</form>
</body>
</html>
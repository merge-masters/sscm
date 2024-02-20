<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공급처 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
 <script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<script type="text/javascript">
  //공급처정보 페이징 처리
  var pageSizeSupplier = 5; //공급처정보 페이지 사이즈
  var pageBlockSizeSupplier = 5; //공급처정보 페이지 블록 갯수
  
  //제품정보 페이징 처리 
  var pageSizeProduct = 5; //제품정보 페이지 사이즈
  var pageBlockSizeProduct = 5; //제품정보 페이지 블록 갯수
  
  var listSupplier; // 납품업체 리스트 조회
  
  //OnLoad event
  $(document).ready(function() {
	  
	  init();
	  
	  // 공급처 정보 조회
	  fSelectSupDetail();
  });
    
  
function init(){
  listSupplier = new Vue({
							el : "#listSupplier",
							data : {
								supplierlist : [],
								supdetail: [],
								supplierPagination : {pagenavi : ''}
							},
							methods : {
								supdetail : function(supplynm){
									fSelectSupDetail(supplynm);
								}
							}
  })
}
 function fSelectSupDetail(supplynm){
	  currentPage = currentPage.value || 1;
	  
	  var sname = "";
	  var oname = "";
	  
	  var param = {
			  currentPage : currentPage,
			  pageSize : pageSizeSupplier
	  }
	  
	 axios.post('listSupplierVue.do', param)
	  	  .then(response => {
	  		  console.log(response);
	  		//console.log("!!!!!!!!!!!!!!!" + JSON.stringify(param));
	  		
	  	  listSupplier.supdetail = response.data.listSupplierModel;
	  	  listSupplier.supplierlist = response.data.listSupplierModel;
		  var totalListSupDeatil = response.data.totalSupplier;
		  
			// 페이지 네비게이션 생성
			
			var paginationHtml = getPaginationHtml(currentPage, totalListSupDeatil, pageSizeSupplier, pageBlockSizeSupplier, 'fSelectSupDetail');
			console.log("paginationHtml : " + paginationHtml);
			
			listSupplier.supplierPagination.pagenavi = paginationHtml;
	  	  })
	  	  .catch(error => {
	  		  console.log(error);
	  	  }) 
  }
  
</script>
</head>
<body>
<form id="myForm" action="" method="">
	<input type="hidden" id="currentPage" value="1">
    <input type="hidden" id="currentPageSupplier" value="1">
    <input type="hidden" id="currentPageProduct" value="1"> 
    <input type="hidden" id="tmpsupply_nm" value="">  
    <input type="hidden" id="tmpsupply_cd" value="">
    <input type="hidden" name="action" id="action" value="">
    <div id="mask"></div>
    <div id="wrap_area">
    
        <h2 class="hidden">header 영역</h2>
          <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
          <h2 class="hidden">컨텐츠 영역</h2>
          <div id="container">
          <ul>
                  <li class="lnb">
                  <!-- lnb 영역 --> <jsp:include
                       page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
          </li>
          
                  <li class="contents">
                       <!-- contents -->
                       <h3 class="hidden">contents 영역</h3> <!-- content -->
                       <div class="content">
                       
                            <p class="Location">
                                 <a href="/system/notice.do" class="btn_set home">메인으로</a> 
                                 <a class="btn_nav">기준 정보</a>
                                  <span class="btn_nav bold">공급처 관리</span> 
                                 <a href="" class="btn_set refresh">새로고침</a>
                            </p>
                            
                            <p class="conTitle">
                                 <span>공급처 정보</span>
                                 <span class="fr"> 
                                 <a href="javascript:fPopModalSupplier()" class="btnType blue" name="modal"  style="float: right;">
                                      <span>신규등록</span>
                                      </a>
                    
                  
                                      
                                 </span>
                            </p>  
                            
                    <div class="SupplierList">
                    <div class="conTitle" style="margin: 0 25px 10px 0; float: left;">
                           <select id="searchKey" name="searchKey" style="width: 100px;" v-model="searchKey">
                           <option value="all" selected="selected">전체</option>
                           <option value="supply_nm">공급처명</option>
                           <option value="supply_mng_nm">담당자명</option>
                        </select>
                        <input type="text" style="width: 300px; height: 30px;" id="sname" name="sname">
                            <a href="" class="btnType blue" id="searchBtn" name="btn"> 
                            <span>검 색</span>
                            </a> 
                    </div>
                    	<div id="listSupplier">
                         <table class="col">
                                <caption>caption</caption>
                                    <colgroup>
                                    <col width="10%">
                                    <col width="10%">
                                    <col width="17%">
                                    <col width="10%">
                                    <col width="17%">
                                    <col width="16%">
                                    <col width="10%">
                                    <col width="10%">
                                </colgroup> 
                                
                                <thead>
                                    <tr>
                                        <th scope="col">공급처코드</th>
                                        <th scope="col">공급처명</th>
                                        <th scope="col">연락처</th>
                                        <th scope="col">담당자명</th>
                                        <th scope="col">담당자 연락처</th>
                                        <th scope="col">이메일</th>
                                        <th scope="col">창고명</th>   
                                        <th scope="col">비고</th>  
                                    </tr>
                                </thead> 
                                <tbody v-for="(item, index) in supplierlist" v-if="supplierlist.length">
                                	<tr v-on:click="supdetail(item.supply_nm)">
                                		<td>{{item.supply_cd}}</td>
                                		<td>{{item.supply_nm}}</td>
                                		<td>{{item.tel}}</td>
                                		<td>{{item.supply_mng_nm}}</td>
                                		<td>{{item.mng_tel}}</td>
                                		<td>{{item.email}}</td>
                                		<td>{{item.warehouse_nm}}</td>
                                		<td></td>
                                	</tr>
                                </tbody>                      
                         </table>  
                   </div>
                       
                   <div class="paging_area" id="supplierPagination" v-html="pagenavi"></div>
                   </div>
                   
                   
                   
                   <p class="conTitle mt50">
                      <span>공급 제품정보<span id="subTitle"></span></span>
                      
                   </p>
                   
                   <div class="ProductList">
                        <table class="col">
                             <caption>caption</caption>
                             <colgroup>
                                 <col width="15%">
                                 <col width="15%">
                                 <col width="15%">
                                 <col width="15%">
                             </colgroup>
                        <thead>
                             <tr>
                                <th scope="col">제품코드</th>
                                <th scope="col">제품명</th>
                                <th scope="col">품목명</th>
                                <th scope="col">장비구매액(원)/EA</th>
                             </tr>
                        </thead>
                        <tbody id="listSupplierProduct">
                             <tr>
                                <td colspan="6">공급처를 선택해 주세요.</td>
                             </tr>
                        </tbody>
                        </table>
                   </div>
                         
                   <div class="paging_area" id="productPagination"></div>
                   
                   
              </div>
                  
                       <h3 class="hidden">풋터 영역</h3> 
                        <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
                  </li>
              </ul>
          </div>     
    </div>
    
    <!-- 모달 -->
    
    <div id="layer1" class="layerPop layerType2" style="width: 600px;"> 
      <dl>
        <dt>
          <strong>공급처 관리</strong>
        </dt>
        <dd class="content">
          <table class="row">
            <caption>caption</caption>
            <colgroup>
              <col width="120px">
              <col width="*">
              <col width="120px">
              <col width="*">
            </colgroup>
            <tbody>
              <tr>
                <th scope="row">공급처명 <span class="font_red">*</span></th>
                 <td colspan=3><input type="text" class="inputTxt p100"
                  name="supply_nm" id="supply_nm" maxlength="100"/></td>
              </tr>
              <tr>
                <th scope="row">공급처코드 <span class="font_red">*</span></th>
                 <td><input type="text" class="inputTxt p100"
                  name="supply_cd" id="supply_cd" maxlength="20"/></td>
                <th scope="row">연락처<span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100" name="tel"
                  id="tel" maxlength="20"/></td>
              </tr>
              <tr>
                <th scope="row">담당자명 <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="supply_mng_nm" id="supply_mng_nm" maxlength="50"/></td>  
                                  
                <th scope="row">담당자 연락처<span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100" 
                name="mng_tel" id="mng_tel" maxlength="20"/></td>
              
              </tr>
              
              <tr>
                <th scope="row">이메일 <span class="font_red">*</span></th>
                <td colspan=3><input type="text" class="inputTxt p100"
                  name="email" id="email" maxlength="100"/></td>           
              </tr>
              <tr>
                <th scope="row">창고코드 <span class="font_red">*</span></th>
                <td><input type="text" class="inputTxt p100"
                  name="warehouse_cd" id="warehouse_cd" /></td>
                <th scope="row">창고명</th>
                <td><select id="warehouse_nm" name="warehouse_nm" onChange="javascript:selectwarehouse()"></select></td>
              </tr>
            </tbody>
          </table>
          
          
          <div class="btn_areaC mt30">
            <a href="" class="btnType blue" id="btnSaveSupplier" name="btn"><span>저장</span></a>
            <a href="" class="btnType blue" id="btnDeleteSupplier" name="btn"><span>삭제</span></a>  
            <a href="" class="btnType gray" id="btnCloseSupplier" name="btn"><span>닫기</span></a>
            
          </div>
        
       
        </dd>
      </dl>
      <a href="" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>
    </div>
</form>
</body>
</html>
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
var pageSize = 5;
var pageBlock = 5;

/* OnLoad Event */
$(function(){
	
	// fPurchaseOrderListData();
	selectPurchaseOrderList();
	
	inputPurchaseDate();
	
	// 검색 버튼 클릭 시
	$("#search_button").on("click", function(){
		
		isSearch = true;
		
		searchKey = $("#searchKey").val();
		sname = $("#sname").val();
		
		selectPurchaseOrderList();
	})
	// onLoad 끝
	
	var sname;
	var searchKey;
	var isSearch;
	
	/* 발주지시서 목록 조회 함수 */
	function selectPurchaseOrderList(currentPage){
		currentPage = currentPage || 1;
		
		var param = {
			currentPage : currentPage,
			pageSize : pageSize,
			sname : $("sname").val(),
			searchKey : $("#searchKey").val().trim()
		};
		
		if(isSearch){
			param.sname = sname
			param.searchKey = searchKey
		} 
		
		// 콜백
		var resultCallback = function(result){
			selectPurchaseOrderListCallback(result, currentPage);
		};
		
		callAjax("/deli/selectPurchaseOrderList.do", "post", "text", true, param, resultCallback);
	}
	
	/* 발주지시서 목록 조회 콜백 함수 */
	function selectPurchaseOrderListCallback(result, currentPage){
		
		// 기존 목록 삭제
		$("#purchaseOrderList").empty();
		
		// 신규 목록 생성
		$("#purchaseOrderList").append(result);
		
		// 리스트 로우의 총 개수 추출
		var totalCount = $("#totalCount").val();
		
		// 페이지 네비게이션 생성
	    var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSize, pageBlock, 'selectList');
	    $("#pagination").empty().append(paginationHtml);

	    // 현재 페이지 설정
	    $("#currentPageCod").val(currentPage);
	}
	
	function inputPurchaseDate(){
	  	var date = document.querySelector("#sname");
	  	
	  	// 문자열, 하이픈을 막기 위해 input event 사용
	  	date.addEventListener("input",()=>{
	  		
	  		// 사용자 입력값은 모두 숫자만 받는다(나머지는 "" 처리)
	  		let val = date.value.replace(/\D/g,"");
	  		let leng = val.length;
	  		
	  		// 출력할 결과 변수
	  		let result ='';
	  		
	  		// 5개일 때
	  		if(leng < 6) result = val;
	  		
	  		// 6~7개일 때
	  		else if(leng <8){
	  			result += val.substring(0,4);
	  			result += "-";
	  			result += val.substring(4);
	  		} else {
	  			// 8개일 때
	  			result += val.substring(0,4);
	  			result += "-";
	  			result += val.substring(4,6);
	  			result += "-";
	  			result += val.substring(6);
	  		}
	  		
	  		date.value = result;
	  	})
	}
})

/*
 function fPopModalDeliStart(purchase_code, product_code,product_name,product_model_number, product_model_name ,produce_company_name,purchase_total_price){
	
	$("#purchase_code").val(purchase_code).prop('readonly', true);
	$("#product_code").val(product_code).prop('readonly', true);
	$("#product_model_number").val(product_model_number).prop('readonly', true);
	$("#product_model_name").val(product_model_name).prop('readonly', true);
	$("#produce_company_name").val(produce_company_name).prop('readonly', true);
	$("#product_name").val(product_name).prop('readonly', true);
	$("#purchase_total_price").val(purchase_total_price).prop('readonly', true);
	
	gfModalPop("#layer1");
}
 */
  function purchaseOrderDetailList(purchase_code, currentPage){
	 currentPage = currentPage || 1;
	 
	 var param ={
			 currentPage : currentPage
		   , purchase_code : purchase_code
		   , pageSize : pageSize
	 }
	 
	 var resultCallback = function(data){
		 purchaseOrderDetailListResult(data, currentPage);
	 };
	 
	 callAjax("purchaseOrderDetail.do", "post", "text", true, param, resultCallback);
	 
 }
 
 function purchaseOrderDetailListResult(data, currentPage){
	 $("#purchaseOrderDetailList").empty();

	 $("#purchaseOrderDetailList").append(data);
	 
		var totalCount = $("#totalCount").val();
		
		// 페이지 네비게이션 생성
	    var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSize, pageBlock, 'selectList');
	    $("#pagination").empty().append(paginationHtml);

	    // 현재 페이지 설정
	    $("#currentPageCod").val(currentPage);
 }

 $(function(){
 $("#startDelivery").on('click', function(){
    var purchaseCode = $(this).closest('tr').find('.purchase_code').text();
    
    console.log(purchaseCode);

    if(purchaseCode == null){
		if(confirm("발주 처리하시겠습니까?")){
			$.ajax({
				type : "POST",
				url : "deli/startShipping.do",
				data : {purchaseCode : purchaseCode},
				success: function(response){
					alert("발주 처리되었습니다.");
					//location.href = "deli/"
				},
				error : function(error){
					
				}
			})
			
		} 
		} else {
			alert("발주서를 먼저 선택해주세요.");	
		}
 	})
 })
 

</script>
</head>
<body>
	<form id="purchasePaperList" action="" method="" onsubmit="return false">
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
              <p class="Location">
                <a href="#" class="btn_set home">메인으로</a><span class="btn_nav bold">배송</span><span class="btn_nav bold">출하계획</span> <a href="javascript:window.location.reload();" class="btn_set refresh">새로고침</a>
              </p>
              <p class="conTitle">
              <span>발주서 목록</span>
            </p>
              <form class="search-container">
                <div class="row">
                  <!-- searchbar -->
                  <div class="col-lg-6">
                    <div class="input-group">
                      <select style="width: 90px; height: 34px;"  id="searchKey" name="searchKey" >
                        <option value="select_all" id="select_all"selected>전체</option>
                        <option value="pc_company" id="pc_company">업체명</option>
                        <option value="purchase_date" id="purchase_date">발주처리일</option>
                      </select> <input type="text" class="form-control" aria-label="..." id="sname" name="sname" autocomplete="off">
                    </div>
                  </div>
                  <!-- // searchbar -->
                  <!-- button -->
                  <div class="btn-group" role="group" aria-label="...">
                    <button type="button" class="btn btn-default" id="search_button">검색</button>
                  </div>
                  <!-- // button -->
                </div>
                <!-- /.row -->
              </form>
              <div class="divPurchaseOrderList">
                <table class="col">
                  <caption>caption</caption>
                  <colgroup>
                    <col width="20%">
                    <col width="30%">
                    <col width="20%">
                    <col width="30%">
                  </colgroup>
                  <thead>
                    <tr href="">
                      <th scope="col">No.</th>
                      <th scope="col">업체명</th>
                      <th scope="col">총액</th>
                      <th scope="col">발주처리일</th>
                    </tr>
                  </thead>
                  <tbody id="purchaseOrderList"></tbody>
                </table>
                </div>
                
              <div class="paging_area" id="pagination"></div>
              
            <p class="conTitle mt50">
              <span>발주서 상세</span> <span class="fr"> <a
                class="btnType blue"  href="" name="modal" id="startDelivery"><span>발주처리</span></a>
              </span>
            </p>
  
            <div class="divPurchaseOrderListDetail">
              <table class="col">
                <caption>caption</caption>
                <colgroup>
                  <col width="6%">
                  <col width="10%">
                  <col width="10%">
                  <col width="15%">
                  <col width="10%">
                  <col width="10%">
                </colgroup>
  
                <thead>
                  <tr>
                    <th scope="col">장비번호</th>
                    <th scope="col">장비구분</th>
                    <th scope="col">모델번호</th>
                    <th scope="col">모델명</th>
                    <th scope="col">제조사</th>
                    <th scope="col">판매가격</th>
                  </tr>
                </thead>
                <tbody id="purchaseOrderDetailList">
                	<tr>
                    <td colspan="12">발주서를 선택해 주세요.</td>
                  </tr>
                </tbody>
              </table>
            </div>
            
              <div class="paging_area" id="pagination"></div>
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
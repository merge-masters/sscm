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

/* OnLoad event */
$(function() {
  // 발주지시서 목록 조회
  selectList();

  /* datepicker설정 */
  // formerDate datepicker
  $('#datetimepicker1').datetimepicker({
  //format : 'L',
  format : 'YYYY-MM-DD',
  formatDate : 'YYYY-MM-DD'
  });

  $('#datetimepicker2').datetimepicker({
  format : 'L',
  useCurrent : false
  });

  $("#datetimepicker1").on("change.datetimepicker", function(e) {
    var date = $("#datetimepicker1").find("input").val()
    $('#datetimepicker2').datetimepicker('minDate', e.date);
  });

  // latterDate datepicker
  $('#datetimepicker3').datetimepicker({
  //format : 'L',
  format : 'YYYY-MM-DD',
  formatDate : 'YYYY-MM-DD'
  });

  $('#datetimepicker4').datetimepicker({
  format : 'L',
  useCurrent : false
  });

  $("#datetimepicker3").on("change.datetimepicker", function(e) {
    var date = $("#datetimepicker3").find("input").val()
    $('#datetimepicker4').datetimepicker('minDate', e.date);
    
  });
    
    // 검색 버튼 클릭 시
    $('#search_button').on('click', function() {
        
        isSearch = true;
        var validate = validateDate(); 
        
        if (validate) {
          
          searchKey = $('#searchKey').val();
          sname = $('#sname').val();
		  unapproved = $("#pc_unapproved").val();	
		  approved = $("#pc_approved").val();	
          formerDate = $("#datetimepicker1").find("input").val();
          latterDate = $("#datetimepicker3").find("input").val();
        
          selectList();
        }
        else {
          return false;
        }
      });

      // onload 끝
    });
  
  var sname;
  var searchKey;
  var formerDate;
  var latterDate;
  var isSearch;
  
  //날짜검증
  function validateDate() {
    
    var validateFormerDate = $("#datetimepicker1").find('input').val();
    var validateLatterDate = $("#datetimepicker3").find('input').val();
    var currentPage = 1;
    var delimiter = '-';
    var today = new Date();

    // JavsScript는 월이 0부터 시작하므로 +1
    // 오늘 날짜와 latterDate를 비교하기 위해서 형식 맞춰줘야 함
    today = today.getFullYear() + delimiter + ('0' + (today.getMonth() + 1)).slice(-2) + delimiter + ('0' + today.getDate()).slice(-2);
    
    // 날짜가 2개 중 하나라도 설정되면 반드시 2개다 설정되어야 함
    if ((!validateFormerDate && validateLatterDate) && (validateFormerDate && !validateLatterDate)) {
      swal('기간을 설정해 주세요');
      return false;
    } else if (validateFormerDate > validateLatterDate) {
      swal('기간을 확인해 주세요');
      return false;
    } else if (validateFormerDate > today || validateLatterDate > today ) {
      swal('오늘 이후는 검색할 수 없습니다');
      return false;
    } else {
      return true;
    }
  }
  
  /* 발주지시서 목록 조회 함수 */
  function selectList(currentPage) {
    currentPage = currentPage || 1;
    // 검색조건이 없을 경우의 파라미터
    var param = {
        currentPage : currentPage,
        pageSize : pageSize,
        sname : $('#sname').val(),
        formerDate : $("#datetimepicker1").find("input").val(),
        latterDate : $("#datetimepicker3").find("input").val()
        
    };
    
    if(isSearch){
        param.sname = sname
        param.searchKey = $('#searchKey').val().trim()
        unapproved = $("#pc_unapproved").val()
		approved = $("#pc_approved").val()
        param.formerDate = formerDate
        param.latterDate = latterDate
    }
    
    // 콜백
    var resultCallback = function(result) {
      selectListCallBack(result, currentPage);
    };
    callAjax("/order/purchasePaper.do", "post", "text", true, param, resultCallback);
  }

  /* 발주지시서 목록 조회 콜백 함수 */
  function selectListCallBack(result, currentPage) {

    // 기존 목록 삭제
    $('#purchaseList').empty();

    // 신규 목록 생성
    $("#purchaseList").append(result);

    // 리스트 로우의 총 개수 추출
    var totalCount = $("#totalCount").val();

    // 페이지 네비게이션 생성
    var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSize, pageBlock, 'selectList');
    $("#pagination").empty().append(paginationHtml);

    // 현재 페이지 설정
    $("#currentPageCod").val(currentPage);
  }
  

  
  /* 발주 지시서 모달 조회 */
  function fPopModalSendDeli(purchase_code, company_class_name, product_model_name, purchase_count, product_model_number, owner_approve_yn, deposit_check_yn)  {

	if(owner_approve_yn == 'Y' && deposit_check_yn == 'Y'){
	  $("#purchase_code").val(purchase_code).prop('readonly', true);
	  $("#company_class_name").val(company_class_name).prop('readonly', true);
	  $("#product_model_name").val(product_model_name).prop('readonly', true);
	  $("#purchase_count").val(purchase_count).prop('readonly', true);
	  $("#product_model_number").val(product_model_number).prop('readonly', true);
	  

	  // 모달 표시
	  gfModalPop("#layer1");
	} else {
	  alert("발주 처리를 할 수 없는 건입니다.");
    }
  
  }
  
 	 /* 발주 처리 */
	$(function(){
	   $("#startDelivery").click(function(){
		   var currentButton = $(this);
		   var param = $("#purchase_code").val();
		   
		   console.log(param);
		   
		   $.ajax({
	            type: "POST",
	            url: "/order/startDelivery.do",
	            data: { param: param },
	            success: function(response) {
	            	if (response === "DUPLICATE") {
	                    alert("이미 발주된 건입니다.");
	                } else {
	                alert("완료되었습니다.");
	                currentButton.prop('disabled', true);
	                // location.href = "/order/purchasePaper.do";
	                }
	                
	            },
	            error: function(error) {
	                // 실패 시 실행할 코드
	            }
	        });
		   
	   })
	})

</script>
</head>
<body>
<form id="purchasePaperList" action="" method="">
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
                <a href="#" class="btn_set home">메인으로</a><span class="btn_nav bold">구매</span><span class="btn_nav bold">발주지시서</span> <a href="javascript:window.location.reload();" class="btn_set refresh">새로고침</a>
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
                        <option value="pc_company" id="pc_company"selected>업체</option>
                        <option value="pc_product" id="pc_product">제품</option>
                        <option value="pc_unapproved" id="pc_unapproved">미승인</option>
                        <option value="pc_approved" id="pc_approved">승인</option>
                      </select> <input type="text" class="form-control" aria-label="..." id="sname" name="sname" autocomplete="off" placeholder="제품명 또는 기업명 입력">
                    </div>
                  </div>
                  <!-- // searchbar -->
                  <!-- datepicker -->
                  <div class='col-md-3 col-xs-4'>
                    <div class="form-group">
                      <div class="input-group date" id="datetimepicker1" name ="datetimepicker1" data-target-input="nearest">
                        <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker1" value="">
                        <div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker">
                          <div class="input-group-text">
                            <i class="fa fa-calendar"></i>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <span class="divider">~</span>
                  <div class='col-md-3 col-xs-4'>
                    <div class="form-group">
                      <div class="input-group date" id="datetimepicker3" name ="datetimepicker3" data-target-input="nearest">
                        <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker3" value="">
                        <div class="input-group-append" data-target="#datetimepicker3" data-toggle="datetimepicker">
                          <div class="input-group-text">
                            <i class="fa fa-calendar"></i>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <!-- // datepicker -->
                  <!-- button -->
                  <div class="btn-group" role="group" aria-label="...">
                    <button type="button" class="btn btn-default" id="search_button">검색</button>
                  </div>
                  <!-- // button -->
                </div>
                <!-- /.row -->
              </form>
              <div class="divComGrpCodList">
                <table class="col">
                  <caption>caption</caption>
                  <colgroup>
                    <col width="8%">
                    <col width="15%">
                    <col width="15%">
                    <col width="10%">
                    <col width="15%">
                    <col width="10%">
                    <col width="10%">
                  </colgroup>
                  <thead>
                    <tr href="javascript:fPopModalSendDeli();">
                      <th scope="col">발주번호</th>
                      <th scope="col">발주회사</th>
                      <th scope="col">발주제품</th>
                      <th scope="col">발주수량</th>
                      <th scope="col">날짜</th>
                      <th scope="col">임원승인여부</th>
                      <th scope="col">입금확인</th>
                    </tr>
                  </thead>
                  <tbody id="purchaseList"></tbody>
                </table>
              </div>
              <div class="paging_area" id="pagination"></div>
              <h3 class="hidden">풋터 영역</h3>
              <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
          </li>
        </ul>
      </div>
    </div>
		<jsp:include page="/WEB-INF/view/order/checkPurchasePopUp.jsp"></jsp:include>
  </form>
</body>
</html>
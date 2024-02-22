<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>반품신청 목록 :: ChainMaker</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<link rel="stylesheet" href="${CTX_PATH}/css/view/scm/orderList.css">
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue@2.6.0"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>
<script>
	//반품신청 목록 페이징 설정
	
	var currentPage = 1;
	var pageSizeRefundList = 5;
	var pageBlockSizerefundList = 10;
	
	var refundList;
	var detailItem;


	$(document).ready(function() {
	  // 반품신청 목록
	  init()
// 	  getRefundList();
	  
	});
	
	function init() {
		refundList = new Vue({
			el: '#divListProject',
			data: {
				refundListData: [],
				totalCount: 0,
				param: {
					currentPage : currentPage,
					pageSize: pageSizeRefundList
				}
			},
			created: function() {
				axios({
					url: '/scm/refundListinfoVue.do',
					method: 'post',
					async: true,
					data: this.param,
				})
				.then(function(response) {
					console.log("SUCCESS", response.data);
					getRefundListResult(response.data);
				})
				.catch(function(error) {
					console.log("error : " + error);
				})
			},
			methods: {
				detailView: function(num) {
					alert(num);
					getRefundDetail(num)
				}
			}
		})	
	}
	
	/** 반품신청 목록 조회 콜백 함수 */
	function getRefundListResult(data, currentPage) {
	  console.log(data);
	  refundList.refundListData = data.refundList;
	  refundList.totalCount = data.refundListCnt;
	  // 기존 목록 삭제
// 	  $('#refundListHistory').empty().append(data);
	
	  // 총 개수 추출
// 	  let totalCnt = $("#totcnt").val();
// 	  console.log(totalCnt);
	  // 페이지 네비게이션 생성
	  var paginationHtml = getPaginationHtml(currentPage, refundList.totalCount, pageSizeRefundList, pageBlockSizerefundList, 'searchRefundList');
	
// 	  $("#refundListPagination").empty().append(paginationHtml);
	
	  // 현재 페이지 설정
// 	  $("#currentPage").val(currentPage);
	  
	};

	/** 반품신청 목록 조회 */
// 	function getRefundList(currentPage) {
	  
// 	  currentPage = currentPage || 1;
	
// 	  console.log("currentPage : " + currentPage);
	
// 	  var param = {
// 	    currentPage: currentPage, 
// 	    pageSize: pageSizeRefundList
// 	  };
	
// 	  var resultCallback = function(data) {
// 	    getRefundListResult(data, currentPage);
// 	  };
	  
// 	  callAjax("/scm/refundListinfoVue.do", "post", "json", true, param, resultCallback);
// 	};
	

	
	function getRefundDetail(orderCode) {
		console.log(orderCode);
	  
		detailRefund = new Vue({
			el: '#detailRefund',
			data: {
				detailData : [],
				param: {
					orderCode : orderCode
				}
			},
			mounted: function() {
				axios({
					url: '/scm/refundDetailInfoVue.do',
					method: 'post',
					async: true,
					data: this.param,
				})
				.then(function(response) {
					console.log("SUCCESS", response.data);
					getRefundDetailResult(response.data.refundDetail);
				})
				.catch(function(error) {
					console.log("error : " + error);
				})
			},
		})
	  
// 	  var param = {
// 	      orderCode: orderCode
//  	  };
	  
//  	  var resultCallback = function(data) {
// 	    getRefundDetailResult(data);
//  	  }
	  
//  	  callAjax("/scm/refundDetailInfo.do", "post", "text", true, param, resultCallback);
 	};
	
 	function getRefundDetailResult(data) {
	  console.log(data);
		 var resultHTML = "<p class=\"conTitle\" style=\"margin-bottom: 1%;\">" +
	 	 "<span>반품지시서</span>" +
      	"</p>" +
      	"<table class=\"col\">" +
      	"<thead>" +
      	"<tr>" +
      	"<th>SCM 관리자</th>" +
      	"<th>반품지시일자</th>" +
      	"<th>제품번호</th>" +
      	"<th>주문일자</th>" +
      	"<th>제품명</th>" +
      	"<th>품목명</th>" +
      	"</tr>" +
      	"</thead>" +
      	 "<tbody>" +
         "<tr>" +
         "<td>" + data.scmManager + "</td>" +
         "<td>" + data.refundDate + "</td>" +
         "<td>" + data.productCode + "</td>" +
         "<td>" + data.orderDate + "</td>" +
         "<td>" + data.productName + "</td>" +
         "<td>" + data.middleCategory +"</td>" +
         "</tr>" +
         "</tbody>" +
         "<thead>"+
         "<tr>"+
     	"<th>공급처명</th>" +
      	"<th>반품일자</th>" +
      	"<th>창고명</th>" +
      	"<th>반품수량</th>" +
      	"<th>반품금액(원)</th>" +
      	"<th>상태</th>" +
      	"</tr>" +
      	"</thead>"+
      	 "<tbody>" +
         "<tr>" +
         "<td>" + data.supplyName + "</td>" +
         "<td>" + data.refundDate + "</td>" +
         "<td>" + data.warehouseName + "</td>" +
         "<td>" + data.refundCount + "</td>" +
         "<td>" + data.refundAmount + "</td>" +
         "<td>" + data.state +"</td>" +
         "</tr>" +
         "</tbody>" +
         "</table>";
	
	 var result =  document.getElementById('detailResult');
	 result.innerHTML  = resultHTML;
 	  $('#detailRefund').empty().append(result);
 	};
	
// 	function closeRefundDetail() {
// 	  $('#detailRefund').empty();
// 	}
	
// 	function requestApprove() {
// 	  var param = $('#refundForm').serialize();
	  
// 	  var resultCallback = function(data) {
// 	    getRefundApproveResult(data);
// 	  }
	  
// 	  callAjax("/scm/refundDirectionInsert.do", "post", "json", true, param, resultCallback);
// 	}
	
// 	function getRefundApproveResult(data) {
// 	  if (data.result === "SUCCESS") {
// 	    swal(data.resultMsg).then(function() {
// 	      window.location.reload(); // 새로고침
// 	    });
// 	    console.log("상태 업데이트 완료");
// 	    return 1;
// 	  } else {
// 	    swal(data.resultMsg).then(function() {
// 	      window.location.reload(); // 새로고침
// 	    });
// 	    console.log("상태 업데이트 실패");
// 	    return 0;
// 	  }
// 	}
	
	// 반품신청목록 검색 기능
// 	function searchRefundList(currentPage) {
// 	  var param = $('#refundListForm').serialize();
// 	  console.log(param);
	  
// 	  currentPage = currentPage || 1;
	  
// 	  param += "&currentPage="+currentPage;
// 	  param += "&pageSize="+pageSizeRefundList;
	  
// 	  var startD = $('#startDate').val();
// 	  var endD = $('#endDate').val();
	  
// 	  console.log(param);
	  
// 	  // 날짜 에러 있을 때, 경고창 띄우고 refresh
// 	  if (startD > endD) {
// 	    swal("시작일자가 종료일자보다 뒤에 있을 수 없습니다.\n날짜를 다시 지정해주세요.").then(function() {
// 	      window.location.reload();
// 	    });
// 	    return 0;
// 	  } 
	  
// 	  var resultCallback = function(data) {
// 	    getRefundListResult(data, currentPage);
// 	  };
	  
// 	  callAjax("/scm/refundListInfo.do", "post", "text", true, param, resultCallback);
// 	}
	
// 	$('input[type="text"]').keydown(function(event) {
// 	  if (event.keyCode === 13) {
// 	    searchRefundList();
// 	  };
// 	});
	
	//function fExcelDownload(tableID, fileID){
	//   $("#"+tableID).table2excel({
	//     exclude: ".noExl",
	//     name: "Excel Document Name",
	//     filename: fileID +'.xls', // 확장자를 여기서 붙여줘야한다.
	//     fileext: ".xls",
	//     exclude_img: true,
	//     exclude_links: true,
	//     exclude_inputs: true
	//     });
	//}
</script>
<body>
	<input type="hidden" id="currentPage" value="1">
	<div id="wrap_area">
		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
					<!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3>
					<div class="content" style="margin-bottom: 20px;">
						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home"></a> 
							<span class="btn_nav">거래내역</span> 
							<span class="btn_nav bold">반품신청 목록</span> 
							<a href="../scm/refundList.do" class="btn_set refresh"></a>
						</p>
						<p class="conTitle" style="margin-bottom: 1%;">
							<span>반품신청 목록</span>
						</p>
						<!-- 주문상태 체크박스 필터링 -->
						<form id="refundListForm" method="post">
							<div class="refund-container">
								<div class="date_container1">
									<select name="searchType" id="searchType">
										<option value="" selected>전체</option>
										<option value="customerName" <c:if test="${searchType eq 'customerName'}">selected</c:if>>기업고객명</option>
										<option value="productName" <c:if test="${searchType eq 'productName'}">selected</c:if>>제품명</option>
									</select>
									<input type="text" name="keyword" value="${keyword != null ? keyword : ''}"/>
								</div>
								<!-- 날짜 필터링 -->
								<div class="date_container2">
									<input type="date" name="startDate" id="startDate" > 
									<span>~</span> 
									<input type="date" name="endDate" id="endDate">
									<a class="btnType3 color2" id="refundListSearchBtn" href="javascript:searchRefundList();" style="padding-top: 2px;">검색</a>
								</div>
							</div>
							<div class="refund-container">
								<div class="filter filter-perchase">
									<input type="checkbox" id="check_3" name="check_3" value="3"> 
										<label for="check_9">반품대기</label> 
									<input type="checkbox" id="check_4" name="check_4" value="4"> 
										<label for="check_10">승인대기(반품)</label> 
									<input type="checkbox" id="check_5" name="check_5" value="5"> 
										<label for="check_11">승인완료(반품)</label> 
									<input type="checkbox" id="check_6" name="check_6" value="6"> 
										<label for="check_12">반품진행중</label>
									<input type="checkbox" id="check_7" name="check_7" value="7"> 
										<label for="check_13">반품완료</label> 
								</div>
								<!-- Excel 출력 아이콘 -->
								<img id="excelExport" src='/images/excel/excel.png' onclick="fExcelDownload('dailyOrderTable', '일별 수주 내역');">
							</div>
						</form>
						<br>
						<!-- 프로젝트 조회 -->
						<div id="divListProject">
							<table class="col" id="refundListTable">
								<caption>caption</caption>
								<thead>
									<tr >
										<th scope="col">주문코드</th>
										<th scope="col">기업고객명</th>
										<th scope="col">제품명</th>
										<th scope="col">품목명</th>
										<th scope="col">반품신청날짜</th>
										<th scope="col">반품수량</th>
										<th scope="col">반품금액(원)</th>
										<th scope="col">상태</th>
									</tr>
								</thead>
								<tbody id="refundListHistory" 
									v-for="(item, index) in refundListData" 
									:key="item.orderCode" 
									v-if="refundListData.length">
									<tr @click="detailView(item.orderCode)"> 
										<td>{{item.orderCode}}</td>
										<td>{{item.customerName}}</td>
										<td>{{item.productName}}</td>
										<td>{{item.middleCategory}}</td>
										<td>{{item.refundDate}}</td>
										<td>{{item.refundCount}}</td>
										<td>{{item.refundAmount}}</td>
										<td>{{item.state}}</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="paging_area" id="refundListPagination"></div>
						<div id="detailRefund">
							<div id='detailResult'></div>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>
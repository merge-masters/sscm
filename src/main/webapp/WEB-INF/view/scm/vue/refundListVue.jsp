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
	
	var currentPage = "1";
	var pageSizeRefundList = "3";
	var pageBlockSizerefundList = "10";
	
	var refundList;
	var detailItem;
	var pageVue;

	$(document).ready(function() {
	  // 반품신청 목록
	  init()
// 	  getRefundList();
	  
	});
	
	function init() {
		// 반품신청 목록 리스트 Vue
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
		
		//반품 신청 목록 검색 vue
		refundListForm = new Vue({
			el:'#refundListForm',
			methods: {
				searchRefund : function() {
					searchRefund();
				}
			}
		})
		
		pageVue = new Vue({
		})
		
	}
	
	/** 반품신청 목록 조회 콜백 함수 */
	function getRefundListResult(data, currentPage) {
	  console.log(data);
	  refundList.refundListData = data.refundList;
	  refundList.totalCount = data.refundListCnt;
	  
	  // 총 개수 추출
	  console.log(refundList.totalCount);
	  console.log(data.refundListCnt)
	  // 페이지 네비게이션 생성
// 	  var paginationHtml = getPaginationHtmlVue(currentPage, refundList.totalCount, pageSizeRefundList, pageBlockSizerefundList, 'searchRefundList');
	
// 	  $("#refundListPagination").empty().append(paginationHtml);
	
	  // 현재 페이지 설정
// 	  $("#currentPage").val(currentPage);
	  
	};

	// 반품 지시서 디테일 불러오기
	function getRefundDetail(orderCode) {
		console.log(orderCode);
	  
		//반품 지시서 Detail Vue
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
 	};
	
 	// 반품지시서 디테일 그리기
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
 	
 	// 반품신청 목록 검색
 	function searchRefund() {
 		console.log('검색기능 구현 test');
		
		var param = $('#refundListForm').serialize();
		console.log(param);
	 	currentPage = currentPage || 1;
		  
	 	param += "&currentPage="+currentPage;
	 	param += "&pageSize="+pageSizeRefundList;
		  
	 	var startD = $('#startDate').val();
	 	var endD = $('#endDate').val();
		  
	 	console.log(param);
		  
	 	// 날짜 에러 있을 때, 경고창 띄우고 refresh
	 	if (startD > endD) {
	 	  swal("시작일자가 종료일자보다 뒤에 있을 수 없습니다.\n날짜를 다시 지정해주세요.").then(function() {
	 	    window.location.reload();
	 	  });
	 	  return 0;
	 	}
	 	
	 	var paramJson = serializeToJson(param)
	 	
	 	console.log(paramJson);
	 	
	 	 axios({
				url: '/scm/refundListinfoVue.do',
				method: 'post',
				async: true,
				data: paramJson,
			})
			.then(function(response) {
				console.log("SUCCESS===search", response.data);
				getRefundListResult(response.data);
			})
			.catch(function(error) {
				console.log("error : " + error);
			})
 	}
 	
 	function serializeToJson(serializedString) {
 	    let jsonObject = {};
 	    serializedString.split('&').forEach(function(keyValue) {
 	        let keyValueArray = keyValue.split('=');
 	        let key = decodeURIComponent(keyValueArray[0]);
 	        let value = decodeURIComponent(keyValueArray[1]);
 	        if (!jsonObject[key]) {
 	            jsonObject[key] = value;
 	        } else if (Array.isArray(jsonObject[key])) {
 	            jsonObject[key].push(value);
 	        } else {
 	            jsonObject[key] = [jsonObject[key], value];
 	        }
 	    });
 	    return jsonObject;
 	}
 	
 	/**
 	 * 링크를 적용한 페이징 태그 생성
 	 * @param  currentPage 현재 페이지
 	 * @param  totalCount 총 건수
 	 * @param  pageRow 페이지당 보여주는 목록 갯수
 	 * @param  blockPage 페이지 번호 갯수 
 	 * @param  pageFunc  페이지 번호를 클릭하면 호출할 함수 객체
 	 * @param  exParams  pageFunc에 넘겨줄 추가적인 파라미터 ( optional / 가능한 파라미터 형식: 문자열 )
 	 * @return html 문자열
 	 */
//  	function getPaginationHtmlVue(currentPage, totalCount, pageRow, blockPage, pageFunc, exParams)
//  	{	
//  		totalCount = parseInt(totalCount);
//  		pageRow = parseInt(pageRow);
//  		blockPage = parseInt(blockPage);
 	
//  		var totalPage = Math.ceil(totalCount / pageRow);
//  		if (totalPage == 0) {
//  			totalPage = 1;
//  		}

//  		// 현재 페이지가 전체 페이지 수보다 크면 전체 페이지 수로 설정
//  		if (currentPage > totalPage) {
//  			currentPage = totalPage;
//  		}

//  		// 현재 페이지의 처음과 마지막 글의 번호 가져오기.
//  		var startCount = (currentPage - 1) * pageRow;
//  		var endCount = startCount + pageRow;

//  		// 시작 페이지와 마지막 페이지 값 구하기.
//  		startPage = Math.floor((currentPage - 1) / blockPage) * blockPage + 1;
//  		endPage = startPage + blockPage - 1;

//  		// 마지막 페이지가 전체 페이지 수보다 크면 전체 페이지 수로 설정
//  		if (endPage > totalPage) {
//  			endPage = totalPage;
//  		}
 		
//  		// 추가 파라미터가 있는 경우 함수 호출 파라미터로 적용
//  		var sExParam = exParams==undefined ? "" : ",\"" + exParams.join("\",\"") + "\"";
 		
//  		var pagingHtml = "<div class='paging'>";
//  		pagingHtml += "<a class='first' href='javascript:"+pageFunc+"(1"+sExParam+")'><span class='hidden'>맨앞</span></a>";
//  	  pagingHtml += "<a class='pre' href='javascript:"+pageFunc+"(" + (currentPage - 1 == 0 ? 1 : (currentPage -1))+")'><span class='hidden'>이전</span></a>";
//  		for (var i = startPage; i <= endPage; i++) {
//  			if (i > totalPage) {
//  				break;
//  			}
 			
//  			if(i > startPage) {
//  				firstPage = "";
//  			}
 			
//  			if (i == currentPage) {
//  				pagingHtml += "<strong>" + i + "</strong>";
//  			} else {
//  				pagingHtml += " <a href=javascript:"+pageFunc+"(" + i + sExParam +")>" + i + "</a>";
//  			}
//  		}

//  		pagingHtml += "<a class='next' href='javascript:"+pageFunc+"(" + (currentPage + 1 > totalPage ? currentPage : (currentPage + 1)) + ")'><span class='hidden'>다음</span></a>";
//  		pagingHtml += "<a class='last' href='javascript:"+pageFunc+"(" + totalPage + sExParam + ")'><span class='hidden'>맨뒤</span></a>";
//  		pagingHtml += "</div>";

//  		return pagingHtml;
//  	}
 	
 	
	
/* 위는 vue를 사용한 함수*/	
/*=================================================*/	
/* 밑은 vue를 사용한 함수*/

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
									<a class="btnType3 color2" id="refundListSearchBtn" @click="searchRefund" style="padding-top: 2px;">검색</a>
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
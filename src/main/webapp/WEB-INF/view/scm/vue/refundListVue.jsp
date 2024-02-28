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
	<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.10.7/dayjs.min.js"></script>
</head>
<script>

	var currentPage = "1";
	var pageSizeRefundList = "10";
	var itemsPerPage = 3;
	
	var refundList;
	var detailItem;
	var pageVue;
	
	var refundData;
	var totalPage;
	
// 	var detailRefund = document.getElementById('detailRefund');

	$(document).ready(function() {
	  /* 반품신청 목록 초기 세팅 */ 
	  init()
	});
	
	/* 페이지 초기화 */ 
	function init() {
		refundListLoad();
		refundListSearchFormLoad();
	}
	
	/* 반품신청 목록 리스트 Vue */ 
	function refundListLoad() {
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
// 				getRefundListResult(response.data, currentPage);
					pagingVue(response.data, currentPage);
				})
				.catch(function(error) {
					console.log("error : " + error);
				})
			},
			methods: {
				detailView: function(num) {
					getRefundDetail(num)
				}
			}
		})
	}
	
	/* 반품 지시서 디테일 불러오기 */ 
	function getRefundDetail(orderCode) {
		console.log(orderCode);
	  
		/* 반품 지시서 Detail Vue */
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
	
	/* 반품 신청 목록 검색 vue */
	function refundListSearchFormLoad() {
		refundListForm = new Vue({
			el:'#refundListForm',
			methods: {
				searchRefund : function() {
					searchRefund();
				}
			}
		})
	}
	
	/* Paging 처리 */
	function pagingVue(data, currentPage) {
		refundData = data;
		pageVue = new Vue({
			el:"#refundListPagination",
			mounted: function() {
					renderPage();
			}
		})
	}
	
	/* 페이징 처리 후 화면에 그리기*/
	function renderPage() {
		var data = paginateData(refundData.refundList, currentPage, itemsPerPage);
		 getRefundListResult(data, currentPage);
		
		totalPage = Math.ceil(refundData.refundList.length/itemsPerPage)
		console.log("totalPage : " + totalPage);
		 renderPagination(totalPage)
	}
	
	/** 반품신청 목록 조회 콜백 함수 */
	function getRefundListResult(data, currentPage) {
	  
	  console.log(data);
	  refundList.refundListData = data;
	  refundList.totalCount = data.refundListCnt;
	  
	  // 총 개수 추출
	  console.log(refundList.totalCount);
	  console.log(data.refundListCnt)
	   
	};
	
	/* paging 해서 보여주는 데이터 */
	function paginateData(data, currentPage, itemsPerPage) {
		var startIndex = (currentPage - 1) * itemsPerPage;
		var endIndex = startIndex + itemsPerPage;
		return data.slice(startIndex, endIndex);
	}
	
	/* 버튼 생성해서 보여주는 기능 */ 
	function renderPagination(totalPages) {
		var paginationContainer = document.getElementById("refundListPagination");
		 paginationContainer.innerHTML = ""
		 
		 var firstButton = document.createElement("button");
		 firstButton.textContent = "맨앞";
		 firstButton.classList.add("pageButton");
		 firstButton.addEventListener("click", () => {
			 console.log('처음처음')
			 currentPage = 1;
			 renderPage() // 데이터를 그리는 함수
		 })
		 paginationContainer.appendChild(firstButton);
		 
// 		 var prevButton = document.createElement("button");
// 		 prevButton.textContent = "이전";
// 		 prevButton.classList.add("pageButton");
// 		 prevButton.addEventListener('click', () => {
// 			 console.log('이전이전')
// 			 if(currentPage > 1) {
// 				 currentPage--;
// 				 renderPage();
// 			 }
// 		 });
// 		 paginationContainer.appendChild(prevButton);
		 
// 		 var nextButton = document.createElement("button");
// 		 nextButton.textContent = "다음";
// 		 nextButton.classList.add("pageButton");
// 		 nextButton.addEventListener("click", () => {
// 			 console.log('다음다음')
// 			 if(currentPage < totalPages) {
// 				 currentPage++;
// 				 console.log(currentPage);
// 				 renderPage();
// 			 }
// 		 });
// 		 paginationContainer.appendChild(nextButton);

		for(let i = 1; i <= totalPages; i++) {
			var pageButton = document.createElement('button');
			pageButton.textContent = i;
			pageButton.classList.add('pageButton');
			if(i === currentPage) {
				pageButton.classList.add('active');
			}
			pageButton.addEventListener('click', () => {
				currentPage = i;
				console.log("i : " +  i);
				console.log("currentPage : " + currentPage);
				renderPage();
			});
			paginationContainer.appendChild(pageButton);
		}
		 
		 var lastButton = document.createElement("button");
		 lastButton.textContent = "맨뒤";
		 lastButton.classList.add("pageButton");
		 lastButton.addEventListener("click", () => {
			 console.log('마지막마지막')
			 currentPage = totalPages;
			 renderPage();
		 });
		 paginationContainer.appendChild(lastButton);
	}

	/* 반품지시서 디테일 정보*/
 	function getRefundDetailResult(data) {

 		// 반품지시서 디테일 title
 		var detail_title = document.createElement('p');
 		detail_title.classList.add('conTitle');
 		
 		var titleContent = document.createElement('span');
 		titleContent .textContent = "반품지시서";
 		
 		var cancleButton = document.createElement('button');
 		
 		cancleButton.classList.add('refundDetail_cancle_btn')
 		cancleButton.id = 'cancle_btn'
 		cancleButton.textContent = "X";
 		
 		cancleButton.addEventListener('click',  function() {
//  			detail_refundReset();
			detail_title.innerHTML = '';
 	 		result.innerHTML = '';
 		})
 		
 		detail_title.appendChild(titleContent);
 		detail_title.appendChild(cancleButton);
 		
 		// 새로운 테이블 요소 생성
 		var table = document.createElement('table');
 		table.classList.add('col');
 		
 		// thead 요소 생성
 		var thead = document.createElement('thead');
 		var headerRow = document.createElement('tr');
 		var headerTitles = ['SCM 관리자', '반품지시일자', '제품번호', '주문일자', '제품명', '품목명'];
 		headerTitles.forEach(title => {
 			var th = document.createElement('th');
 			th.textContent = title;
 			headerRow.appendChild(th);
 		});
 		thead.appendChild(headerRow);
 		table.appendChild(thead);
 		
 		// tbody 요소 생성
 		var tbody = document.createElement('tbody');
 		var dataRow = document.createElement('tr');
 		var dataValues = [data.scmManager, dayjs(data.refundDate).format('YYYY-MM-DD'), data.productCode, dayjs(data.orderDate).format('YYYY-MM-DD'), data.productName, data.middleCategory];
 		dataValues.forEach(value => {
 			var td = document.createElement('td');
 			td.textContent = value;
 			dataRow.appendChild(td);
 		});
 		tbody.appendChild(dataRow);
 		table.appendChild(tbody)
 		
 		// 두 번째 thead 요소 생성
 		var secondThead = document.createElement('thead');
 		var secondHeaderRow = document.createElement('tr');
 		var secondHeaderTitles = ['공급처명', '반품일자', '창고명', '반품수량', '반품금액(원)', '상태'];
 		secondHeaderTitles.forEach(title => {
 			var th = document.createElement('th');
 			th.textContent = title;
 			secondHeaderRow.appendChild(th);
 		});
 		secondThead.appendChild(secondHeaderRow);
 		table.appendChild(secondThead);
 		
 		// 두 번째 tbody 요소 생성
 		var secondTbody = document.createElement('tbody');
 		var secondDataRow = document.createElement('tr');
 		var secondDataValues = [data.supplyName, dayjs(data.refundDate).format('YYYY-MM-DD'), data.warehouseName, data.refundCount, Number(data.refundAmount).toLocaleString(), data.state];
 		secondDataValues.forEach(value => {
 			var td = document.createElement('td');
 			td.textContent = value;
 			secondDataRow.appendChild(td);
 		});
 		secondTbody.appendChild(secondDataRow);
 		table.appendChild(secondTbody);
 		
 		//테이블을 detailResult에 추가
 		var result = document.getElementById('detailResult');
 		result.innerHTML = '';
 		result.appendChild(table);
 		
 		// detailRefund에 result 추가
 		var detailRefund = document.getElementById('detailRefund');
 		detailRefund.innerHTML = '';
 		detailRefund.appendChild(detail_title);
 		detailRefund.appendChild(result);
 	} 
		 	
 	/* 반품신청 목록 검색 */ 
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
// 				getRefundListResult2(response.data);
					pagingVue(response.data, currentPage)
			})
			.catch(function(error) {
				console.log("error : " + error);
			})
 	}
 	
 	/* serialize 된 form 데이터를 Json으로 변환 */
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
 	
// 	function getRefundListResult2(data, currentPage) {
//	  console.log(data.refundList);
//	  refundList.refundListData = data.refundList;
//	  refundList.totalCount = data.refundListCnt;
	  
//	  // 총 개수 추출
//	  console.log(refundList.totalCount);
//	  console.log(data.refundListCnt)
	   
//	};
 	
</script>
<style>
	.paging_area {
		text-align: center
	}

	.pageButton {
		background-color: transparent;
		outline: none;
		border: none;
		margin: 10px;
		
		cursor: pointer;
	}
	
	.refundContent {
		cursor: pointer;
	}
	
	.conTitle {
		position: relative;
	}
	
	.refundDetail_cancle_btn {
		background-color: transparent;
		outline: none;
		border: none;
		cursor: pointer;
		
		font-size: 25px;
		
		position: absolute;
		top: 15px;
		right: 20px;
	}
</style>
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
									<tr class="refundContent" @click="detailView(item.orderCode)"> 
										<td>{{item.orderCode}}</td>
										<td>{{item.customerName}}</td>
										<td>{{item.productName}}</td>
										<td>{{item.middleCategory}}</td>
										<td>{{dayjs( item.refundDate).format('YYYY-MM-DD')}}</td>
										<td>{{item.refundCount}}</td>
										<td>{{Number(item.refundAmount).toLocaleString()}}</td>
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
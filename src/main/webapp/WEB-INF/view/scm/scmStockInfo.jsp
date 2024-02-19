<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>여기는 StockInfo 페이지 입니다.</title>

<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous">
</script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<!-- 우편번호 조회 -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" charset="utf-8"
src="${CTX_PATH}/js/popFindZipCode.js"></script>

<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<!-- seet swal import -->

<script type="text/javascript">
	
	/* StockInfo 페이지  */
	var stockInfoPageSize = 5;
	var stockInfoBlockPageSize = 5;
	
	/* 창고별 재고현황 데이터 */
	var stockInfo;
	var stockInfoModalVue;
	
	/* onload 이벤트 */
	$(document).ready(function() {
		
		init();
		
	});
	
	function init() {
		stockInfo = new Vue({
			el:'#stockInfoList',
			data : {
				stockInfoData: [
				            	{"창고코드": "1", "제품번호":"ERD000", "창고명":"동쪽창고","제품명":"갤럭시","재고수량":123, "창고위치":"서울특별시 이곳저곳"},
				            	{"창고코드": "2", "제품번호":"ERD001", "창고명":"서쪽창고","제품명":"애플","재고수량":1234, "창고위치":"서울특별시 여기저기"},
				            	{"창고코드": "3", "제품번호":"ERD002", "창고명":"남쪽창고","제품명":"노키아","재고수량":55, "창고위치":"서울특별시 성수동"},
				            	{"창고코드": "4", "제품번호":"ERD003", "창고명":"북쪽창고","제품명":"마이크로소프트","재고수량":34, "창고위치":"서울특별시 방배동"},
				            	{"창고코드": "5", "제품번호":"ERD004", "창고명":"동쪽창고","제품명":"아이리버","재고수량":35, "창고위치":"서울특별시 가산동"},
				            	{"창고코드": "6", "제품번호":"ERD005", "창고명":"서쪽창고","제품명":"아마존","재고수량":79, "창고위치":"서울특별시 신림동"},
				            	{"창고코드": "7", "제품번호":"ERD006", "창고명":"남쪽창고","제품명":"페이스북","재고수량":695, "창고위치":"서울특별시 타임스퀘어"},
				            	{"창고코드": "8", "제품번호":"ERD007", "창고명":"북쪽창고","제품명":"LG","재고수량":63, "창고위치":"서울특별시 롯데타워"},
				            	{"창고코드": "9", "제품번호":"ERD008", "창고명":"중앙창고","제품명":"스카이","재고수량":73, "창고위치":"서울특별시 영등포"},
				            	{"창고코드": "10", "제품번호":"ERD009", "창고명":"위쪽아래쪽창고","제품명":"파나소닉","재고수량":623, "창고위치":"서울특별시 판교"}
				            ]
			},
			methods: {
				detailView: function(code) {
					alert(code);
					console.log(this.stockInfoData[code]);
					fDetailResult(this.stockInfoData[code]);
				}
			}
		});
		
		stockInfoModalVue = new Vue({
			el:'#stockInfoModalBody',
			data : {
				productNumber : "",
				productName: "",
				stockQuantity: "",
				shipmentQuantity: ""
			}
		})
	}
	
	/* Stock Info 상세 조회 */
	function fDetailResult(data) {
		gfModalPop("#layer2");
		fModalContent(data);
	}
	
	/* 팝업_내용 뿌리기 */
	function fModalContent(data) {
		stockInfoModalVue.productNumber = data.제품번호
		stockInfoModalVue.productName = data.제품명
		stockInfoModalVue.stockQuantity = data.재고수량
		stockInfoModalVue.shipmentQuantity = 0
	}
	
	/* 검색 기능 */
	function stockInfoSearch() {
		
	}
	
</script>

	<style>
	.btn-group {
		margin-bottom: 15px;
	}
	</style>
	
</head>

<body>
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPageCod" value="1"> <input
			type="hidden" id="currentPageComnDtlCod" value="1"> <input
			type="hidden" id="tmpGrpCod" value=""> <input type="hidden"
			id="tmpGrpCodNm" value=""> <input type="hidden" name="action"
			id="action" value="">
		<!-- 모달 배경 -->
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
								<a href="#" class="btn_set home">메인으로</a><span
									class="btn_nav bold">기업고객 관리</span> <a
									href="javascript:window.location.reload();"
									class="btn_set refresh">새로고침</a>
							</p>
							<p class="conTitle">
								<span>창고별 재고관리</span>
							</p>
							<form class="search-container">
								<div class="row">
									<!-- searchbar -->
									<div class="col-lg-6">
										<div class="input-group">
											<select style="width: 90px; height: 34px;" id="option"
												name="search_value">
												<option selected>전체</option>
												<option value="warehouse_name" id="title">창고명</option>
												<option value="product_name" id="content">제품명</option>
											</select>
											<!-- // searchbar -->
											 <input style="width: 300px; height: 25px;" id="sname" name="inputValue" type="text">
										</div>
									</div>

									<button type="submit" style="width: 50px; height: 28px;" onClick="searchWarehouse">검색</button>

									<div class="divCustomerList">
										<!-- divComGrpCodList -->
										<table class="col">
											<caption>caption</caption>
											<colgroup>
												<col width="10%">
												<col width="15%">
												<col width="15%">
												<col width="15%">
												<col width="15%">
												<col width="30%">

											</colgroup>
											<thead>
												<tr>
													<th scope="col">창고코드</th>
													<th scope="col">제품번호</th>
													<th scope="col">창고명</th>
													<th scope="col">제품명</th>
													<th scope="col">재고수량</th>
													<th scope="col">창고위치</th>
												</tr>
											</thead>
											<tbody id="stockInfoList"  v-if="stockInfoData.length">
												<tr v-for="(item, index) in stockInfoData" @click="detailView(index)">
													<td>{{item.창고코드}}</td>
													<td>{{item.제품번호}}</td>
													<td>{{item.창고명}}</td>
													<td>{{item.제품명}}</td>			
													<td>{{item.재고수량}}</td>
													<td>{{item.창고위치}}</td>
												</tr>
											</tbody>
											</tbody>
											<!-- listComnGrpCode -->
										</table>
									</div>
									<div class="paging_area" id="customerListPagination"></div>
									<!-- <div class="paging_area" id="customerPagination"></div> -->
									<!-- comnGrpCodPagination -->
								</div>
								<!-- /.row -->
							</form>
						</div>
						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
					</li>
				</ul>
			</div>
		</div>
		<div id="layer2" class="layerPop layerType2" style="width: 600px;">
			<div id="vueedittable">
				<dl>
					<dt>
						<strong>기업 고객 관리</strong>
					</dt>
					<dd class="content">

						<!-- s : 여기에 내용입력 -->

						<table class="row">
							<caption>caption</caption>
							<colgroup>
								<col width="120px">
								<col width="*">
								<col width="120px">
								<col width="*">
							</colgroup>

							<tbody id="stockInfoModalBody">
								<tr>
									<th scope="row">제품번호 </th>
									<td><input type="text" class="inputTxt p100"
										id="productNumber" name="productNumber" v-model="productNumber" readonly/></td>
								</tr>
								<tr>
									<th scope="row">제품명 </th>
									<td><input type="text" class="inputTxt p100"
										id="productName" name="productName" v-model="productName" readonly/></td>	
								</tr>	
								<tr>
									<th scope="row">재고수량 </th>
									<td><input type="text" class="inputTxt p100"
										id="stockQuantity" name="stockQuantity" v-model="stockQuantity"/></td>
								</tr>
								
								<tr>
									<th scope="row">출고량 </th>
									<td><input type="text" class="inputTxt p100"
										id="shipmentQuantity" name="shipmentQuantity" v-model="shipmentQuantity"/></td>
								</tr>
							</tbody>
						</table>

						<!-- e : 여기에 내용입력 -->

						<div class="btn_areaC mt30">
							<input type="hidden" name="Actiondetail" id="Actiondetail" value="#"> 
								<a href="" class="btnType blue"
								id="btnSaveDtlCod" onClick="updateCustomerInfo()" name="btn"><span>수정</span></a>
							<a href="" class="btnType blue" id="btnDeleteDtlCod"
								onClick="deleteCustomerInfo()" name="btn"><span>삭제</span></a> 
								<a href="" class="btnType gray" id="btnCloseDtlCod" name="btn"><span>취소</span></a>
						</div>
					</dd>
				</dl>
				<a href="" class="closePop"><span class="hidden">닫기</span></a>
			</div>
		</div>
	</form>
</body>
</html>
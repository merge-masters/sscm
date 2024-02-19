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
												<option value="company_name" id="title">회사명</option>
												<option value="manager_name" id="content">담당자명</option>
											</select>
											<!-- // searchbar -->
											<input type="text" class="form-control" aria-label="..."
												id="keyword" autocomplete="off">
										</div>
									</div>

									<!-- button -->
									<div class="btn-group" role="group" aria-label="...">
										<button type="button" class="btn btn-default"
											id="customerSearch_button" name="btn">검색</button>
									</div>
									<!-- // button -->

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
											<tbody id="customerList">
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

							<tbody>
								<tr>
									<th scope="row">구분</th>
									<td><input type="text" class="inputTxt p100"
										id="customer_userType" name="customer_userType"/></td>
										
									<th scope="row">고객 아이디 </th>
									<td><input type="text" class="inputTxt p100"
										id="customer_userId" name="customer_userId" readonly/></td>
										
									
								</tr>
								<tr>
									<th scope="row">담당자명 </th>
									<td><input type="text" class="inputTxt p100" id="customer_name"
										name="customer_name"/></td>
									<th scope="row">회사명 </th>
									<td><input type="text" class="inputTxt p100"
										id="customer_companyName" name="customer_companyName" readonly/></td>
									
								</tr>
								
								<tr>
									<th scope="row">연락처 </th>
									<td><input type="text" class="inputTxt p100"
										id="customer_phoneNumber" name="customer_phoneNumber"/></td>
								</tr>
								
								<tr>
									<th scope="row">이메일 </th>
									<td><input type="text" class="inputTxt p100"
										id="customer_email" name="customer_email"/></td>
								</tr>

								<tr>
									<th scope="row">우편번호</th>
									<td colspan="2"><input type="text" class="inputTxt p100"
									name="zip_code" id="zip_code" /></td>
									<td><input type="button" value="우편번호 찾기"
									onclick="execDaumPostcode()" style="width: 130px; height: 20px" />
									</td>
								</tr>
								<tr>
									<th scope="row">주소</th>
									<td colspan="3"><input type="text" class="inputTxt p100"
									name="addr" id="addr" /></td>
								</tr>
								<tr>
									<th scope="row">상세주소</th>
									<td colspan="3"><input type="text" class="inputTxt p100"
									name="addr_detail" id="addr_detail" /></td>
								</tr>
								<!-- 
								<tr>
									<th scope="row">사용 유무 </th>
									<td colspan="3"><input type="radio" id="dtl_use_poa"
										name="dtl_use_poa" value="Y" v-model="dtl_use_poa" /> <label
										for="radio1-1">사용</label> &nbsp;&nbsp;&nbsp;&nbsp; <input
										type="radio" id="dtl_use_poa" name="dtl_use_poa" value="N"
										v-model="dtl_use_poa" /> <label for="radio1-2">미사용</label></td>
								</tr>
								 -->
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
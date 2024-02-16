<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>JobKorea</title>

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
	var customerPageSize = 5;
	var customerBlockPageSize = 5;
	var currentPage = 1;

	$(document).ready(function() {

		ButtonClickEvent();
		customerSearch(currentPage);

	})

	/** 기업고객 불러오기 및 검색 */
	function customerSearch(currentPage) {

		currentPage = currentPage || 1;

		var searchCustomerType = $("#option").val();
		var customerInput = $('#keyword').val();

		console.log("searchCustomerType : " + searchCustomerType);
		console.log("customerInput : " + customerInput);

		var param = {
			currentPage : currentPage,
			customerPageSize : customerPageSize,
			searchCustomerType : searchCustomerType,
			customerInput : customerInput
		};

		console.log("currentPage : " + currentPage);
		console.log("paramValue : " + param);

		var resultCallback = function(data) {
			fn_customerlistdisplay(data, currentPage);
		}

		customerListAjax("/basic/customerList", "post", "text", true, param,
				resultCallback);
		//callAjax("/sample/gouppcodelist.do", "post", "text", true, $("#myForm").serialize(), resultCallback);
	}

	/** 기업고객 리스트 및 페이지 매칭 */
	function fn_customerlistdisplay(data, currentPage) {
		console.log("콜백함수 실행 성공")
		console.log(data);

		//Customer List 추가
		$("#customerList").empty().append(data);

		var totalCustomerCount = $("#totalCustomerCount").val();

		var paginationHtml = getPaginationHtml(currentPage, totalCustomerCount,
				customerPageSize, customerBlockPageSize, 'customerSearch');
		console.log("paginationHtml : " + paginationHtml);

		$("#customerListPagination").empty().append(paginationHtml)

		// 		var totalCustomerCount = $("#totalCustomerCount").val();

		//swal(totalCntComnGrpCod);

		// 페이지 네비게이션 생성

		// 		var paginationHtml = getPaginationHtml(curruntPage, totalCntComnGrpCod,
		// 				grouppagesize, groupblockpageSize, 'fn_groupsearch');
		// 		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		// 		$("#comnGrpCodPagination").empty().append(paginationHtml);

	}

	function selectCustomerDetail(company, manager) {
		console.log(company);
		console.log(manager);

		var param = {
			company_name : company,
			manager_name : manager
		}

		var resultCallback = function(data) {
			customerDetailShow(data);
		}

		customerListAjax("/basic/selectCustomerDetail", "post", "json", true,
				param, resultCallback);

	}

	function customerDetailShow(data) {
		console.log(data);
		
		$("#customer_userType").val(data.selectCustomerDetail.user_type)
		$("#customer_userId").val(data.selectCustomerDetail.user_id)
		$("#customer_name").val(data.selectCustomerDetail.manager_name);
		$("#customer_companyName").val(data.selectCustomerDetail.company_name);
		$("#customer_phoneNumber").val(data.selectCustomerDetail.phone_number);
		$("#customer_email").val(data.selectCustomerDetail.email);
		$("#zip_code").val(data.selectCustomerDetail.post_code);
		$("#addr").val(data.selectCustomerDetail.user_address);
		$("#addr_detail").val(data.selectCustomerDetail.user_address_detail);
		
		gfModalPop("#layer2");
	}
	
	//기업 고객 정보 수정
	function updateCustomerInfo() {
		console.log('update Button Test');
		
		var userType = $("#customer_userType").val();
		var userId = $("#customer_userId").val();
		var customerName = $("#customer_name").val(); 
		var companyName = $("#customer_companyName").val();
		var phoneNumber = $("#customer_phoneNumber").val();
		var email = $("#customer_email").val();
		var zip_code = $("#zip_code").val();
		var address = $("#addr").val();
		var address_detail = $("#addr_detail").val();
		
		var param = {
				
				userType : userType,
				userId : userId,
				customerName : customerName,
				companyName : companyName,
				phoneNumber : phoneNumber,
				email : email,
				zipCode : zip_code,
				address : address,
				addressDetail : address_detail
		}
		
		console.log(param);
		
		var resultCallback = function(data) {
			alert(data.resultMessage);
		}
		
		customerListAjax("/basic/updateCustomerInfo", "post", "json", true, param, resultCallback);
	}
	
	//기업 고객 정보 삭제
	function deleteCustomerInfo() {
		console.log('delete Button Test');
		var customerName = $("#customer_name").val();
		var companyName = $("#customer_companyName").val();
		
		var param = {
				customerName : customerName,
				companyName : companyName
		}
		
		// 20240202 내일 여기서 부터 삭제 만들어나가면 됨
		console.log(param);
		
		var resultCallback = function(data) {
			alert(data.resultMessage);
		}
		
		customerListAjax("/basic/deleteCustomerInfo", "post", "json", true, param, resultCallback);
	}

	//버튼 이벤트 등록
	function ButtonClickEvent() {
		$('button[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
			case 'customerSearch_button':
				console.log('search_btton test');

				customerSearch(currentPage);
				break;
			}

		})
	}

	/** 기업고객 리스트 Ajax */
	function customerListAjax(url, method, dataType, async, param, callback) {
		$.ajax({
			url : url,
			type : method,
			dataType : dataType,
			async : async,
			data : param,
			success : function(data) {
				callback(data);
			},
			error : function(xhr, status, err) {
				console.log("xhr : " + xhr);
				console.log("status : " + status);
				console.log("err : " + err);
				alert("에러발생")
			}
		})
	}
	
	// 우편번호 api
	function execDaumPostcode(q) {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('zip_code').value = data.zonecode;
				document.getElementById("addr").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("addr_detail").focus();
			}
		}).open({
			q : q
		});
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
							page="/WEB-INF/view/common/lnbMenu2.jsp"></jsp:include> <!--// lnb 영역 -->
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
								<span>기업고객 관리</span>
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
												<col width="30%">
												<col width="30%">
												<col width="30%">

											</colgroup>
											<thead>
												<tr>
													<th scope="col">구분</th>
													<th scope="col">회사명</th>
													<th scope="col">담당자명</th>
													<th scope="col">연락처</th>
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
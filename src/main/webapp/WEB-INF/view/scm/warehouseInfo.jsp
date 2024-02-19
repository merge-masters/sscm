<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 창고 정보 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	//창고등록 모달창
	document.addEventListener("DOMContentLoaded", function() {

		var insertWarehouseButton = document.getElementById("insertWarehouse");
		var modal = document.getElementById("insertModal");
		var closeButton = document.getElementsByClassName("close")[0];

		insertWarehouseButton.addEventListener("click", function() {
			event.preventDefault(); // 기본 이벤트 중지
			modal.style.display = "block"; // 모달을 보이도록 설정
		});

		closeButton.addEventListener("click", function() {
			modal.style.display = "none"; // 모달을 숨기도록 설정
		});
	});

	//창고등록
	function insert() {
		if (!confirm('정말로 등록 하시겠습니까?'))
			return;

		var formData = $('#insertForm').serialize();

		$.ajax({
			url : "/scm/insertWarehouse",
			data : formData,
			method : 'post',
			dataType : 'json',
			cache : false,
			success : function(res) {
				alert(res.inserted ? "창고 등록 성공" : "창고 등록 실패");
				location.href = "/scm/warehouseInfo";
			},
			error : function(err) {
				alert(err);
			}
		});
	}

	//창고 검색
	function searchWarehouse() {
		console.log('search warehosue test');

		var searchKey = $("#searchKey").val();
		var sname = $("#sname").val();

		console.log("searchKey" + searchKey);
		console.log('sname' + sname);

		var param = {
			searchKey : searchKey,
			sname : sname
		}

		warehouseAjax("/scm/searchWarehouse", "post", "json", true, param,
				resultCallback);

	}

	function warehouseAjax(url, method, dataType, async, param, callback) {
		//console.log('>>>>>>param일떄',param);

		//method는 post 이다. async는 true/false이다.
		if (method == null || method == "")
			method = "post";

		$
				.ajax({
					url : url,
					type : method,
					dataType : dataType,
					async : async,
					data : param,
					beforeSend : function(xhr) {
						xhr.setRequestHeader("AJAX", "true");
						$
								.blockUI({
									message : '<h1><img src="/images/admin/comm/busy.gif" /> Just a moment...</h1>',
									T : 99999
								});
					},
					success : function(data) {
						callback(data);
					},
					error : function(xhr, status, err) {
						console.log("xhr : " + xhr);
						console.log("status : " + status);
						console.log("err : " + err);

						if (xhr.status == 901) {
							alert("로그인 정보가 없습니다.\n다시 로그인 해 주시기 바랍니다.");
							location.replace('/login.do');
						} else {
							alert('A system error has occurred.' + err);
						}
					},
					complete : function(data) {
						$.unblockUI();
					}
				});
	}
</script>

</head>
<body>


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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a>
							<span class="btn_nav bold">기준정보</span> <span class="btn_nav bold">창고정보
								관리</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>창고 관리</span> <span class="fr">
								<button id="insertWarehouse" style="width: 60px; height: 30px;">창고등록</button>
							</span>
						</p>


						<form action="/scm/searchWarehouse" method="get">
							<div>
								<fieldset>
									<legend>검색</legend>
									<div id="search">
										<select id="searchKey" name="searchKey">
											<option value="warehouse_name">창고명</option>
											<option value="warehouse_address">창고주소</option>
										</select>&nbsp; <input style="width: 300px; height: 25px;" id="sname" name="sname" type="text">
										<button type="submit" style="width: 50px; height: 28px;" onClick="searchWarehouse">검색</button>
									</div>
								</fieldset>
							</div>
							
							<br>

							<div class="divComGrpCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="5%">
										<col width="5%">
										<col width="10%">
										<col width="15%">
										<col width="15%">
										<col width="10%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">창고코드</th>
											<th scope="col">창고명</th>
											<th scope="col">담당자</th>
											<th scope="col">이메일</th>
											<th scope="col">전화번호</th>
											<th scope="col">창고주소</th>
										</tr>
									</thead>

									<tbody>
										<c:forEach var="warehouse" items="${listWarehouse}">
											<tr>
												<td><a
													href="/scm/detailWarehouse?warehouse_code=${warehouse.warehouse_code}">${warehouse.warehouse_code}</a></td>
												<td>${warehouse.warehouse_name}</td>
												<td>${warehouse.manager_name}</td>
												<td>${warehouse.manager_email}</td>
												<td>${warehouse.manager_phone}</td>
												<td>${warehouse.warehouse_address}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>

						</form>

						<!-- 창고등록 모달 창 -->
						<form id="insertForm" action="/scm/insertWarehouse" method="post">
							<div id="insertModal" class="modal" style="display: none;">
								<div class="modal-content">
									<span class="close">&times;</span>
									<table class="row">
										<caption>caption</caption>
										<colgroup>
											<col width="120px">
											<col width="*">
											<col width="120px">
											<col width="*">
										</colgroup>

										<tbody>
										
												<input type="hidden" class="inputTxt p100"
													id="warehouse_inout" name="warehouse_inout" value="0" />
												<input type="hidden" class="inputTxt p100"
													id="product_code" name="product_code" value="0" />
										
											<tr>
												<th scope="row">창고코드<span class="font_red">* </span></th>
												<td><input type="text" class="inputTxt p100"
													id="warehouse_code" name="warehouse_code" /></td>
												<th scope="row">창고명<span class="font_red">*</span></th>
												<td><input type="text" class="inputTxt p100"
													id="warehouse_name" name="warehouse_name" /></td>
											</tr>
											<tr>
												<th scope="row">담당자<span class="font_red">*</span></th>
												<td><input type="text" class="inputTxt p100"
													id="manager_name" name="manager_name" /></td>
												<th scope="row">이메일<span class="font_red">*</span></th>
												<td><input type="text" class="inputTxt p100"
													id="manager_email" name="manager_email" /></td>
												<th scope="row">전화번호<span class="font_red">*</span></th>
												<td><input type="text" class="inputTxt p100"
													id="manager_phone" name="manager_phone" /></td>
											</tr>
											<tr>
												<th scope="row">우편주소<span class="font_red">*</span></th>
												<td><input type="text" class="inputTxt p100"
													id="warehouse_post_code" name="warehouse_post_code" /></td>
												<th scope="row">주소<span class="font_red">*</span></th>
												<td><input type="text" class="inputTxt p100"
													id="warehouse_address" name="warehouse_address" /></td>
												<th scope="row">상세주소<span class="font_red">*</span></th>
												<td><input type="text" class="inputTxt p100"
													id="warehouse_address_detail"
													name="warehouse_address_detail" /></td>
											</tr>
										</tbody>
									</table>
									<br>
									<button type="button" style="width: 50px; height: 28px;" onclick="return insert();">저장</button>
								</div>
							</div>
						</form>
						<!-- 등록모달 끝 -->

					</div>
				</li>
			</ul>
		</div>
	</div>
</body>
</html>
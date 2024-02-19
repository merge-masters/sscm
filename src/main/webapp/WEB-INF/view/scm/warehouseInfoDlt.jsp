<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 창고 정보 상세</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<style>

/* 인풋 박스 스타일 */
.divComGrpCodList input[type=text] {
	width: 100%;
	padding: 8px 12px;
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: #f8f8f8;
	resize: vertical;
}
</style>


<script type="text/javascript">

	// 창고수정
	function update() {
		if (!confirm('정말로 수정 하시겠습니까?'))
			return;

		var formData = $('#detailForm').serialize();

		$.ajax({
			url : "/scm/updateWarehouse",
			data : formData,
			method : 'post',
			dataType : 'json',
			cache : false,
			success : function(res) {
				alert(res.updated ? "창고 수정 성공" : "창고 수정 실패");
				location.href = "/scm/warehouseInfo";
			},
			error : function(err) {
				alert(err);
			}
		});
	}

	// 창고삭제
	function del() {
		if (!confirm('정말로 삭제 하시겠습니까?'))
			return;

		var formData = $('#detailForm').serialize();

		$.ajax({
			url : "/scm/deleteWarehouse",
			data : formData,
			method : 'post',
			dataType : 'json',
			cache : false,
			success : function(res) {
				alert(res.deleted ? "창고 삭제 성공" : "창고 삭제 실패");
				location.href = "/scm/warehouseInfo";
			},
			error : function(err) {
				alert(err);
			}
		});
	}
	
</script>

</head>

<body>
<form id="detailForm">

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
									<span class="btn_nav bold">기준정보</span> <span
										class="btn_nav bold">창고정보 관리</span> <a
										href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
								</p>

								<p class="conTitle">
									<span>창고정보 상세</span> <span class="fr"> </span>
								</p>


								<div class="detail">
									<div class="divComGrpCodList">
										<table class="col">
											<caption>caption</caption>
											<colgroup>
												<col width="10%">
												<col width="10%">
												<col width="10%">
												<col width="15%">
												<col width="15%">
												<col width="10%">
												<col width="15%">
												<col width="15%">
											</colgroup>

											<thead>
												<tr>
													<th scope="col">창고코드</th>
													<th scope="col">창고명</th>
													<th scope="col">담당자</th>
													<th scope="col">이메일</th>
													<th scope="col">전화번호</th>
													<th scope="col">우편번호</th>
													<th scope="col">주소</th>
													<th scope="col">상세주소</th>
												</tr>
											</thead>

											<tbody>
												<c:forEach var="warehouseDlt" items="${detailWarehouse}">
													<tr>
														<td><input type="text" id="warehouse_code"
															name="warehouse_code"
															value="${warehouseDlt.warehouse_code}" readonly></td>
														<td><input type="text" id="warehouse_name"
															name="warehouse_name"
															value="${warehouseDlt.warehouse_name}"></td>
														<td><input type="text" id="manager_name"
															name="manager_name" value="${warehouseDlt.manager_name}"></td>
														<td><input type="text" id="manager_email"
															name="manager_email"
															value="${warehouseDlt.manager_email}"></td>
														<td><input type="text" id="manager_phone"
															name="manager_phone"
															value="${warehouseDlt.manager_phone}"></td>
														<td><input type="text" id="warehouse_post_code"
															name="warehouse_post_code"
															value="${warehouseDlt.warehouse_post_code}"></td>
														<td><input type="text" id="warehouse_address"
															name="warehouse_address"
															value="${warehouseDlt.warehouse_address}"></td>
														<td><input type="text" id="warehouse_address_detail"
															name="warehouse_address_detail"
															value="${warehouseDlt.warehouse_address_detail}"></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<br>
										<div style="display: flex; justify-content: flex-end;">
										<button type="button" style="width: 50px; height: 28px;" onclick="return update();">수정</button>
										<button type="button" style="width: 50px; height: 28px; margin-left: 10px;" onclick="return del();">삭제</button>
										</div>
									</div>
								</div>
							</div>
						</li>
					</ul>
				</div>
			</div>
	 </form>
</body>
</html>
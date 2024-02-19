<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 공급처 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">
	
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
							<span class="btn_nav bold">기준정보</span> <span class="btn_nav bold">공급처
								관리</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>공급처 관리</span> <span class="fr"> </span>
						</p>

						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="10%">
									<col width="10%">
									<col width="10%">
									<col width="10%">
								</colgroup>

								<thead>
									<tr>
										<th scope="col">납품업체명</th>
										<th scope="col">상품모델번호</th>
										<th scope="col">상품명</th>
										<th scope="col">상품단가</th>
									</tr>
								</thead>

								<tbody>
									<c:forEach var="detail" items="${detailCompany}">
										<tr>
											<td>${detail.company_class_name}</td>
											<td>${detail.product_model_number}</td>
											<td>${detail.product_name}</td>
											<td><fmt:formatNumber value="${detail.product_model_price}" pattern="#,###원"/></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>

					</div>
				</li>
			</ul>
		</div>
	</div>

</body>
</html>
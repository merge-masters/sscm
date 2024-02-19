<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

	//납품업체 검색
	function searchCompany() {
		console.log('search company test');
		
		var searchKey = $("#searchKey").val();
		var sname = $("#sname").val();
		
		console.log("searchKey" + searchKey);
		console.log('sname' + sname);
		
		var param = {
			searchKey : searchKey,
			sname : sname
		}
		
		warehouseAjax("/scm/searchCompany", "post", "json", true, param, resultCallback);
		
	}
	
	function companyAjax(url, method, dataType, async, param, callback) {
		//console.log('>>>>>>param일떄',param);
		
		//method는 post 이다. async는 true/false이다.
		if (method == null || method == "") method = "post";
		
		$.ajax({
			url : url,
			type : method,
			dataType : dataType,
			async : async,
			data : param,
			beforeSend: function(xhr) {
				xhr.setRequestHeader("AJAX", "true");
				$.blockUI({ message: '<h1><img src="/images/admin/comm/busy.gif" /> Just a moment...</h1>', T:99999 });
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
			complete: function(data) {
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
							<span class="btn_nav bold">기준정보</span> <span class="btn_nav bold">공급처
								관리</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>공급처 관리</span> <span class="fr"> </span>
						</p>


						<form action="/scm/searchCompany" method="get">
							<div>
								<fieldset>
									<legend>검색</legend>
									<div id="search">
										<select id="searchKey" name="searchKey">
											<option value="company_class_name">납품업체명</option>
										</select>&nbsp; <input style="width: 300px; height: 25px;" id="sname" name="sname" type="text">
										<button type="submit" style="width: 50px; height: 28px;" onclick="searchCompany()">검색</button>
									</div>
								</fieldset>
							</div>

							<br>

							<div class="divComGrpCodList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="15%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="15%">
									</colgroup>

									<thead>
										<tr>
											<th scope="col">납품업체명</th>
											<th scope="col">LOGIN ID</th>
											<th scope="col">패스워드</th>
											<th scope="col">담당자명</th>
											<th scope="col">담당자연락처</th>
										</tr>
									</thead>

									<tbody>
										<c:forEach var="company" items="${companyInfo}">
											<tr>
												<td><a
													href="/scm/detailCompany?company_class_name=${company.company_class_name}">${company.company_class_name}</a></td>
												<td>${company.user_id}</td>
												<td>${company.user_password}</td>
												<td>${company.user_name}</td>
												<td>${company.phone_number}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</form>
					</div>
				</li>
			</ul>
		</div>
	</div>

</body>
</html>
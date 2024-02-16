<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tf" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>Job Korea :: 공통 코드 관리</title>
<!-- sweet alert import -->
<script src='${CTX_PATH}/js/sweetalert/sweetalert.min.js'></script>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->
                              
<script type="text/javascript">
    var grouppagesize = 5;
    var groupblockpageSize = 5;
    var detailpagesize = 5;
    var detailblockpageSize = 5;

    var detailvue;
    var detaileditvue;
    
    $(document).ready(function() {
    	fRegisterButtonClickEvent();
    	
    	fn_groupsearch();
	});

	/** 버튼 이벤트 등록 */
	function fRegisterButtonClickEvent() {
		$('a[name=btn]').click(function(e) {
			e.preventDefault();

			var btnId = $(this).attr('id');

			switch (btnId) {
				case 'btnSaveGrpCod' :
					fn_SaveGrpCod();
					break;
				case 'btnDeleteGrpCod' :
					fn_DeleteGrpCod();
					break;				
				case 'btnSearchGrpcod':
					fn_groupsearch();
					break;
				case 'btnCloseGrpCod' :
				case 'btnCloseDtlCod' :
					gfCloseModal();
					break;
			}
		});
	}  
	
	
	function fn_groupsearch(currentPage) {
    	
    	currentPage = currentPage || 1;
		
    	 var searchgrouptype = $("#searchgrouptype").val();
    	 var sgroupinput = $("#sgroupinput").val();     
    	 
    	console.log("searchgrouptype : " + searchgrouptype) ;
    	console.log("sgroupinput : " + sgroupinput) ;
    	 
    	var param = {
    			searchgrouptype : searchgrouptype,
    			sgroupinput : sgroupinput,
    			currentPage : currentPage,
    			grouppageSize : grouppagesize
    	};

    	console.log("currentPage ; " + currentPage);
    	
		var resultCallback = function(data) {
			fn_goruplistdisplay(data, currentPage);
		}		
	
		callAjax("/sample/gouppcodelist.do", "post", "text", true, param, resultCallback);
		//callAjax("/sample/gouppcodelist.do", "post", "text", true, $("#myForm").serialize(), resultCallback);
    }
    
    function fn_goruplistdisplay(data, curruntPage) {
    	console.log(data);
    	
    	//listComnGrpCod
    	$("#listComnGrpCod").empty().append(data);
    	
		var totalCntComnGrpCod = $("#totalCntComnGrpCod").val();
		
		
		//swal(totalCntComnGrpCod);
		
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(curruntPage, totalCntComnGrpCod, grouppagesize, groupblockpageSize, 'fn_groupsearch');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnGrpCodPagination").empty().append( paginationHtml );
    	
    }
    
    

	function fn_selectDtlCod(currentPage, grpcd, grpnm) {
	 	
	 	currentPage = currentPage || 1;
	 	
	 	grpcd = grpcd || $("#selfrpcd").val();
	 	
	 	$("#selfrpcd").val(grpcd);	 	
	 	$("#selfrpnm").val(grpnm);	 	
	 	
	 	console.log("currentPage : " + currentPage) ;
	 	
	   	 var searchKey = $("#searchKey").val();
		 var sname = $("#sname").val();     
		 
		console.log("searchKey : " + searchKey) ;
		console.log("sname : " + sname) ;
	 	
	 	 
	 	var param = {
	 			searchKey : searchKey,
	 			sname : sname,
	 			grpcd : grpcd,
	 			currentPage : currentPage,
	 			detailpagesize : detailpagesize
	 	};
	
	 	console.log("currentPage ; " + currentPage);
	 	
		var resultCallback = function(data) {
			fn_detaillistdisplay(data, currentPage);
		}		
		
		callAjax("/sample/detailcodelist.do", "post", "json", true, param, resultCallback);
		//callAjax("/sample/gouppcodelist.do", "post", "text", true, $("#myForm").serialize(), resultCallback);
 }
 
 function fn_detaillistdisplay(data, curruntPage) {
 	    console.log(JSON.stringify(data));

 	   console.log(JSON.stringify(data.detailcodelist));
 	   
		detailvue.items  = [];
		detailvue.items = data.detailcodelist;
		
		var totalCntComndetailCod = data.totalCntComndetailCod;
		//swal(totalCntComnGrpCod);
		
		// 페이지 네비게이션 생성
		
		var paginationHtml = getPaginationHtml(curruntPage, totalCntComndetailCod, detailpagesize, detailblockpageSize, 'fn_selectDtlCod');
		console.log("paginationHtml : " + paginationHtml);
		//swal(paginationHtml);
		$("#comnDtlCodPagination").empty().append( paginationHtml );
 	
 }
 
 function fn_editComnGrpCod(grp_cod) {
		
	   	console.log("grp_cod : " + grp_cod) ;
	   	 
	   	var param = {
	   			grp_cod : grp_cod
	   	};
   	
		var resultCallback = function(data) {
			//console.log("222222222222222 : " ) ;
			fn_groupeditresult(data);
			//console.log("444444444444444 : " ) ;
		}		
	 	//console.log("1111111111111 : " ) ;
		callAjax("/sample/selectgroupcode.do", "post", "json", true, param, resultCallback);
	 
 }
    

 function fn_groupeditresult(data) {
	 //console.log("33333333333 : " ) ;
	
 	if( data == "" || data == null || data == undefined) {
 		$("#Action").val("I");
 		
 		$("#grp_cod").val("");
 	 	$("#grp_cod_nm").val("");
 	 	$("#grp_cod_eplti").val("");
 	 	
 	 	$("input:radio[name='grp_use_poa']:radio[value='Y']").prop('checked', true); // 선택하기
 		
 	 	$('#grp_cod').prop('readonly', false);
 	 	
 	 	$("#btnDeleteGrpCod").hide();
 		
 	} else {
 	 	console.log(JSON.stringify(data));
 	 	console.log(JSON.stringify(data.selectgroupcode));
 		
 	 	$("#Action").val("U");
 	 	//console.log(" sssssssssss : " + $("#Action").val());
 	 	
 	 	$("#grp_cod").val(data.selectgroupcode.grp_cod);
 	 	$("#grp_cod_nm").val(data.selectgroupcode.grp_cod_nm);
 	 	$("#grp_cod_eplti").val(data.selectgroupcode.grp_cod_eplti);
 	 	
 	 	$("input:radio[name='grp_use_poa']:radio[value='Y']").prop('checked', true); // 선택하기
 	 	
 	 	$('#grp_cod').prop('readonly', true);
 	 	
 	 	var detailcnt = data.selectgroupcode.detailcnt;
 	 	
 	 	if(detailcnt == 0) {
 	 		$("#btnDeleteGrpCod").show();
 	 	} else {
 	 		$("#btnDeleteGrpCod").hide();
 	 	}
 	 	
 	 	
 	}

	// 모달 팝업
	gfModalPop("#layer1");
	
 }
 
 
 function fn_SaveGrpCod() {
		
	   	console.log("grp_cod : " + grp_cod) ;
	   	 
		var grp_cod = $("#grp_cod").val();
		var grp_cod_nm = $("#grp_cod_nm").val();
		var grp_cod_eplti = $("#grp_cod_eplti").val();
		var grp_use_poa = $(':radio[name="grp_use_poa"]:checked').val();
		var action = $("#Action").val();
		
		if(!fValidateGrpCod()) {
			return;			
		}
		
	   	var param = {
	   			grp_cod : grp_cod,
	   			grp_cod_nm : grp_cod_nm,
	   			grp_cod_eplti : grp_cod_eplti,
	   			grp_use_poa : grp_use_poa,
	   			action : action
	   	};
	
		var resultCallback = function(data) {
			fn_groupsaveresult(data);
		}		
	
		callAjax("/sample/savegroupcode.do", "post", "json", true, param, resultCallback);
		//callAjax("/sample/gouppcodelist.do", "post", "text", true, $("#myForm").serialize(), resultCallback);	 
	 
} 

function fn_groupsaveresult(data) {
	
 	if(data.Result = "Y") {
		alert(data.resultMsg);			
	} else {
		alert("오류 발생 " + data.resultMsg);
	} 
	
 	gfCloseModal();
 	fn_groupsearch();
 	
}
 
function fn_PopModalComnGrpCod(data) {	
	fn_groupeditresult();	
}
 

/** 그룹코드 저장 validation */
function fValidateGrpCod() {

	var chk = checkNotEmpty(
			[
					[ "grp_cod", "그룹 코드를 입력해 주세요." ]
				,	[ "grp_cod_nm", "그룹 코드 명을 입력해 주세요" ]
			]
	);

	if (!chk) {
		return;
	}

	return true;
}
  
 
/** 그룹코드 삭제 */
function fn_DeleteGrpCod() {
   	 
	var grp_cod = $("#grp_cod").val();
	$("#Action").val("D");	
  	console.log("grp_cod : " + grp_cod) ;		
	var action = $("#Action").val();

   	var param = {
   			grp_cod : grp_cod,
   			action : action
   	};

	var resultCallback = function(data) {
		fn_groupdeleteresult(data);
	}		

	callAjax("/sample/savegroupcode.do", "post", "json", true, param, resultCallback);
	//callAjax("/sample/gouppcodelist.do", "post", "text", true, $("#myForm").serialize(), resultCallback);	 
 
} 

function fn_groupdeleteresult(data) {

	if(data.Result = "Y") {
		alert(data.resultMsg);			
	} else {
		alert("오류 발생 " + data.resultMsg);
	} 

	gfCloseModal();
	fn_groupsearch();
	
}

/* 
function  fn_editComnDetailCod(grpcd, detailcd ) {
	 alert(grpcd + " : " + detailcd);
	
}
 */

function fn_editComnDetailCod(grp_cod,detail_cod) {
		
	   	console.log("grp_cod : " + grp_cod) ;
	   	 
	   	var param = {
	   			grp_cod : grp_cod,
	   			detail_cod : detail_cod
	   	};
  	
		var resultCallback = function(data) {
			//console.log("222222222222222 : " ) ;
			fn_detaileditresult(data);
			//console.log("444444444444444 : " ) ;
		}		
	 	//console.log("1111111111111 : " ) ;
		callAjax("/sample/selectdetailcode.do", "post", "json", true, param, resultCallback);
	 
}
   

function fn_detaileditresult(data) {
	 //console.log("33333333333 : " ) ;
	
	if( data == "" || data == null || data == undefined) {
		$("#Actiondetail").val("I");		
/* 		
		$("#dtl_grp_cod").val(""); 
		$("#dtl_grp_cod_nm").val(""); 
		$("#dtl_cod").val(""); 
		$("#dtl_cod_nm").val(""); 
		$("#dtl_cod_eplt").val(""); 
		$("#dtl_use_poa").val(""); 
		 */
		 detaileditvue.dtl_grp_cod = $("#selfrpcd").val();
		 detaileditvue.dtl_grp_cod_nm = $("#selfrpnm").val();
		 detaileditvue.dtl_cod = "";
		 detaileditvue.dtl_cod_nm = "";
		 detaileditvue.dtl_cod_eplti = "";
		 detaileditvue.dtl_use_poa = "";
		
		 detaileditvue.dtl_use_poa = "Y";
		
	 	
	 	//$("input:radio[name='dtl_use_poa']:radio[value='Y']").prop('checked', true); // 선택하기
		
	 	$('#dtl_grp_cod').prop('readonly', false);
	 	$('#dtl_cod').prop('readonly', false);
	 	
	 	
	 	$("#btnDeleteDtlCod").hide();
		
	} else {
	 	console.log(JSON.stringify(data));
	 	console.log(JSON.stringify(data.selectdetailcode));
		
	 	$("#Actiondetail").val("U");
	 	//console.log(" sssssssssss : " + $("#Action").val());
/* 	 		
	 	
	 	$("#dtl_grp_cod").val(data.selectdetailcode.grp_cod); 
		$("#dtl_grp_cod_nm").val(data.selectdetailcode.grp_cod_nm); 
		$("#dtl_cod").val(data.selectdetailcode.dtl_cod); 
		$("#dtl_cod_nm").val(data.selectdetailcode.dtl_cod_nm); 
		$("#dtl_cod_eplt").val(data.selectdetailcode.dtl_cod_eplti); 
		 */
		 detaileditvue.dtl_grp_cod = $("#selfrpcd").val();
		 detaileditvue.dtl_grp_cod_nm = $("#selfrpnm").val();
		 detaileditvue.dtl_cod = data.selectdetailcode.dtl_cod;
		 detaileditvue.dtl_cod_nm = data.selectdetailcode.dtl_cod_nm;
		 detaileditvue.dtl_cod_eplti = data.selectdetailcode.dtl_cod_eplti;
		 detaileditvue.dtl_use_poa = data.selectdetailcode.use_poa;
		 
		 console.log("use_poa : " + data.selectdetailcode.use_poa);
		 
/* 		
		if(data.selectdetailcode.use_poa == "Y") {
			$("input:radio[name='dtl_use_poa']:radio[value='Y']").prop('checked', true); // 선택하기
		}  else {
			$("input:radio[name='dtl_use_poa']:radio[value='N']").prop('checked', true); // 선택하기
		}
	 	 */
		
	 	
	 	$('#dtl_grp_cod').prop('readonly', true);
	 	$('#dtl_cod').prop('readonly', true);
	 	
	 	$("#btnDeleteDtlCod").show();

	}
	
	// 모달 팝업
	gfModalPop("#layer2");
	
}

function fn_PopModalComnDtlCod() {
	fn_detaileditresult();
	gfModalPop("#layer2");
	
}

</script>

</head>
<body>
<form id="myForm" action=""  method="">
    <input type="hidden" name="selfrpcd" id="selfrpcd" value="">
    <input type="hidden" name="selfrpnm" id="selfrpnm" value="">
	
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
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> <span
								class="btn_nav bold">Sample</span> <span class="btn_nav bold">공통코드
								관리</span> <a href="../system/comnCodMgr.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>그룹 코드</span> 
							<span class="fr">
							     <select id="searchgrouptype"  name="searchgrouptype" style="width: 150px;">
							            <option value="" >전체</option>
							    		<option value="grp_cod" >그룹코드</option>
							    		<option value="grp_cod_nm" >그룹코드명</option>
							     </select> 
							     <input type="text" style="width: 300px; height: 25px;" id="sgroupinput" name="sgroupinput">                    
	                              <a href="" class="btnType blue" id="btnSearchGrpcod" name="btn"><span>검  색</span></a>
							     <a class="btnType blue" href="javascript:fn_PopModalComnGrpCod();" name="modal"><span>신규등록</span></a>
							</span>
						</p>
						<div class="titype1">
					        <div class="bultype1 ico">인보증내역</div>
					        <tf:buttonList print="" excel="" create="console.log('T3');" update="console.log('T4');" delete="console.log('T5');" menuId="" addFunction="" addText=""/>
					    </div>
											
						<div class="divComGrpCodList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="6%">
									<col width="17%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
									<col width="15%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">그룹코드</th>
										<th scope="col">그룹코드명</th>
										<th scope="col">그룹코드 설명</th>
										<th scope="col">사용여부</th>
										<th scope="col">등록일</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody id="listComnGrpCod"></tbody>
							</table>
						</div>
						
	
						<div class="paging_area"  id="comnGrpCodPagination"> </div>
					</div> <!--// content -->

					<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>
		</div>
	</div>
	
</form>
</body>
</html>
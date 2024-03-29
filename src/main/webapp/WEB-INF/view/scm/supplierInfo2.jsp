<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

	<head>
	<meta charset="UTF-8">
	<title>공급처 관리</title>
	<script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
	<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
	<script type="text/javascript">
	    //공급처정보 페이징 처리
	    var pageSizeSupplier = 5; //공급처정보 페이지 사이즈
	    var pageBlockSizeSupplier = 5; //공급처정보 페이지 블록 갯수
	
	    //제품정보 페이징 처리 
	    var pageSizeProduct = 5; //제품정보 페이지 사이즈
	    var pageBlockSizeProduct = 5; //제품정보 페이지 블록 갯수
		var listSupplier;
	    var addVue;
	    //OnLoad event
	    $(document).ready(function () {
	    	
	    	init();
	    	
	        //공급처 목록 조회
	        fListSupplier();
	        //버튼 이벤트 등록
	        fRegisterButtonClickEvent();
	        //엔터눌렀을때 창고정보 검색되게하기
	        $("#sname").keypress(function (e) {
	            if (e.which == 13) {
	                board_search();  // 실행할 이벤트
	            }
	        });
	        //창고명 조회 콤보박스
	        selectComCombo("wh", "warehouse_nm", "sel", "");
	        // 조회 종류   부서 : dept  acc : 회계계정 cli 거래처  pro:싱품 whp: 창고담당자 wh: 창고, Combo Name, Option("all" : 전체     "sel" : 선택 , NULL)       
	    });
	    
	    function init(){
	    	listSupplier = new Vue({
				el: "#supplierVue",
				data: {
					supplierlist: [],
					detail_supplier: [],
					product_cd: '',
					prod_nm: '',
					l_ct_nm: '',
					purchase_price:''
				},
				methods: {
					supplierList: function() {
						flistSupplierResult();			// 공급처 조회 콜백 함수
						fSelectSupplier();						// 공급처 단건 조회 함수
						fDeleteSupplier();						// 공급처 삭제 함수
					},
					detailSupplier: function(supply_cd, supply_nm) {
						fListProduct(supply_cd, supply_nm);
						console.log("선택한 공급처: ", supply_nm, " 코드: ", supply_cd);
					},
					board_search: function(currentPage) {
						board_search(currentPage);				// 검색 함수
					},
		            fListSupplier: function() {
		                fListSupplier(); 			                    // 공급처 조회 함수
		            },
		            modifySupplier: function(supplyCd) {
		            	fPopModalSupplier(supplyCd);
		            }
				}
	    	});
	    	addVue = new Vue({
	    		el: "#addVue",
	    		methods: {
	    			createSupplier: function() {
	    				fPopModalSupplier();
	    			}
	    		}
	    	})

	    };
	
	    /*버튼 이벤트 등록*/
	    function fRegisterButtonClickEvent() {
	        $('a[name=btn]').click(function (e) {
	            e.preventDefault();
	            var btnId = $(this).attr('id');
	            switch (btnId) {
	                case 'searchBtn':
	                    board_search(); // 검색하기
	                    break;
	                case 'btnSaveSupplier':
	                    fSaveSupplier(); // save 안에 저장,수정  
	                    break;
	                case 'btnDeleteSupplier'://삭제하기
	                    fDeleteSupplier();
	                    break;
	                case 'btnCloseSupplier':
	                    gfCloseModal(); // 모달닫기 
	                    break;
	            }
	        });
	    }
	
	    
	    /*  */
	
	    /*공급처 조회*/
	    function fListSupplier(currentPage) {
	        currentPage = currentPage || 1;
	        var sname = $('#sname').val();
	        var searchKey = $("#searchKey").val();
	        var oname = $("#searchKey option:selected").val();
//	        var oname = searchKey.options[searchKey.selectedIndex].value;
	
	        var param = {
	            sname: sname,
	            oname: oname,
	            currentPage: currentPage,
	            pageSize: pageSizeSupplier
	        }
	        var resultCallback = function (data) {
	            flistSupplierResult(data, currentPage);
	            
	        };
	        callAjax("/scm/listSupplier.do", "post", "text", true, param, resultCallback);
	    }
	
		// 여기서 콜백한 리스트를 담는 작업을 해야한다 20240221
	    /*공급처 조회 콜백 함수*/
	    function flistSupplierResult(data, currentPage) {
			data = JSON.parse(data);
 	        console.log("data : " + data);
	        console.log("dataList : " + data.listSupplierModel);
	        
	        $("#tmpsupply_nm").val();
	        $("#tmpsupply_cd").val();
	        
	        // 20240223
	        // listSupplier의 supplierlist를 새로운 data에 담아 listSupplierModel만 불러와서 뿌림
	        listSupplier.supplierlist = data.listSupplierModel;	        
	        $("#totalSupplier").val(data.totalSupplier);
	        //기존 목록 삭제
//	        $("#listSupplier").empty();
// 	        $("#listSupplier").append(data);
//	        총 개수 추출
	        var totalSupplier = $("#totalSupplier").val();
//	        페이지 네비게이션 생성
	        var paginationHtml = getPaginationHtml(currentPage, totalSupplier, pageSizeSupplier, pageBlockSizeSupplier, 'fListSupplier');
	        $("#supplierPagination").empty().append(paginationHtml);
//	        현재 페이지 설정
	        $("#currentPageSupplier").val(currentPage);
	    }
	
	    /*제품목록 조회 이전 페이징 설정*/
	    function callfListProduct() {
	        $("#tmpsupply_nm").val();
	        $("#tmpsupply_cd").val();
	        fListProduct();
	
	    }
	
	
	    /*제품 목록 조회*/
	    function fListProduct(supply_cd, supply_nm, currentPage) {
	        //공급처명 매개변수 설정
	        currentPage = currentPage || 1;
	
	        $("#tmpsupply_nm").val(supply_nm);
	        $("#tmpsupply_cd").val(supply_cd);
	
	        var param = {
	           supply_cd: supply_cd //공급처 코드 변수설정
	            , currentPage: currentPage
	            , pageSize: pageSizeProduct
	        }
	
	        var resultCallback = function (data) {
	            flistProductResult(data, currentPage);
	        };
	        callAjax("/scm/listSupplierProduct.do", "post", "text", true, param, resultCallback);
	    }
	    /*제품목록 조회 콜백 함수*/
	    function flistProductResult(data, currentPage) {
	        data = JSON.parse(data);
	        listSupplier.detail_supplier = data.listSupplierProductModel;
	        console.log("=====data check : " + JSON.stringify(listSupplier.detail_supplier));
	        
	        // 공급 제품정보 + 공급처명
	        $('#subTitle').text(" - " + $("#tmpsupply_nm").val());
	        //기존 목록 삭제
	        //$("#listSupplierProduct").empty();
	        
	        // 신규 목록 생성
	        $("#listSupplierProduct").append(data);
	        //$("#listProduct").append($listProduct.children());  
	        // 총 개수 추출
	        var totalProduct = $("#totalProduct").val();
	        //페이지 네비게이션 생성
	        var supply_nm = $("#tmpsupply_nm").val();
	        var supply_cd = $("#tmpsupply_cd").val();
	
	        var paginationHtml = getPaginationHtml(currentPage, totalProduct,
	            pageSizeProduct, pageBlockSizeProduct, 'fListProduct', [supply_nm, supply_cd]);
	        $("#productPagination").empty().append(paginationHtml);
	        // 현재 페이지 설정
	        $("#currentPageProduct").val(currentPage);
	    }
	
	    /* 공급처 모달 실행 */
	    function fPopModalSupplier(supply_cd) {
	        //신규 저장
	        if (supply_cd == null || supply_cd == "") {
	            $("#action").val("I");
	            fInitFormSupplier();
	            gfModalPop("#layer1");
	        } else {
	            $("#action").val("U");
	            fSelectSupplier(supply_cd);
	        }
	    }
	
	
	    /* 공급처 단건 조회*/
	    function fSelectSupplier(supply_cd) {
	    	var param = {
	            supply_cd: supply_cd
	        };
	        var resultCallback = function (data) {
	        	fSelectSupplierResult(data);
	        };
	        
	        callAjax("/scm/selectSupplier.do", "post", "json", true, param,
	            resultCallback);
	    }
	
	    // 공급처 단건 조회 콜백 함수
	    function fSelectSupplierResult(data) {
	        if (data.result == "SUCCESS") {
	            gfModalPop("#layer1")
	            fInitFormSupplier(data.supplierInfoModel);
	        } else {
	            swal(data.resultMsg);
	        }
	    }
	
	
	    /* 공급처 폼 초기화 */
	    function fInitFormSupplier(object) {
	        $("#supply_cd").focus();
	
	        if (object == "" || object == null || object == undefined) {
	            $("#supply_cd").val("");
	            $("#supply_nm").val("");
	            $("#supply_mng_nm").val("");
	            $("#tel").val("");
	            $("#mng_tel").val("");
	            $("#email").val("");
	            $("#warehouse_cd").val("");
	            $("#warehouse_nm").val("");
	
	            $("#supply_cd").attr("readonly", false);
	            $("#supply_cd").css("background", "#FFFFFF");
	            $("#warehouse_cd").attr("readonly", true);
	            $("#warehouse_cd").css("background", "#F5F5F5");
	
	            $("#btnDeleteSupplier").hide();
	        } else {
	            $("#supply_cd").val(object.supply_cd);
	            $("#supply_cd").attr("readonly", true);
	            $("#supply_cd").css("background", "#F5F5F5");
	            $("#supply_nm").val(object.supply_nm);
	            $("#supply_mng_nm").val(object.supply_mng_nm);
	            $("#tel").val(object.tel);
	            $("#mng_tel").val(object.mng_tel);
	            $("#email").val(object.email);
	            $("#warehouse_cd").val(object.warehouse_cd);
	            $("#warehouse_nm").val(object.warehouse_cd);
	
	            $("#warehouse_cd").attr("readonly", true);
	            $("#warehouse_cd").css("background", "#F5F5F5");
	
	
	            $("#btnDeleteSupplier").show();
	        }
	    }
	
	
	    /* 공급처 저장 validation*/
	    function fValidateSupplier() {
	        var chk = checkNotEmpty([
	            ["supply_cd", "공급처코드를 입력하세요."],
	            ["supply_nm", "공급처명 입력하세요."],
	            ["supply_mng_nm", "담당자명을 입력하세요."],
	            ["tel", "연락처를 입력하세요."],
	            ["email", "이메일 입력하세요."],
	            ["warehouse_cd", "창고코드를 입력하세요."],
	            ["mng_tel", "담당자 연락처를 입력하세요."]
	            /* [ "warehouse_nm", "창고명을 입력하세요." ] */
	        ]);
	        if (!chk) {
	            return;
	
	        }
	        return true;
	    }
	
	    //공급처 저장
	    function fSaveSupplier() {
	        //validation 체크
	        if (!fValidateSupplier()) {
	            return;
	        }
	        var resultCallback = function (data) {
	            console.log(data);
	            fSaveSupplierResult(data);
	        };
	        callAjax("/scm/saveSupplier.do", "post", "json", true, $("#myForm")
	            .serialize(), resultCallback);
	    }
	
	    //공급처 저장 콜백 함수
	    function fSaveSupplierResult(data) {
	        var currentPage = "1";
	        if ($("#action").val() != "I") {
	            currentPage = $("#currentPageSupplier").val();
	        }
	        if (data.result == "SUCCESS") {
	            swal(data.resultMsg);
	            gfCloseModal();
	            fListSupplier(currentPage);
	        } else {
	            swal(data.resultMsg);
	        }
	    }
	
	    //공급처 삭제
	    function fDeleteSupplier(supply_cd) {
	        var con = confirm("삭제하시겠습니까 ?");
	        var currentPage = "1";
	        if (con) {
	            var resultCallback = function (data) {
	                fSaveSupplierResult(data);
	            }
	            $("#action").val("D");
	            callAjax("/scm/saveSupplier.do", "post", "json", true, $("#myForm").serialize(), resultCallback);
	        } else {
	            gfCloseModal();
	        }
	    }
	
	    /* 검색 기능*/
	    function board_search(currentPage) {
	        $('#listSupplierProduct').empty();
	        currentPage = currentPage || 1;
//	      var sname = $('#sname');
//	      var searchKey = document.getElementById("searchKey");
//			var oname = searchKey.options[searchKey.selectedIndex].value;
			var sname = $('#sname').val();
			var searchKey = $("#searchKey").val();
			var oname = $("#searchKey option:selected").val();
	
	        var param = {
	            sname: sname,
	            oname: oname,
	            currentPage: currentPage,
	            pageSize: pageSizeSupplier
	        }
	
	
	        var resultCallback = function (data) {
	            flistSupplierResult(data, currentPage);
	        };
	        callAjax("/scm/listSupplier.do", "post", "text", true, param,
	            resultCallback);
	    }
	
	    //창고명 검색 콤보박스
	    function selectwarehouse() {
	
	        var selwh = $("#warehouse_nm").val();
	
	        //alert("selectwarehouse : " + $("#warehouse_nm").val());
	
	        $("#warehouse_cd").val(selwh);
	
	
	
	    }
	
	
	
	
	</script>
	</head>
	
	<body>
	<form id="myForm" action="" method="">
	    <input type="hidden" id="currentPageSupplier" value="1">
	    <input type="hidden" id="currentPageProduct" value="1">
	    <input type="hidden" id="tmpsupply_nm" value="">
	    <input type="hidden" id="tmpsupply_cd" value="">
	    <input type="hidden" name="action" id="action" value="">
	    <div id="mask"></div>
	    <div id="wrap_area">
	
	        <h2 class="hidden">header 영역</h2>
	        <jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>
	        <h2 class="hidden">컨텐츠 영역</h2>
	        <div id="container">
	            <ul>
	                <li class="lnb">
	                    <!-- lnb 영역 -->
	                    <jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
	                </li>
	
	                <li class="contents">
	                    <!-- contents -->
	                    <h3 class="hidden">contents 영역</h3> <!-- content -->
	                    <div class="content">
							
							
							<div id="addVue">
		                        <p class="Location">
		                            <a href="/system/notice.do" class="btn_set home">메인으로</a>
		                            <a class="btn_nav">기준 정보</a>
		                            <span class="btn_nav bold">공급처 관리</span>
		                            <a href="" class="btn_set refresh">새로고침</a>
		                        </p>
		
		                        <p class="conTitle">
		                            <span>공급처 정보</span>
		                            <span class="fr">
		                            
									
		                                <!-- 요부분 vue로 변경 -->
		                                <!-- <a href="javascript:fPopModalSupplier()" class="btnType blue" name="modal" style="float: right; display: ;"> -->
		                                <a @click="createSupplier" class="btnType blue" name="modal" style="float: right; cursor: pointer;">
		                                    <span>신규등록</span>
		                                </a>
								</div>
	
	
	                            </span>
	                        </p>
							
							<div id="supplierVue">
							
		                        <div class="SupplierList">
		                            <div class="conTitle" style="margin: 0 25px 10px 0; float: left;">
		                                <select id="searchKey" name="searchKey" style="width: 100px;" v-model="searchKey">
		                                    <option value="all" selected="selected">전체</option>
		                                    <option value="supply_nm">공급처명</option>
		                                    <option value="supply_mng_nm">담당자명</option>
		                                </select>
		                                <input type="text" style="width: 300px; height: 30px;" id="sname" name="sname">
		                                <a @click="board_search" class="btnType blue" id="searchBtn" name="btn" >
		                                    <span>검 색</span>
		                                </a>
		                            </div>
		                            <table class="col">
		                                <caption>caption</caption>
		                                <colgroup>
		                                    <col width="10%">
		                                    <col width="10%">
		                                    <col width="17%">
		                                    <col width="10%">
		                                    <col width="17%">
		                                    <col width="16%">
		                                    <col width="10%">
		                                    <col width="10%">
		                                </colgroup>
		
		                                <thead>
		                                    <tr>
		                                        <th scope="col">공급처코드</th>
		                                        <th scope="col">공급처명</th>
		                                        <th scope="col">연락처</th>
		                                        <th scope="col">담당자명</th>
		                                        <th scope="col">담당자 연락처</th>
		                                        <th scope="col">이메일</th>
		                                        <th scope="col">창고명</th>
		                                        <th scope="col">비고</th>
		                                    </tr>
		                                </thead>
		                                <tbody id="listSupplier" v-if="supplierlist.length">
		                                	<tr   v-for="(item, index) in supplierlist" :key="index">
		                                		<td>{{ item.supply_cd }}</td>
		                                		<td  v-on:click="detailSupplier(item.supply_cd, item.supply_nm)" style="color:black; cursor: pointer;">{{ item.supply_nm }}</td>
		                                		<td>{{ item.tel }}</td>
		                                		<td>{{ item.supply_mng_nm }}</td>
		                                		<td>{{ item.mng_tel }}</td>
		                                		<td>{{ item.email }}</td>
		                                		<td>{{ item.warehouse_nm }}</td>
		                                		<td><a @click="modifySupplier(item.supply_cd);" class="btnType3 color1"><span>수정</span></a></td>
		                                	</tr>
		                                </tbody>
		                            </table>
		                        </div>
		                        <!-- footer 밑까지 div 걸기 / 모달 역시 마찬가지 -->
		                        <div class="paging_area" id="supplierPagination"></div>
		
		                        <p class="conTitle mt50">
		                            <span>공급 제품정보<span id="subTitle"></span></span>
		                        </p>
		
		                        <div class="ProductList">
		                            <table class="col">
		                                <caption>caption</caption>
		                                <colgroup>
		                                    <col width="15%">
		                                    <col width="15%">
		                                    <col width="15%">
		                                    <col width="15%">
		                                </colgroup>
		                                <thead>
		                                    <tr>
		                                        <th scope="col">제품코드</th>
		                                        <th scope="col">제품명</th>
		                                        <th scope="col">품목명</th>
		                                        <th scope="col">장비구매액(원)/EA</th>
		                                    </tr>
		                                </thead>
		                                <tbody id="listSupplierProduct">
			                                    <tr v-if="detail_supplier.length === 0">
			                                        <td colspan="4">공급처를 선택해 주세요.</td>
			                                    </tr>
			                                   <tr v-for="(item, index) in detail_supplier" >
			                                    	<td>{{ item.product_cd }}</td>
			                                    	<td>{{ item.prod_nm }}</td>
			                                    	<td>{{ item.l_ct_nm }}</td>
			                                    	<td>{{ item.purchase_price}}</td>
	                                    		</tr>

		                                </tbody>
		                            </table>
		                        </div>
		
		                        <div class="paging_area" id="productPagination"></div>
		                        
		                    </div>
		                    
		                    
	                    </div>
	
	                    <h3 class="hidden">풋터 영역</h3>
	                    <jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
	                </li>
	            </ul>
	        </div>
	    </div>
	
	    <!-- 모달 -->
	
	    <div id="layer1" class="layerPop layerType2" style="width: 600px;">
	        <dl>
	            <dt>
	                <strong>공급처 관리</strong>
	            </dt>
	            <dd class="content">
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
	                            <th scope="row">공급처명 <span class="font_red">*</span></th>
	                            <td colspan=3><input type="text" class="inputTxt p100" name="supply_nm"
	                                    id="supply_nm" maxlength="100" /></td>
	                        </tr>
	                        <tr>
	                            <th scope="row">공급처코드 <span class="font_red">*</span></th>
	                            <td><input type="text" class="inputTxt p100" name="supply_cd" id="supply_cd"
	                                    maxlength="20" /></td>
	                            <th scope="row">연락처<span class="font_red">*</span></th>
	                            <td><input type="text" class="inputTxt p100" name="tel" id="tel"
	                                    maxlength="20" /></td>
	                        </tr>
	                        <tr>
	                            <th scope="row">담당자명 <span class="font_red">*</span></th>
	                            <td><input type="text" class="inputTxt p100" name="supply_mng_nm"
	                                    id="supply_mng_nm" maxlength="50" /></td>
	
	                            <th scope="row">담당자 연락처<span class="font_red">*</span></th>
	                            <td><input type="text" class="inputTxt p100" name="mng_tel" id="mng_tel"
	                                    maxlength="20" /></td>
	
	                        </tr>
	
	                        <tr>
	                            <th scope="row">이메일 <span class="font_red">*</span></th>
	                            <td colspan=3><input type="text" class="inputTxt p100" name="email" id="email"
	                                    maxlength="100" /></td>
	                        </tr>
	                        <tr>
	                            <th scope="row">창고코드 <span class="font_red">*</span></th>
	                            <td><input type="text" class="inputTxt p100" name="warehouse_cd"
	                                    id="warehouse_cd" /></td>
	                            <th scope="row">창고명</th>
	                            <td><select id="warehouse_nm" name="warehouse_nm"
	                                    onChange="javascript:selectwarehouse()"></select></td>
	                        </tr>
	                    </tbody>
	                </table>
	
	
	                <div class="btn_areaC mt30">
	                    <a href="" class="btnType blue" id="btnSaveSupplier" name="btn"><span>저장</span></a>
	                    <a href="" class="btnType blue" id="btnDeleteSupplier" name="btn"><span>삭제</span></a>
	                    <a href="" class="btnType gray" id="btnCloseSupplier" name="btn"><span>닫기</span></a>
	
	                </div>
	
	
	            </dd>
	        </dl>
	        <a href="" class="closePop" id="btnClose" name="btn"><span class="hidden">닫기</span></a>
	    </div>
	</form>
	</body>
	
</html>
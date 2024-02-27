<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공급처 관리</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
<script src="https://unpkg.com/axios@0.12.0/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<script type="text/javascript">
  //공급처정보 페이징 처리
  var pageSizeSupplier = 12; //공급처정보 페이지 사이즈
  var pageBlockSizeSupplier = 5; //공급처정보 페이지 블록 갯수
  
  //제품정보 페이징 처리 
  var pageSizeProduct = 5; //제품정보 페이지 사이즈
  var pageBlockSizeProduct = 5; //제품정보 페이지 블록 갯수
  
  var listSupplier; // 납품업체 리스트 조회
  var listProduct; // 제품 리스트 조회
  
  var supplierSearch; 
  var editSupplierInfo;
  var fInitFormSupplier;
  
  
  //OnLoad event
  $(document).ready(function() {
	  
	  init();
  });
    
function init(){
	  listSupplier = new Vue({
			el : "#listSupplier",
			data : {
				supplierlist : [],
				supplierPagination : {pagenavi : ''},
				param : {
				  currentPage : currentPage.value || 1,
				  pageSize : pageSizeSupplier
				}, 
				
			},
			methods : {
				prodetail: function (supply_cd) {
		            listProduct.prodetail(supply_cd);
		        },
		        searchSupplies : function(){
		        	supplierSearch.searchSupplies();
		        },
		        updateSupplies : function(supply_cd){
		        	editSupplierInfo.updateSupplies(supply_cd);
		        } 
		        
			},
			mounted: function() {
				 axios.post('listSupplierVue.do', this.param)
			  	  .then(response => {
			  	  	this.supplierlist = response.data.listSupplierModel;
				  	var totalListSupDetail = response.data.totalSupplier;
				  
			  	  })
			  	  .catch(error => {
			  		  console.log(error);
			  	  })
			},
  
		})
	  
	  listProduct = new Vue({
			el :"#listProduct",
			data:{
				param : {
					  currentPage : currentPage.value || 1,
					  pageSize : pageSizeSupplier,
					  supply_cd : ''
					}, 
					productlist : [], 
					productPagination : {pagenavi : ''},
			},
			methods: {
				prodetail : function(supply_cd){
				    
					this.param.supply_cd = supply_cd;
					 axios.post('listSupplierProductVue.do', this.param)
				  	  .then(response => {
				  		  
				  	  	this.productlist = response.data.listSupplierProductModel;
					  	var totalListProDetail = response.data.totalProduct;
					  
				  	  })
				  	  .catch(error => {
				  		  console.log(error);
				  	  })
				
			}
			}
		})
		
	  supplierSearch = new Vue({
		  el: "#searchSupplier",
		  data: {
		      searchKey: "all",
		      selectList: [
		        { value: "all", text: "전체" },
		        { value: "supply_nm", text: "공급처명" },
		        { value: "supply_mng_nm", text: "담당자명" },
		      ],
		      searchText: "",
			  currentPage : currentPage.value || 1,
			  pageSize : pageSizeSupplier,
		    },
		  methods: {
		    searchSupplies: function () {
		    	const data = {
		    			oname : this.searchKey,
		    			sname : this.searchText,
		    			currentPage : this.currentPage,
		    			pageSize : this.pageSize
		    	}
		    	
		      axios.post('listSupplierVue.do', data)
		        .then(response => {
		          listSupplier.supplierlist = response.data.listSupplierModel;
				  var totalListSupDetail = response.data.totalSupplier;
				  
		        })
		        .catch(error => {
		          console.log(error);
		        })
		    },
		  },
		})
	  
	  editSupplierInfo = new Vue({
		  el : "#layer1",
		  data : {
			  supply_cd : "",
			  supply_nm : "",
			  tel : "",
			  supply_mng_nm : "",
			  mng_tel : "",
			  email : "",
			  warehouse_nm : "",
			  warehouse_cd : "",
			  action : "U"
		  },
		  methods : {
			  updateSupplies : function(supply_cd){
				  var param = {
						  supply_cd : supply_cd
					};
				  
				  axios.post('selectSupplierVue.do', param)
				  	.then(function(response){
				  		
				  		// frealPopModal(response.data.SupplierInfoModel);
				  		
				  		this.supply_nm = response.data.SupplierInfoModel.supply_nm;
				  		this.supply_cd = response.data.SupplierInfoModel.supply_cd;
				  		this.tel = response.data.SupplierInfoModel.tel;
				  		this.supply_mng_nm = response.data.SupplierInfoModel.supply_mng_nm;
				  		this.mng_tel = response.data.SupplierInfoModel.mng_tel;
				  		this.email = response.data.SupplierInfoModel.email;
				  		this.warehouse_cd = response.data.SupplierInfoModel.warehouse_cd;
				  		// this.warehouse_nm = response.data.SupplierInfoModel.warehouse_nm;
				  		
				  		console.log(this.supply_cd);
				  		console.log(this.supply_nm);
				  		console.log(this.tel);
				  		console.log(this.supply_mng_nm);
				  		console.log(this.mng_tel);
				  		console.log(this.email);
				  		console.log(this.warehouse_cd);
				  		// console.log(this.warehouse_nm);
				  		gfModalPop("#layer1");
				  	})
				  	.catch(function(error){
				  		console.log(error);
				  	})
			  }
	  }
	  })


	  
}
  
</script>
</head>
<body>                 
	<form id="myForm" action="" method="">
		<input type="hidden" id="currentPage" value="1"> <input
			type="hidden" id="currentPageSupplier" value="1"> <input
			type="hidden" id="currentPageProduct" value="1"> <input
			type="hidden" id="tmpsupply_nm" value=""> <input
			type="hidden" id="tmpsupply_cd" value=""> <input
			type="hidden" name="action" id="action" value="">
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
								<a href="/system/notice.do" class="btn_set home">메인으로</a> <a
									class="btn_nav">기준 정보</a> <span class="btn_nav bold">공급처
									관리</span> <a href="" class="btn_set refresh">새로고침</a>
							</p>

							<p class="conTitle">
								<span>공급처 정보</span> <span class="fr"> <!-- <a
									href="" class="btnType blue"
									name="modal" style="float: right;"> <span>신규등록</span> -->
								</a>

								</span>
							</p>

							<div class="SupplierList">
								<div class="conTitle" style="margin: 0 25px 10px 0; float: left;">
									<template id="searchSupplier">
										<div>
											<select v-model="searchKey" style="width: 100px;">
												<option v-for="(key, index) in selectList" :value="key.value" v-bind:key="index">
													{{ key.text }}
												</option>
											</select>
											<input v-model="searchText" type="text" style="width: 300px; height: 30px;"
												id="sname" name="sname"> <a @click="searchSupplies"
												class="btnType blue" id="searchBtn" name="btn"> <span>검
													색</span>
											</a>
										</div>
									</template>
								</div>
								<div id="listSupplier">
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
										<tbody>
											<tr v-if="supplierlist.length == 0">
												<td colspan = "8">데이터가 없습니다.</td>
											</tr>
											<tr v-for="(item, index) in supplierlist"
											v-else-if="supplierlist.length">
												<td>{{item.supply_cd}}</td>
												<td v-on:click="prodetail(item.supply_cd)">{{item.supply_nm}}</td>
												<td>{{item.tel}}</td>
												<td>{{item.supply_mng_nm}}</td>
												<td>{{item.mng_tel}}</td>
												<td>{{item.email}}</td>
												<td>{{item.warehouse_nm}}</td>
												<td><a @click="updateSupplies(item.supply_cd);" class="btnType3 color1"><span>수정</span></a></td>
											</tr>
										</tbody>
									</table>
								</div>

								<div class="paging_area" id="supplierPagination"
									v-html="pagenavi"></div>
							</div>



							<p class="conTitle mt50">
								<span>공급 제품정보<span id="subTitle"></span></span>
							</p>

							<div class="ProductList">
								<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="15%">
										<col width="15%">
										<col width="23%">
										<col width="15%">
										<col width="15%">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">공급처명</th>
											<th scope="col">제품코드</th>
											<th scope="col">제품명</th>
											<th scope="col">품목명</th>
											<th scope="col">장비구매액(원)/EA</th>
										</tr>
									</thead>
									<tbody id="listProduct">
										<tr v-if="productlist.length == 0">
											<td colspan="5">공급처를 선택해주세요.</td>
										</tr>
										<tr v-else-if="productlist.length" v-for="(item, index) in productlist">
											<td>{{item.supply_nm}}</td>
											<td>{{item.product_cd}}</td>
											<td>{{item.prod_nm}}</td>
											<td>{{item.l_ct_nm}}</td>
											<td>{{item.purchase_price}}</td>
										</tr>
									</tbody>
								</table>
							</div>

							<div class="paging_area" id="productPagination"></div>


						</div>

						<h3 class="hidden">풋터 영역</h3> <jsp:include
							page="/WEB-INF/view/common/footer.jsp"></jsp:include>
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
								<td colspan=3><input type="text" class="inputTxt p100"
									name="supply_nm" id="supply_nm" v-model="supply_nm" maxlength="100" /></td>
							</tr>
							<tr>
								<th scope="row">공급처코드 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="supply_cd" id="supply_cd" v-model="supply_cd" maxlength="20" /></td>
								<th scope="row">연락처<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="tel"
									id="tel" v-model="tel" maxlength="20" /></td>
							</tr>
							<tr>
								<th scope="row">담당자명 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="supply_mng_nm" id="supply_mng_nm" v-model="supply_mng_nm" maxlength="50" /></td>

								<th scope="row">담당자 연락처<span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100" name="mng_tel"
									id="mng_tel" v-model="mng_tel" maxlength="20" /></td>

							</tr>

							<tr>
								<th scope="row">이메일 <span class="font_red">*</span></th>
								<td colspan=3><input type="text" class="inputTxt p100"
									name="email" id="email" v-model="email" maxlength="100" /></td>
							</tr>
							<tr>
								<th scope="row">창고코드 <span class="font_red">*</span></th>
								<td><input type="text" class="inputTxt p100"
									name="warehouse_cd" id="warehouse_cd" v-model="warehouse_cd" /></td>
								<th scope="row">창고명</th>
								<td><select id="warehouse_nm" name="warehouse_nm" v-model="warehouse_nm" 
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
			<a href="" class="closePop" id="btnClose" name="btn"><span
				class="hidden">닫기</span></a>
		</div>
	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>반품신청 목록 Vue :: ChainMaker</title>
	<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
	<link rel="stylesheet" href="${CTX_PATH}/css/view/scm/orderList.css">
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	</head>
	<template>
		<input type="hidden" id="currentPage" value="1">
		<div id="wrap_area">
			<h2 class="hidden">컨텐츠 영역</h2>
				<div id="container">				
					
					<ul>
					<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
					<!--// lnb 영역 -->
				</li>
					</ul>

					
				</div>
		</div>
	</template>
	<script>
	
		var currentPage = 1;
		var pageSizeRefundList = 5;
		var pageBlockSizerefundList = 10;
	
		var container;
		
		$(document).ready(function() {
			container = new Vue({
				el: '#container',
				data:{
					refundListData:[],
					param: {
						currentPage : currentPage,
						pageSize: pageSizeRefundList
					}
				},
				created: function() {
					axios({
						url: '/scm/refundListinfoVue.do',
						method: 'post',
						async: true,
						data: this.param,
					})
					.then(function(response) {
						console.log("SUCCESS", response.data);
						refundListData = response.data.refundList;
					})
					.catch(function(error) {
						console.log("error : " + error);
					})
				}
			})
		})
	</script>
	
	<style>
	
	</style>
</html>

// 반품신청 목록 페이징 설정
var currentPage = 1;
var pageSizeRefundList = 5;
var pageBlockSizerefundList = 10;

var refundList;
var refundListDetail;

$(document).ready(function() {
  // 반품신청 목록
	
	init()
	
//  getRefundList();
  console.log("vue 작업 js 연결");
  
});

function init() {
	console.log('test');
	dataMounted();
}

function dataMounted() {
	refundList = new Vue({
		el : '#refundListHistory',
		data: {
			refundListData: [],
			totalCount:0,
			param : {
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
				console.log("SUCCESS",  response.data);
				getRefundListResult(response.data);
			})
			.catch(function(error) {
				console.error("error : " + error);
			})
		},
		methods: {
			detailView: function(num) {
				alert(num);
				getRefundDetail(num);
			}
		}
	});	
}

Vue.component('refundDetail-component', {
	mounted: function() {
		console.log('컴포넌트가 마운트 되었습니다.');
	}, 
	template: '#refundDetail-table-template'
});

/** 반품신청 목록 조회 콜백 함수 */

function getRefundListResult(data) {
   refundList.refundListData = data.refundList;
   refundList.totalCount = data.refundListCnt;
  
  // 페이지 네비게이션 생성
  var paginationHtml = getPaginationHtml(currentPage, refundList.totalCount, pageSizeRefundList, pageBlockSizerefundList, 'searchRefundList');

  $("#refundListPagination").empty().append(paginationHtml);

  // 현재 페이지 설정
  $("#currentPage").val(currentPage);
};

/* 반품 디테일 정보 */
function getRefundDetail(orderCode) {
	
	console.log(orderCode);
	
	refundListDetail = new Vue({
		el: '#detailRefund',
		data: {
			param: {
				orderCode: orderCode
			},
			refundDetail : null
		},
		mounted: function() {
			axios({
				url:'/scm/refundDetailInfoVue.do',
				method: 'post',
				async: true,
				data: this.param
			})
			.then(function(response){
				console.log("SUCCESS", response);
				getRefundDetailResult(response.data.refundDetail)
			}) 
			.catch(function(error) {
				console.error("error : " + error)
			})
		}
	});
	
//  var param = {
//      orderCode: orderCode
//  };
//  
//  var resultCallback = function(data) {
//    getRefundDetailResult(data);
//  }
//  
//  callAjax("/scm/refundDetailInfo.do", "post", "text", true, param, resultCallback);
};


function getRefundDetailResult(data) {
  	refundListDetail.refundDetail = data;
	console.log("refundListDetail.refundDetail : " + refundListDetail.refundDetail);
	console.log(refundListDetail.refundDetail);
};

/** 반품신청 목록 조회 */
/*
function getRefundList(currentPage) {
  
  currentPage = currentPage || 1;

  console.log("currentPage : " + currentPage);

  var param = {
    currentPage: currentPage, 
    pageSize: pageSizeRefundList
  };

  var resultCallback = function(data) {
    getRefundListResult(data, currentPage);
  };
  
  callAjax("/scm/refundListInfoVue.do", "post", "json", true, param, resultCallback);
};
*/

/*
function closeRefundDetail() {
  $('#detailRefund').empty();
}

function requestApprove() {
  var param = $('#refundForm').serialize();
  
  var resultCallback = function(data) {
    getRefundApproveResult(data);
  }
  
  callAjax("/scm/refundDirectionInsert.do", "post", "json", true, param, resultCallback);
}

function getRefundApproveResult(data) {
  if (data.result === "SUCCESS") {
    swal(data.resultMsg).then(function() {
      window.location.reload(); // 새로고침
    });
    console.log("상태 업데이트 완료");
    return 1;
  } else {
    swal(data.resultMsg).then(function() {
      window.location.reload(); // 새로고침
    });
    console.log("상태 업데이트 실패");
    return 0;
  }
}

// 반품신청목록 검색 기능
function searchRefundList(currentPage) {
  var param = $('#refundListForm').serialize();
  console.log(param);
  
  currentPage = currentPage || 1;
  
  param += "&currentPage="+currentPage;
  param += "&pageSize="+pageSizeRefundList;
  
  var startD = $('#startDate').val();
  var endD = $('#endDate').val();
  
  console.log(param);
  
  // 날짜 에러 있을 때, 경고창 띄우고 refresh
  if (startD > endD) {
    swal("시작일자가 종료일자보다 뒤에 있을 수 없습니다.\n날짜를 다시 지정해주세요.").then(function() {
      window.location.reload();
    });
    return 0;
  } 
  
  var resultCallback = function(data) {
    getRefundListResult(data, currentPage);
  };
  
  callAjax("/scm/refundListInfo.do", "post", "text", true, param, resultCallback);
}

$('input[type="text"]').keydown(function(event) {
  if (event.keyCode === 13) {
    searchRefundList();
  };
});
*/

//function fExcelDownload(tableID, fileID){
//$("#"+tableID).table2excel({
//exclude: ".noExl",
//name: "Excel Document Name",
//filename: fileID +'.xls', // 확장자를 여기서 붙여줘야한다.
//fileext: ".xls",
//exclude_img: true,
//exclude_links: true,
//exclude_inputs: true
//});
//}
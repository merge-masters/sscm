<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${totalCount eq 0}">
  <tr>
    <td colspan="7">데이터가 존재하지 않습니다.</td>
  </tr>
</c:if>
<c:if test="${totalCount > 0}">
  <c:set var="nRow" value="${pageSize*(currentPage - 1)}" />
  <c:forEach items="${purchasePaperList}" var="purchase">
    <tr class="purchaseList" ${purchase.owner_approve_yn eq 'N' ? 'disabled' : ''}
                    ${purchase.deposit_check_yn eq 'Y' ? 'disabled' : ''}>
      <td>${purchase.purchase_code}</td>
      <td><a href="javascript:fPopModalSendDeli('${purchase.purchase_code}', '${purchase.company_class_name}','${purchase.product_model_name}', '${purchase.purchase_count}', '${purchase.product_model_number}', '${purchase.owner_approve_yn}', '${purchase.deposit_check_yn}' )">${purchase.company_class_name}</a></td>
      <td>${purchase.product_model_name}</td>
      <td>${purchase.purchase_count}</td>
      <td>${purchase.purchase_date}</td>
      <td id="owner_approve_yn">${purchase.owner_approve_yn}</td>
     <td> 
            <button class="deposit_check" data-approval-status="${purchase.deposit_check_yn}" 
                    ${purchase.owner_approve_yn eq 'N' ? 'disabled' : ''}
                    ${purchase.deposit_check_yn eq 'Y' ? 'disabled' : ''}>확인</button>
        </td>  
    </tr>
    <!-- <td>${purchase.deposit_check_yn}</td> -->
    <c:set var="nRow" value="${nRow + 1}" />
  </c:forEach>
</c:if>
<input type="hidden" id="totalCount" name="totalCount" value="${totalCount}" />


<script>

$(".deposit_check").click(function(){
	    var purchaseCode = $(this).closest('tr').find('.purchase_code').text();
	    var currentButton = $(this); 

	    if (confirm("입금 처리하시겠습니까?")) {
	        $.ajax({
	            type: "POST",
	            url: "/order/checkDeposit.do",
	            data: { purchaseCode: purchaseCode },
	            success: function(response) {
	                // 성공 시 실행할 코드
	                alert("입금 처리되었습니다.");
	                currentButton.prop('disabled', true);
	                //location.href = "/order/purchasePaper.do";
	            },
	            error: function(error) {
	                // 실패 시 실행할 코드
	                console.log(error);
	            }
	        });
	    }
	});

</script>
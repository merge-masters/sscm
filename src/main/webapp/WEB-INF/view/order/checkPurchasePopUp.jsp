<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  
    <!-- 발주지시서 모달 시작-->
    <div id="layer1" class="layerPop layerType2" style="width: 600px;">
      <input type="hidden" id="notice_id">
      <dl>
        <dt id="dt_write">
          <strong>발주 지시서</strong>
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
                <th scope="row">발주번호</th>
                <td><input type="text" class="inputTxt p100" name="purchase_code" id="purchase_code" /></td>
                <th scope="row">발주회사</th>
                <td><input type="text" class="inputTxt p100" name="company_class_name" id="company_class_name" /></td>
              </tr>
              <tr>
              	<th scope="row">제품명</th>
              	<td colspan="3"><input type="text" class="inputTxt p100" name="product_model_name" id="product_model_name" /></td>
              </tr>
              <tr>
              <th scope="row">제품번호</th>
              <td><input type="text" class="inputTxt p100" name="product_model_number" id="product_model_number" /></td>
              <th scope="row">제품수량</th>
              <td><input type="text" class="inputTxt p100" name="purchase_count" id="purchase_count" /></td>
             </tr>
            </tbody>
          </table>
          <div class="btn_areaC mt30">
          <a href="" class="btnType blue" id="startDelivery" name="btn"><span>전송</span></a> 
          <a href=""  class="btnType gray"  id="btnCloseGrpCod" name="btn"><span>취소</span></a>
        </div>
        </dd>
      </dl>
      <a class="closePop" id="closePop_button"><span class="hidden">닫기</span></a>
    </div>
    
   

    
    
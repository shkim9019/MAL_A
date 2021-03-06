<%--
  /**
  * Class Name : 
  * Description : 
  * Modification Information
  *
  *   수정일                   수정자                      수정내용
  *  -------    --------    ---------------------------
  *  2020. 2. 25. 오후 6:15:47   sist         최초 생성
  *
  * author 쌍용교육센터 E반
  * since 2009.01.06
  *
  * Copyright (C) 2009 by KandJang  All right reserved.
  */
--%>
<%@page import="com.mal_a.room.RoomVO"%>
<%@page import="com.mal_a.member.MemberVO"%>
<%@page import="com.mal_a.payment.PaymentCont"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/cmn/common.jsp" %>
<%
	String point = (String)request.getAttribute("point");
	String sno = (String)request.getAttribute("sno");
	String email = (String)request.getAttribute("email");
	String name = (String)request.getAttribute("name");
	String tel = (String)request.getAttribute("tel");
	String addr = (String)request.getAttribute("addr");
	String addrNo = (String)request.getAttribute("addrNo");
	request.setAttribute("point", point);
%>
<c:url value="/roxandrea/member.do" var="logOut">
 <c:param name="workDiv" value="doLogout"></c:param>	
</c:url>

<c:url value="/roxandrea/member.do" var="myPage">
 <c:param name="workDiv" value="doSelectOne"></c:param>
</c:url>

<c:url value="/roxandrea/board.do" var="hrUrl">
 <c:param name="workDiv" value="doRetrieve"></c:param>
</c:url>
<!DOCTYPE html>
<html lang="en">
<head>
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" ></script>
<title>숙박의 민족 - MAL_A</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
	<link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Playfair+Display:400,400i,700,700i" rel="stylesheet">

    <link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="css/animate.css">
    
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">

    <link rel="stylesheet" href="css/aos.css">

    <link rel="stylesheet" href="css/ionicons.min.css">

    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">
    
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/icomoon.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
		<div class="container">
			<a class="navbar-brand" href="member_main.jsp">숙박의민족</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
				<span class="oi oi-menu"></span> Menu
	      	</button>
			<div class="collapse navbar-collapse" id="ftco-nav">
				<ul class="navbar-nav ml-auto">
	          	  <li class="nav-item"><a href="/MAL_A/roxandrea/store_search.jsp" class="nav-link">업체검색</a></li>
		          <li class="nav-item"><a href="${hrUrl}" class="nav-link">자유게시판</a></li>
		          <li class="nav-item"><a href="${myPage}" class="nav-link">마이페이지</a></li>
				  <li class="nav-item"><a href="${logOut}" class="nav-link" onclick="if(false == confirm('로그아웃 하시겠습니까?')){return false;}">로그아웃</a></li>
	        	</ul>
	      	</div>
		</div>
	</nav>
    <!-- END nav -->
    
	<div class="hero-wrap" style="background-image: url('images/bg_1.jpg');">
		<div class="overlay"></div>
		<div class="container">
			<div class="row no-gutters slider-text d-flex align-itemd-end justify-content-center">
          		<div class="col-md-9 ftco-animate text-center d-flex align-items-end justify-content-center">
          			<div class="text">
	            		<p class="breadcrumbs mb-2"><span>PAYMENT</span></p>
	            		<h1 class="mb-4 bread">PAYMENT</h1>
            		</div>
          		</div>
        	</div>
		</div>
	</div>
	
	<section class="ftco-section">
		
		<form name="paymentFrm" action="<%=HR_PATH %>/roxandrea/payment.do" method="post">
	    	<input type="hidden" name="workDiv" id="workDiv" value="doInsert"/>
	    	<input type="hidden" name="regId"/>
	    	<input type="hidden" name="checkDate" id="checkDate"/>
			<div class="container">
				<div class="row justify-content-center mb-5 pb-3">
	          		<div class="col-md-7 heading-section text-center ftco-animate">
	          			<span class="subheading">reservation</span>
	            	</div>
	            </div>
			</div>
			
			<!-- 달력 -->
	        <div class="container">
	        	<div class="row justify-content-center mb-5 pb-3">    
	        		<div class="col-md-7 heading-section text-center ftco-animate">		
						<div class="row justify-content-center mb-5 pb-3">
							<div class="wrap bg-white align-self-stretch py-3 px-4">
								<label for="#">체크인</label>
								<input type="text" class="form-control" placeholder="시작날짜" id="checkInDate" name="checkInDate" onchange="javascript:doCheckDate(0);"/>
							</div>
							<div class="wrap bg-white align-self-stretch py-3 px-4">
								<label for="#">체크아웃</label>
								<input type="text" class="form-control" placeholder="종료날짜" id="checkOutDate" name="checkOutDate" onchange="javascript:doCheckDate(0);"/>
							</div>
							<div class="wrap bg-white align-self-stretch py-3 px-4">
								<input type="button" value="날짜적용" id="dateBtn" />
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- //달력 -->
			
			<!-- 방선택 셀렉트 박스 -->
			<div class="container">    			
				<div class="row justify-content-center mb-5 pb-3">
					<div class="col-md-7 heading-section text-center ftco-animate">			
						<div class="wrap bg-white align-self-stretch py-3 px-4">
							<label for="#">방선택</label>
							<div class="form-field">
								<div class="icon"><span class="ion-ios-arrow-down"></span></div>
								<select name="" id="room" class="form-control" onchange="roomSelect(this.value)">
									<option value="">날짜와 방을 선택해주세요.</option>
			        			</select>
							</div>
						</div>
					</div>
				</div>
			</div><br/><br/>
			<!-- //방선택 셀렉트 박스 -->
			
			<!-- 결제정보란 -->
			<div class="container">    			
				<div class="row justify-content-center mb-5 pb-3">			
					<div class="wrap bg-white align-self-stretch py-3 px-4">			
						<div class="col-md-30 room-single mt-30 mb-30 ftco-animate">
							<div class="d-md-flex mt-10 mb-10 py-5">
								<table>
								<tr>
									<td><span>결제 금액&nbsp;:&nbsp;&nbsp;</span></td>
									<td><input type="text" id="pay" name="pay" value="0" style = "text-align:right;" readonly/>&nbsp;원</td>
			    				</tr>
			    				<tr>
			    					<td class="py-4"><span>내 포인트&nbsp;:&nbsp;&nbsp;</span></td>
			    					<td><input type="text" id="memberPoint" name="memeberPoint" value="<fmt:formatNumber value='${point }' pattern='#,###'/>" style="text-align:right;" readonly/>&nbsp;P</td>
			    					<td>
			    						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			    						<span>사용포인트:</span>
			    					</td>
		    						<td><input type="text" name="usePoint" id="usePoint" size="13" maxlength="10" translate="no"/><input type="button" value="적용" id="usePointBtn" /></td>
			    				</tr>
			    				<tr>
			    					<td><span>최종 결제 금액&nbsp;:&nbsp;&nbsp;</span></td>
			    					<td><input type="text" id="finalPay" name="finalPay" value="0" style="text-align:right;" readonly/>&nbsp;원</td>
			    					<td>
			    						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			    						<span>적립 예정 포인트&nbsp;:&nbsp;&nbsp;</span>
			    					</td>
			    					<td><input type="text" id="savePoint" name="savePoint" value="0" style="text-align:right;" readonly/>&nbsp;P</td>
			    				</tr>
			    				</table>
		    				</div>
		    			</div>
					</div>
				</div>
			</div>
	        <!-- //결제정보란 -->
        
        </form>
        
        <!-- 결제 API -->
        <div class="container">    			
			<div class="row justify-content-center mb-5 pb-3">			
				<div class="wrap bg-white align-self-stretch py-3 px-4">			
					<div class="col-md-30 room-single mt-30 mb-30 ftco-animate">
						<input type="button" value="결제테스트" onclick="javascript:doInsert();" />
						<input type="button" value="결제" id="paymentAPI" />
						<input type="button" value="취소" onclick="javascript:goBack();"/>
					</div>
				</div>
			</div>
		</div>
        <!-- //결제 API -->
        
    </section>

<%@ include file="/cmn/footer.jsp" %>
    
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


  <script src="js/jquery.min.js"></script>
  <script src="js/jquery-migrate-3.0.1.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/jquery.easing.1.3.js"></script>
  <script src="js/jquery.waypoints.min.js"></script>
  <script src="js/jquery.stellar.min.js"></script>
  <script src="js/owl.carousel.min.js"></script>
  <script src="js/jquery.magnific-popup.min.js"></script>
  <script src="js/aos.js"></script>
  <script src="js/jquery.animateNumber.min.js"></script>
  <script src="js/jquery.mb.YTPlayer.min.js"></script>
  <script src="js/bootstrap-datepicker.js"></script>
  <!-- // <script src="js/jquery.timepicker.min.js"></script> -->
  <script src="js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="js/google-map.js"></script>
  <script src="js/main.js"></script>
    
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
    
  </body>
  <script type="text/javascript">
  	//날짜 변경시 적용 버튼 눌렀는지 체크
  	function doCheckDate(check){
  		//체크값 체크
  		$("#checkDate").val(check);
  		
  		//셀렉트박스 초기화
		$("#room").find("option").remove().end().append("<option value=''>날짜와 방을 선택해주세요.</option>");
  		
  		//결제 정보란 초기화
		$("#pay").val(0);
    	$("#finalPay").val(0);
    	$("#savePoint").val(0);
  	}
  	//--날짜 변경시 적용 버튼 눌렀는지 체크
  
	//달력
	$(document).ready(function(){
		//달력 양식 생성
		$.datepicker.setDefaults({
			dateFormat: 'yy-mm-dd',
	        prevText: '이전 달',
	        nextText: '다음 달',
	        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	        showMonthAfterYear: true,
	        yearSuffix: 'Year'
		});
	    
		//달력 적용
	    $("#checkInDate").datepicker();
	    $("#checkOutDate").datepicker();
	});  
	//--달력
  
  	//결제완료 페이지로 이동
  	function goPaymentSelectOne(){
		var frm = document.paymentFrm;
		
		frm.workDiv.value = "doSelectOne";
		frm.action = '/MAL_A/roxandrea/payment.do';
		frm.submit();
  	}
	
  	//인서트 테스트 버튼
  	function doInsert(){
  		var sno = "<%=sno%>";
		var pay = Number(unComma($("#pay").val()));
  	  	var finalPay = Number(unComma($("#finalPay").val()));
  	  	var usePoint = pay - finalPay;
  	  	var rno = $("#room").val();
  	  	
  	  	//날짜 유효성 검사
  	  	var checkDate = $("#checkDate").val();
  	  	if(checkDate==0){
  	  		alert("날짜 적용 버튼을 눌러주세요.");
  	  		return;
  	  	}
  	  	
  	  	var checkInDate = $("#checkInDate").val();
	  	var checkOutDate = $("#checkOutDate").val();
	  	var checkInDateArr = checkInDate.split("-");
	  	var checkOutDateArr = checkOutDate.split("-");
	  	var startDt = checkInDateArr[0] + checkInDateArr[1] + checkInDateArr[2];
	  	var endDt = checkOutDateArr[0] + checkOutDateArr[1] + checkOutDateArr[2];
	  	
	  	//날짜 방 선택 유효성 검사
	  	if(finalPay=="날짜와 방을 선택해주세요."){
  			alert("날짜와 방을 선택해주세요.");
  			return;
  		}
  	  	
		if(false == confirm("결제 하시겠습니까?"))return;
  		
  		//import API
  		var IMP = window.IMP; // 생략가능
        IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        //onclick, onload 등 원하는 이벤트에 호출합니다
        IMP.request_pay({
            pg : 'inicis', // version 1.1.0부터 지원.
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : '숙박의 민족',
            amount : 1000,//최종결제금액
            buyer_email : '<%=email%>',//회원이메일
            buyer_name : '<%=name%>',//회원이름
            buyer_tel : '<%=tel%>',//회원전화번호
            buyer_addr : '<%=addr%>',//회원주소
            buyer_postcode : '<%=addrNo%>',//회원우편번호
            m_redirect_url : 'https://www.yourdomain.com/payments/complete',
            app_scheme : 'iamportapp'
        }, function(rsp) {
            if ( rsp.success ) {
                var msg = '결제가 완료되었습니다.';
                msg += '고유ID : ' + rsp.imp_uid;
                msg += '상점 거래ID : ' + rsp.merchant_uid;
                msg += '결제 금액 : ' + rsp.paid_amount;
                msg += '카드 승인번호 : ' + rsp.apply_num;
                
              //비동기통신
        		$.ajax({
        			type: "POST",//데이터 전송방식(POST/GET),
        			url: "/MAL_A/roxandrea/payment.do",//요청URL,
        			dataType: "html",//서버에서 받아올 데이터 타입,
        			data: {"workDiv": "doInsert",
        					"startDt": startDt,
        					"endDt": endDt,
        					"pay": finalPay,
        					"usePoint": usePoint,
        					"sno": sno,
        					"rno": rno,
        			},
        			success:function(data){//성공
        				goPaymentSelectOne();
        				//json String --> json object
        				//console.log("data="+data);
        				var jsonObj = JSON.parse(data);
        				//console.log("msgId="+jsonObj.msgId);
        				//console.log("msgContents="+jsonObj.msgContents);
        				//alert("data:"+data);
        				if(null != jsonObj && jsonObj.msgId=="1"){
        					alert(jsonObj.msgContents);
        					//goRetrieve();
        				}else{
        					alert(jsonObj.msgId+"|"+jsonObj.msgContents);
        				}
        			},
        			error: function(xhr,status,error){
        				alert("error:"+error);
        			},
        			complete:function(data){
        				
        			}
        		});//--ajax
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
            }
            document.getElementById("result").innerHTML = msg;
            alert(msg);
        });//--import API
  	}
  	//--인서트 테스트 버튼
  	
  	//결제 API 버튼
  	$("#paymentAPI").on('click', function(){
  		var sno = "<%=sno%>";
		var pay = Number(unComma($("#pay").val()));
  	  	var finalPay = Number(unComma($("#finalPay").val()));
  	  	var usePoint = pay - finalPay;
  	  	var rno = $("#room").val();
  	  	
  	  	//날짜 유효성 검사
  	  	var checkDate = $("#checkDate").val();
  	  	if(checkDate==0){
  	  		alert("날짜 적용 버튼을 눌러주세요.");
  	  		return;
  	  	}
  	  	
  	  	var checkInDate = $("#checkInDate").val();
	  	var checkOutDate = $("#checkOutDate").val();
	  	var checkInDateArr = checkInDate.split("-");
	  	var checkOutDateArr = checkOutDate.split("-");
	  	var startDt = checkInDateArr[0] + checkInDateArr[1] + checkInDateArr[2];
	  	var endDt = checkOutDateArr[0] + checkOutDateArr[1] + checkOutDateArr[2];
	  	
	  	//날짜 방 선택 유효성 검사
	  	if(finalPay=="날짜와 방을 선택해주세요."){
  			alert("날짜와 방을 선택해주세요.");
  			return;
  		}
  	  	
		if(false == confirm("결제 하시겠습니까?"))return;
  		
  		//import API
  		var IMP = window.IMP; // 생략가능
        IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        //onclick, onload 등 원하는 이벤트에 호출합니다
        IMP.request_pay({
            pg : 'inicis', // version 1.1.0부터 지원.
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : '숙박의 민족',
            amount : finalPay,//최종결제금액
            buyer_email : '<%=email%>',//회원이메일
            buyer_name : '<%=name%>',//회원이름
            buyer_tel : '<%=tel%>',//회원전화번호
            buyer_addr : '<%=addr%>',//회원주소
            buyer_postcode : '<%=addrNo%>',//회원우편번호
            m_redirect_url : 'https://www.yourdomain.com/payments/complete',
            app_scheme : 'iamportapp'
        }, function(rsp) {
            if ( rsp.success ) {
                var msg = '결제가 완료되었습니다.';
                msg += '고유ID : ' + rsp.imp_uid;
                msg += '상점 거래ID : ' + rsp.merchant_uid;
                msg += '결제 금액 : ' + rsp.paid_amount;
                msg += '카드 승인번호 : ' + rsp.apply_num;
                
              //비동기통신
        		$.ajax({
        			type: "POST",//데이터 전송방식(POST/GET),
        			url: "/MAL_A/roxandrea/payment.do",//요청URL,
        			dataType: "html",//서버에서 받아올 데이터 타입,
        			data: {"workDiv": "doInsert",
        					"startDt": startDt,
        					"endDt": endDt,
        					"pay": finalPay,
        					"usePoint": usePoint,
        					"sno": sno,
        					"rno": rno,
        			},
        			success:function(data){//성공
        				goPaymentSelectOne();
        				//json String --> json object
        				//console.log("data="+data);
        				var jsonObj = JSON.parse(data);
        				//console.log("msgId="+jsonObj.msgId);
        				//console.log("msgContents="+jsonObj.msgContents);
        				//alert("data:"+data);
        				if(null != jsonObj && jsonObj.msgId=="1"){
        					alert(jsonObj.msgContents);
        					//goRetrieve();
        				}else{
        					alert(jsonObj.msgId+"|"+jsonObj.msgContents);
        				}
        			},
        			error: function(xhr,status,error){
        				alert("error:"+error);
        			},
        			complete:function(data){
        				
        			}
        		});//--ajax
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
            }
            document.getElementById("result").innerHTML = msg;
            alert(msg);
        });//--import API
  	});//--결제 API 버튼
  
  	//날짜 적용 버튼
  	$("#dateBtn").on('click',function(){
  		var sno = "<%=sno%>";
  		
  		var checkInDate = $("#checkInDate").val();
  	  	var checkOutDate = $("#checkOutDate").val();
  	  	
  	  	//날짜 유효성 검사
  	  	var checkInDateArr = checkInDate.split("-");
  	  	var checkOutDateArr = checkOutDate.split("-");
  	  	var startDt = checkInDateArr[0] + checkInDateArr[1] + checkInDateArr[2];
  	  	var endDt = checkOutDateArr[0] + checkOutDateArr[1] + checkOutDateArr[2];
  	  	
  	  	if(startDt==""){
  	  		alert("시작 날짜를 선택해주세요.");
  	  		return;
  	  	}else if(endDt==""){
  	  		alert("종료 날짜를 선택해주세요.");
	  		return;
  	  	}if(startDt>=endDt){
  	  		alert("시작 날짜가 종료 날짜보다 같거나 클 수 없습니다.");
  	  		return;
  	  	}
  	  	
  		//ajax
		$.ajax({
		    type:"POST",
		    url:"/MAL_A/roxandrea/payment.do",
		    dataType:"json", 
		    data:{"workDiv":"doRetrievePayPossibleRoom",
		    	  "startDt":startDt,
		    	  "endDt":endDt,
		    	  "sno":sno
		    },
		    success:function(result){ //성공
		    	//날짜변경 버튼 체크 확인
		    	doCheckDate(1);
		    
		    	//배열 개수 만큼 option 추가
		    	$.each(result, function(i){
		    		$("#room").append(result[i]);
		    	});
		    },
		    error:function(xhr,status,error){
				alert("error:"+error);
		    },
		    complete:function(data){
		    
		    }   
	  	});//--ajax
	  	
  	});//--dateBtn
  	
  	//방 셀렉트 박스
  	function roomSelect(room){
  		var checkInDate = $("#checkInDate").val();
  	  	var checkOutDate = $("#checkOutDate").val();
  	  	var rno = $("#room").val();
  	  	var optionText = $("#room option:checked").text();
  	  	
  	  	if(optionText=="날짜와 방을 선택해주세요."){
	  	  	$("#pay").val(0);
	    	$("#finalPay").val(0);
	    	$("#savePoint").val(0);
  	  	}else if(optionText!="날짜와 방을 선택해주세요."){
	  		//ajax
			$.ajax({
			    type:"POST",
			    url:"/MAL_A/roxandrea/payment.do",
			    dataType:"json", 
			    data:{"workDiv":"doSelectOneRoomPrice",
			    	  "checkInDate":checkInDate,
			    	  "checkOutDate":checkOutDate,
			    	  "rno":rno
			    },
			    success:function(result){ //성공
			    	//가격 셋팅
			    	$("#pay").val(inComma(result));
			    	$("#finalPay").val(inComma(result));
			    	$("#savePoint").val(inComma(Math.round(Number(result)*0.05)));
			    },
			    error:function(xhr,status,error){
					alert("error:"+error);
			    },
			    complete:function(data){
			    
			    }   
		  	});//--ajax
		}
  	};//--roomSelect
  	
  	//콤마 찍기
  	function inComma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    }
  	//--콤마 찍기
  	
  	//콤마 풀기
    function unComma(str) {
        str = String(str);
        return str.replace(/[^\d]+/g, '');
    }
  	//--콤마 풀기
  	
  	//포인트 사용 버튼
  	$("#usePointBtn").on('click', function(){
  		var checkDecimal = /^[0-9]*$/;
  		var memPoint = <%=point %>;
  		var usePoint = Number($("#usePoint").val());
  		var pay = Number(unComma($("#pay").val()));
  		var finalPay = Number(unComma($("#finalPay").val()));
  		
  		if(pay==0){
  			alert("날짜와 방을 선택해주세요.");
  		}else if(isNaN(usePoint)){
  			alert('숫자로만 입력해주세요.');
  		}else if(usePoint<0){
  			alert('음수는 입력 할 수 없습니다.');
  		}else if(!checkDecimal.test(usePoint)){
  			alert('소수는 입력 할 수 없습니다.');
  		}else if(usePoint>memPoint){
  			alert('보유포인트보다 많이 사용 할 수 없습니다.');
  		}else if(usePoint>pay){
  			alert('포인트를 결제금액보다 많이 사용할 수 없습니다.');
  		}else{
  			$("#finalPay").val(inComma(pay-usePoint));
  			$("#savePoint").val(inComma(Math.round((pay-usePoint)*0.05)));
  		}
  	});//--usePointBtn
  	
  	//뒤로가기
  	function goBack(){
  		history.go(-1);
  	}
  	
  </script>
</html>
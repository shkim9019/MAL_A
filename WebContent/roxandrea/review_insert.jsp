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
<%@page import="com.mal_a.payment.PaymentVO"%>
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
	PaymentVO paymentVO = (PaymentVO)request.getAttribute("paymentVO");
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
	            		<p class="breadcrumbs mb-2"><span class="mr-2"><a href="index.html">Home</a></span> <span>Blog</span></p>
	            		<h1 class="mb-4 bread">리뷰 작성</h1>
            		</div>
          		</div>
        	</div>
		</div>
	</div>
	
	<section class="ftco-section">
		
		<form name="reviewFrm" action="<%=HR_PATH %>/roxandrea/review.do" method="post">
	    	<input type="hidden" name="workDiv" id="workDiv" value="doInsert" />
	    	<input type="hidden" name="searchDiv"/>
			<div class="container">
				<div class="row justify-content-center mb-5 pb-3">
	          		<div class="col-md-7 heading-section text-center ftco-animate">
	          			<span class="subheading">review_insert</span>
	            		<h2>리뷰 작성</h2>
	            	</div>
	            </div>
			</div>
			
			<!-- 정보 작성란 -->
			<div class="container">    			
				<div class="row justify-content-center mb-5 pb-3">			
					<div class="wrap bg-white align-self-stretch py-3 px-4">			
						<div class="col-md-12 room-single mt-4 mb-5 ftco-animate" align="center">
							<div class="d-md-flex mt-10 mb-10 py-5">
								<table border="1" cellpadding="5" cellspacing="0" width="600">
									<thead>
									</thead>
									<tbody>
										<tr>
											<td bgcolor="#E6FFFF">업체명</td>	
											<td>${paymentVO.sno }</td>
										</tr>
										
										<tr>
											<td bgcolor="#E6FFFF">방이름</td>	
											<td>${paymentVO.rno }</td>
										</tr>
										
										<tr>
											<td bgcolor="#E6FFFF">평점 체크</td>
											<td>
												<input type="radio" value="1" name="radioBtn"/>&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="radio" value="2" name="radioBtn"/>&nbsp;2&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="radio" value="3" name="radioBtn"/>&nbsp;3&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="radio" value="4" name="radioBtn"/>&nbsp;4&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="radio" value="5" name="radioBtn"/>&nbsp;5
											</td>
										</tr>	
										
										<tr>
											<td bgcolor="#E6FFFF">내용</td>
											<td><textarea name="cont"  id="cont" rows="10" cols="60" placeholder="최대 100자로 입력해주세요." maxlength="100" translate="no"></textarea></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- //정보 작성란 -->
			
			<!-- 버튼 -->
			<div class="container">    			
				<div class="row justify-content-center mb-5 pb-3">			
					<div class="wrap bg-white align-self-stretch py-3 px-4">			
						<div class="col-md-30 room-single mt-30 mb-30 ftco-animate">
							<div class="d-md-flex mt-10 mb-10 py-5">
								<input type="button" value="작성완료" onclick="javascript:doInsert();"/>
								<input type="button" value="취소" onclick="javascript:goBack();"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- //버튼 -->
			
			</form>
			
        
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
    
  </body>
  <script type="text/javascript">
  	//회원 마이페이지 결제내역으로 이동
  	function goMemberPaymentList(){
		var frm = document.reviewFrm;
		frm.workDiv.value = "doRetrieve";
		frm.searchDiv.value = "1";
		frm.action = '/MAL_A/roxandrea/payment.do';
		frm.submit();
	}
  	//--회원 마이페이지 결제내역으로 이동
  
  	//리뷰 작성 완료
  	function doInsert(){
  		var pno = "${paymentVO.pno}";
  		var cont = $("#cont").val();
  		var star = $("input[name=radioBtn]:checked").val();
  			
		//유효성 검사  		
  		if(star==undefined){
  			alert("평점을 체크해주세요.");
  			return;
  		}else if(cont==""){
  			alert("내용을 작성해주세요.");
  			return;
  		}
		
  		//ajax
		$.ajax({
		    type:"POST",
		    url:"/MAL_A/roxandrea/review.do",
		    dataType:"html", 
		    data:{"workDiv":"doInsert",
		          "pno": pno,
		          "star": star,
		          "cont": cont
		    },
		    success:function(data){ //성공
				console.log("data="+data);
				//alert("data:"+data);
				var jData = JSON.parse(data);
				//성공
				if(jData!=null && jData.msgId=="1"){
					alert(jData.msgContents);
					goMemberPaymentList();
				}else{
					alert(jData.msgId+"||"+jData.msgContents);
				}
		    },
		    error:function(xhr,status,error){
				alert("error:"+error);
		    },
		    complete:function(data){
		    
		    }   
	  	});//--ajax
  	}
  
  	//뒤로가기
  	function goBack(){
  		history.go(-1);
  	}
  	
  </script>
</html>
<%--
  /**
  * Class Name : 
  * Description : 
  * Modification Information
  *
  *   수정일                   수정자                      수정내용
  *  -------    --------    ---------------------------
  *  2020. 2. 24.            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.01.06
  *
  * Copyright (C) 2009 by KandJang  All right reserved.
  */
--%>
<%@page import="com.mal_a.filemng.FileMngVO"%>
<%@page import="com.mal_a.cmn.SearchVO"%>
<%@page import="com.mal_a.cmn.StringUtil"%>
<%@page import="com.mal_a.stooption.StoOptionVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mal_a.review.ReviewVO"%>
<%@page import="com.mal_a.store.StoreVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/cmn/common.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:url value="/roxandrea/board.do" var="hrUrl">
 <c:param name="workDiv" value="doRetrieve"></c:param>
</c:url>
<c:url value="/roxandrea/member.do" var="logOut">
 <c:param name="workDiv" value="doLogout"></c:param>	
</c:url>
<c:url value="/roxandrea/member.do" var="myPage">
 <c:param name="workDiv" value="doSelectOne"></c:param>
</c:url>
<%
	StoreVO storeVO = (StoreVO)request.getAttribute("storeVO");

	ReviewVO reviewVO = (ReviewVO)request.getAttribute("reviewVO");
	
	List<StoOptionVO> listStoOptionVO = (List<StoOptionVO>)request.getAttribute("listStoOptionVO");
	/*
	for(StoOptionVO vo :listStoOptionVO) {
		out.print(vo+"<br>");
	}
	*/
	
	List<ReviewVO> listReviewVO = (List<ReviewVO>)request.getAttribute("listReviewVO");
	/*
	for(ReviewVO vo :listReviewVO) {
		out.print(vo+"<br>");
	}
	*/
	
	//param
	String searchDiv  = "";//검색구분
	String searchWord = "";//검색어
	String pageNum 	  = "1";//페이지 넘버
	String pageSize   = "10";//페이지 사이즈
	
	SearchVO inVO = (SearchVO)request.getAttribute("paramVO");
	if(inVO!=null){
		LOG.debug("===============");
		LOG.debug("=inVO="+inVO);
		LOG.debug("===============");
		searchDiv = inVO.getSearchDiv();
		searchWord = inVO.getSearchWord();
		pageNum = String.valueOf(inVO.getPageNum());
		pageSize = String.valueOf(inVO.getPageSize());
	}
	
	//paging
	int maxNum			= 0;//총글수
	int currPageNo		= 1;//현재 페이지
	int rowsPerPage		= 10;//page
	
	int bottomCount		= 10;//바닥 page_cnt
	
	String url			= HR_PATH+"/roxandrea/store.do";//호출 URL
	String scriptName 	= "doSearchPage";//JavaScript 함수: doSearchPage(url, no)
	
	if(inVO!=null){
		maxNum = (Integer)request.getAttribute("totalCnt");
		currPageNo 	  = inVO.getPageNum();
		rowsPerPage   = inVO.getPageSize();
		
		LOG.debug("===============");
		LOG.debug("=url="+url);
		LOG.debug("=scriptName="+scriptName);
		LOG.debug("=maxNum="+maxNum);
		LOG.debug("=currPageNo="+currPageNo);
		LOG.debug("=rowsPerPage="+rowsPerPage);
		LOG.debug("===============");
	}
	//--paging
	
	String heartCheck = (String)request.getAttribute("heartCheck");
	//out.print(heartCheck);
	
	List<FileMngVO> outListFileMng = (List<FileMngVO>)request.getAttribute("outListFileMng");
	for(FileMngVO vo :outListFileMng) {
		//out.print(vo+"<br>");
	}
%>
<!DOCTYPE html>
<html>
<!-- 1개의 Store -->
  <head>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=7c798e37b13fac506a55eb2eebfd5a18&libraries=services"></script>
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
	        <span class="oi oi-menu"></span> 메뉴
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
	            <p class="breadcrumbs mb-2"><span>STORE</span></p>
	            <h1 class="mb-4 bread">STORE</h1>
            </div>
          </div>
        </div>
      </div>
    </div>

	<section class="ftco-section">
      <div class="container">
        <div class="row">
        	
          <div class="col-lg-8">
          	<div class="row">
          		<div class="col-md-12 ftco-animate">
          			<div class="single-slider owl-carousel">
          				<c:forEach var="fileMngVO" items="${outListFileMng }" >
	          				<div class="item">
          						<div class="room-img" style="background-image:url(<%=HR_PATH%>${fileMngVO.savePath}${fileMngVO.saveNm});"></div>
	          				</div>
          				</c:forEach>
          			</div>
          		</div>
          		<div class="col-md-12 room-single mt-4 mb-5 ftco-animate">
          			<h2 class="mb-4"><strong>${storeVO.name }</strong><span><strong>&nbsp;&nbsp;평점&nbsp;:&nbsp;${reviewVO.star eq null ? 0 : reviewVO.star }&nbsp;&nbsp;</strong></span>
          				<c:choose>
							<c:when test="${heartCheck eq '1'}">
								<a href="javascript:doHeartDelete();"><img src="/MAL_A/roxandrea/upload/2020/03/heart_like_love_twitter_icon_127132.png" style="width:5%;"></img></a>
							</c:when>
							<c:otherwise>
								<a href="javascript:doHeartInsert();"><img src="/MAL_A/roxandrea/upload/2020/03/1487717002-heart_81641.png" style="width:5%;"></img></a>
							</c:otherwise>
						</c:choose>
          			</h2>
					<p>${storeVO.cont }</p><br/><br/><br/><br/><br/><br/>
	    			<!-- 옵션 -->
 					<div class="d-md-flex mt-5 mb-5">
						<span><strong>OPTION</strong></span>
 					</div>
 					<div class="d-md-flex mt-5 mb-5">
 						<table>
	 						<thead></thead>
	 						<tbody>
		 						<c:choose>
									<c:when test="${null!=listStoOptionVO && listStoOptionVO.size()>0 }">
										<c:forEach var="vo" items="${listStoOptionVO }" >
											<tr>
												<td><li><c:out value="${vo.opt }" />&nbsp;&nbsp;</li></td>
											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="99">No data found</td>
										</tr>
									</c:otherwise>
								</c:choose>
							</tbody>
						</table>
					</div><br/><br/><br/><br/><br/><br/>
					<!-- //옵션 -->
          		
          			<!-- 주소 -->
						<div class="d-md-flex mt-5 mb-5">
							<span><strong>오시는 길</strong></span>
	 					</div>
						<li>${storeVO.addr }</li>
						<li>tel&nbsp;:&nbsp;${storeVO.tel }</li>
						<li>우편번호&nbsp;:&nbsp;${storeVO.addrNo }</li>
		          		<!-- 지도 API -->
		          		<div class="col-md-12 room-single mt-4 mb-5 ftco-animate">
		          			<div id="kakaoMap" style="width:100%;height:350px;"></div>
		          		</div>
		          		<!-- //지도 API -->
	          		<!-- 주소 -->
          		
          		
          		
          		
				</div>
          	</div>
          </div> <!-- .col-md-8 -->
          
          
          
          
          <!-- 사이드바-->
          <div class="col-lg-4 sidebar ftco-animate">
            
             <!-- 카테고리 -->
            <form action="/MAL_A_PRA/room/room.do" name="storeFrm" id="storeFrm" method="post">
            	<input type="hidden" name="workDiv" />
            	<input type="hidden" name="autho" />
            	<input type="hidden" name="searchDiv" />
            	<input type="hidden" name="searchWord" />
            	<input type="hidden" name="searchWord02" />
            	<input type="hidden" name="sno" />
            	<input type="hidden" name="regId" />
	            <div class="sidebar-box ftco-animate">
	              <div class="categories">
	                <h3>Categories</h3>
	                <li><a href="javascript:goStoreSelectOne();">업체 </a></li>
	                <li><a href="javascript:goRoomList();">방</a></li>
	                <li><a href="javascript:goLandmark();">관광명소 </a></li>
	                <li><a href="javascript:goPaymentInsert();">실시간예약</a></li>
	              </div>
	            </div>
	        </form>
            <!-- //카테고리 -->
            
            <!-- 리뷰 -->
			<form action="/MAL_A/roxandrea/store.do" name="searchFrm" id="searchFrm" method="post">
				<input type="hidden" name="workDiv" />
				<div class="sidebar-box ftco-animate">
	                <h3>Reviews</h3>
	                <table id="listTable">
						<thead>
	                	</thead>
						<tbody>
							<c:choose>
								<c:when test="${null!=listReviewVO && listReviewVO.size()>0 }">
									<c:forEach var="vo" items="${listReviewVO }" >
										<div class="text p-4 p-xl-5">
											<input type="hidden" value="${vo.reno }"/>
											<p class="mb-0"><span class="per">No: <c:out value="${vo.num }" /></span></p>
											<p class="mb-0"><span class="per">아이디: <c:out value="${vo.regId }" /></span></p>
											<p class="mb-0"><span class="per">등록일: <c:out value="${vo.regDt }" /></span></p>
											<p class="mb-0"><span class="per">평점: <c:out value="${vo.star }" /></span></p>
											<p class="mb-0"><span class="per">후기: <c:out value="${vo.cont }" /></span></p>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="99">No data found</td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					
					<!-- 페이징 -->	
					<div>
						<%=StringUtil.renderPaging(maxNum, currPageNo, rowsPerPage, bottomCount, url, scriptName) %>
					</div>
					<!-- //페이징 -->
	            </div>
		  	</form>
		  	<!-- //리뷰 -->
          </div>
          <!-- //사이드바 -->
          
        </div>
      </div>
    </section> <!-- .section -->

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
  	//좋아요 추가
	function doHeartInsert(){
  		var sno = "${storeVO.sno}";
		
		//ajax
		$.ajax({
		    type:"POST",
		    url:"/MAL_A/roxandrea/heart.do",
		    dataType:"html", 
		    data:{"workDiv":"doInsert",
		          "sno": sno
		    },
		    success:function(data){ //성공
				console.log("data="+data);
				//alert("data:"+data);
				var jData = JSON.parse(data);
				//성공
				if(jData!=null && jData.msgId=="1"){
					alert(jData.msgContents);
					goStoreSelectOne();
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
  	
  	//좋아요 삭제
  	function doHeartDelete(){
  		var sno = "${storeVO.sno}";
		
		//ajax
		$.ajax({
		    type:"POST",
		    url:"/MAL_A/roxandrea/heart.do",
		    dataType:"html", 
		    data:{"workDiv":"doDelete",
		          "sno": sno
		    },
		    success:function(data){ //성공
				console.log("data="+data);
				//alert("data:"+data);
				var jData = JSON.parse(data);
				//성공
				if(jData!=null && jData.msgId=="1"){
					alert(jData.msgContents);
					goStoreSelectOne();
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
  	
  	//결제페이지 이동
  	function goPaymentInsert(){
  		var frm = document.storeFrm;
		frm.sno.value = "${storeVO.sno}";
		frm.workDiv.value = "goPaymentInsert";
		frm.action = '/MAL_A/roxandrea/payment.do';
		frm.submit();
  	}
  
	//새로고침
	function goStoreSelectOne(){
		history.go(0);
	}
  
	//페이징
  	function doSearchPage(url, no){
		//console.log("url:"+url);
		//console.log("no:"+no);
		var frm = document.searchFrm;
		frm.workDiv.value = "doRetrieveAdmin";
		frm.pageNum.value = no;
		frm.action = url;
		frm.submit();
	}
  
  	//방목록 이동
	function goRoomList(){
		//alert('doRetrieve');
		var frm = document.storeFrm;
		frm.workDiv.value = "doRetrieve";
		frm.autho.value = "1";
		frm.searchDiv.value = "1";
		frm.searchWord.value = '${storeVO.sno}';
		frm.action = '/MAL_A/roxandrea/room.do';
		frm.submit();
	}
	
    //관광명소 이동
    function goLandmark(){
       var sno="${storeVO.sno}";
       //회원 
       var frm = document.storeFrm;
       frm.workDiv.value = "doRetrieveMember";
       frm.searchDiv.value = "1";
       frm.searchWord.value=sno;
       frm.sno.value=sno;
       frm.searchWord02.value ="1"; //카테고리
       frm.action = '/MAL_A/roxandrea/landmark.do';
       frm.submit();  
  }
  	
	//지도 API
	var mapContainer = document.getElementById('kakaoMap'), // 지도를 표시할 div 
	mapOption = {
		center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		level: 3 // 지도의 확대 레벨
	};  

	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('${storeVO.addr}', function(result, status) {

	  	// 정상적으로 검색이 완료됐으면 
	  	if (status === kakao.maps.services.Status.OK) {
	
			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	      	// 결과값으로 받은 위치를 마커로 표시합니다
	      	var marker = new kakao.maps.Marker({
				map: map,
	          	position: coords
	      	});
	
			// 인포윈도우로 장소에 대한 설명을 표시합니다
			var infowindow = new kakao.maps.InfoWindow({
			content: '<div style="width:150px;text-align:center;padding:6px 0;">${storeVO.name }</div>'
	      	});
	      	infowindow.open(map, marker);
	
	      	// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	      	map.setCenter(coords);
	  	} 
	});
	//--지도 API
	
  </script>
</html>
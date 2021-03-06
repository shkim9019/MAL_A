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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/cmn/common.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:url value="/roxandrea/board.do" var="hrUrl">
 <c:param name="workDiv" value="doAdminRetrieve"></c:param>
</c:url>

<c:url value="/roxandrea/member.do" var="myPage">
 <c:param name="workDiv" value="doSelectOne"></c:param>
</c:url>

<c:url value="/roxandrea/member.do" var="logOut">
 <c:param name="workDiv" value="doLogout"></c:param>	
</c:url>
<%@page import="com.mal_a.cmn.StringUtil"%>
<%@page import="com.mal_a.code.CodeVO"%>
<%@page import="com.mal_a.cmn.SearchVO"%>
<%@page import="com.mal_a.store.StoreVO"%>
<%@page import="java.util.List"%>
<% 	
//param
	String pageNum    ="1";//페이지 넘버
	String searchDiv  = "";//검색구분
	String searchWord ="";//검색어
	String pageSize   ="10";//페이지 사이즈
	
	
	System.out.println((String)request.getAttribute("selectBox"));
	

	SearchVO inVO= (SearchVO)request.getAttribute("paramVO");
	if(null !=inVO){
		LOG.debug("===========");
		LOG.debug("=inVO="+inVO);
		LOG.debug("===========");
		pageNum    = String.valueOf(inVO.getPageNum());
		searchDiv  = inVO.getSearchDiv();
		searchWord = inVO.getSearchWord();
		pageSize   = String.valueOf(inVO.getPageSize());
	}
 		
	StoreVO storeVO = (StoreVO)request.getAttribute("storeVO");

 	List<StoreVO> storeList = (List<StoreVO>)request.getAttribute("storeList");
 	
%>
<!DOCTYPE html>
<html lang="ko">
<!-- OPTION 에 따른 업체들 나열식필요 -->
  <head>
  <script src="https://code.jquery.com/jquery-2.2.4.js"></script>
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
	      <a class="navbar-brand" href="/MAL_A/roxandrea/admin_main.jsp">숙박의민족</a>
	      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="oi oi-menu"></span> 메뉴
	      </button>

	       <div class="collapse navbar-collapse" id="ftco-nav">
	        <ul class="navbar-nav ml-auto">
	        <li class="nav-item"><a href="/MAL_A/roxandrea/admin_store_search.jsp" class="nav-link">업체검색</a></li>
	        <li class="nav-item"><a href="javascript:goStoreListAll();" class="nav-link">업체관리</a></li>
	        <li class="nav-item"><a href="javascript:goLandmarkListAll()" class="nav-link">관광명소관리</a></li>
	        <li class="nav-item"><a href="${hrUrl}" class="nav-link">자유게시판관리</a></li>
	        <li class="nav-item"><a href="javascript:goMemberListAll();" class="nav-link">회원관리</a></li>
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
	            <h1 class="mb-4 bread">STORE LIST</h1>
            </div>
          </div>
        </div>
      </div>
    </div>



    <section class="ftco-section bg-light ftco-no-pb">
    	<div class="container-fluid px-0">
        
        	<form name="searchFrm" action="<%=HR_PATH %>/roxandrea/store.do" method="post">
    				<input type="hidden" name="workDiv" />
    				<input type="hidden" name="autho" />
					<input type="hidden" name="pageNum" />
					<input type="hidden" name="sno" />
					<input type="hidden" name="searchDiv" />
					<input type="hidden" name="searchWord" />
					<input type="hidden" name="checkIn" value="${checkIn}"/>
					<input type="hidden" name="checkOut" value="${checkOut}"/>
					<input type="hidden" name="selectBox" value="${selectBox}"/>
					<input type="hidden" name="options" value="${options}"/>
					
		</form>    		
    		
    		
    		
    		<div class="row no-gutters">
    		
    			<!-- 리스트 for문 -->
    			<c:forEach var="list" items="${storeList}" >
	    				<div class="col-lg-6">
		    				<div class="room-wrap d-md-flex">
		    					<a href="javascript:goStoreSelectOne('${list.sno}');" class="img" style="background-image: url(<%=HR_PATH %>${list.fileId});"></a>
		    					<div class="half left-arrow d-flex align-items-center">
		    						<div class="text p-4 p-xl-5 text-center">
		    							<span class="Review-Star"></span>
		    							<p class="mb-0"><span class="price mr-1">${list.name}</span></p>
		    							<p class="mb-0"><span class="price mr-1">${list.addr}</span></p>
		    							<p class="mb-0"><span class="per">${list.tel}</span></p>
			    						<p class="pt-1"><a href="javascript:goStoreSelectOne('${list.sno}');" class="btn-custom px-3 py-2">상세히 <span class="icon-long-arrow-right"></span></a></p>
		    						</div>
		    					</div>
		    				</div>
		    			</div>
	    			
    			</c:forEach>
    			<!-- 리스트 for문 -->
    			
    		</div>
    	</div>
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
  <script src="js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="js/google-map.js"></script>
  <script src="js/main.js"></script>
  <script type="text/javascript">
    
    
  	//업체페이지 이동
  	function goStoreSelectOne(sno){
		var frm = document.searchFrm;
		frm.workDiv.value = "doSelectOne";
		frm.autho.value = "3";
		frm.sno.value = sno;
		frm.searchDiv.value = "1";
		frm.searchWord.value = sno;
		frm.action = '/MAL_A/roxandrea/store.do';
		frm.submit();
	}

  	function doRetrieve(){
		//alert('doRetrieve');
		var frm = document.searchFrm;
		frm.workDiv.value = "doRetrieve";
		frm.action = '/roxandrea/store.do';
		frm.submit();
	}
  	
  //회원관리
	function goMemberListAll(){
		window.location.href='/MAL_A/roxandrea/member.do?workDiv=doRetrieveAdmin';
	}
	
	//업체관리
	function goStoreListAll(){
		window.location.href='/MAL_A/roxandrea/store.do?workDiv=doRetrieveAdmin';
	}
	
   //관광명소 관리
   function goLandmarkListAll(){
      window.location.href='/MAL_A/roxandrea/landmark.do?workDiv=doRetrieveAdmin';
   }
  	
  </script>  
    
  </body>
</html>
<%--
  /**
  * Class Name : 
  * Description : 
  * Modification Information
  *
  *   수정일                   수정자                      수정내용
  *  -------    --------    ------------------
  *  2020. 3. 9.       WH           최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.01.06
  *
  * Copyright (C) 2009 by KandJang  All right reserved.
  */
--%>
<%@page import="com.mal_a.cmn.StringUtil"%>
<%@page import="com.mal_a.code.CodeVO"%>
<%@page import="com.mal_a.cmn.SearchVO"%>     
<%@page import="com.mal_a.board.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    errorPage="/cmn/error.jsp"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ include file="/cmn/common.jsp" %>
<%
    //param
    String pageNum    ="1";//페이지 넘버
    String searchDiv  = "";//검색구분
    String searchWord ="";//검색어
    String pageSize   ="10";//페이지 사이즈

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
    
    //code
    List<CodeVO> searchList = (List<CodeVO>)request.getAttribute("searchList");
    /*
    for(CodeVO vo :searchList) {
        //out.print(vo+"<br>");
    }
    */
    
    List<CodeVO> pageSizeList = (List<CodeVO>)request.getAttribute("pageSizeList");
    /*
    for(CodeVO vo :pageSizeList) {
        out.print(vo+"<br>");
    }
    */
    
    
    
    List<BoardVO> list = (List<BoardVO>)request.getAttribute("list");
    //paging
    int maxNum     = 0;//총글수 
    int currPageNo = 1;//현재 페이지 
    int rowsPerPage= 10;// pageSize 
    
    int bottomCount= 10;// 바닥 page_cnt
    
    String url = HR_PATH+"/roxandrea/board.do";//호출 URL 
    String scriptName = "doSearchPage";//JavaScript함수: doSearchPage(url,no)
    if(null !=inVO){
        maxNum     = (Integer)request.getAttribute("totalCnt");
        currPageNo = inVO.getPageNum();
        rowsPerPage= inVO.getPageSize();
        
        LOG.debug("=======================");
        LOG.debug("url="+url);
        LOG.debug("scriptName="+scriptName);
        LOG.debug("maxNum="+maxNum);
        LOG.debug("currPageNo="+currPageNo);
        LOG.debug("rowsPerPage="+rowsPerPage);
        LOG.debug("=======================");
    }
    
    
    //--paging


%> 
<c:url value="/roxandrea/member.do" var="myPage">
 <c:param name="workDiv" value="doSelectOne"></c:param>
</c:url>

<c:url value="/roxandrea/board.do" var="hrUrl">
 <c:param name="workDiv" value="doAdminRetrieve"></c:param>
</c:url>

<c:url value="/roxandrea/member.do" var="logOut">
 <c:param name="workDiv" value="doLogout"></c:param>    
</c:url>

      
<!DOCTYPE html>
<html lang="en">
  <head>
  <script  src="https://code.jquery.com/jquery-2.2.4.js"></script>
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
          <a class="navbar-brand" href="admin_main.jsp">숙박의민족</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="oi oi-menu"></span> Menu
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
                <p class="breadcrumbs mb-2"> <span>BOARD</span></p>
                <h1 class="mb-4 bread">BOARD LIST</h1>
            </div>
          </div>
        </div>
      </div>
    </div>

 <section class="ftco-section ftco-menu" >
   <div class="container">
     <div class="row justify-content-center mb-5 pb-3">
        <div class="page-header">   
            <h2></h2>
        </div>
        <!--// div title -->
        <!--//Button  -->
        <!-- 검색영역 -->
        <div class="row">
            <div class="col-md-12 text-right">      
            <form class="form-inline" action="/MAL_A/roxandrea/board.do" name="searchFrm" id="searchFrm" 
                  method="get">
                <input type="hidden" name="workDiv"   />
                <input type="hidden" name="pageNum"   />  
                <input type="hidden" name="seq"   />
                <input type="hidden" name="regId"   />
                
                <div class="form-group">                        
                    <select class="form-control input-sm" name="pageSize" id="pageSize" >
                        <c:forEach var="code" items="${pageSizeList}" >
                            <option value="<c:out value="${code.dtlId }" />" 
                                <c:if test="${paramVO.pageSize == code.dtlId }">selected="selected"</c:if>>
                                <c:out value="${code.dtlNm }" />
                            </option>
                        </c:forEach>
                    </select>
                    <%=StringUtil.makeSelectBox(searchList, "searchDiv", searchDiv, true) %> 
                    <input class="form-control input-sm" type="text" name="searchWord" id="searchWord" placeholder="검색어입력"  value="<%=searchWord%>" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
                    <input  type="button" class="btn btn-default btn-sm" value="조회" onclick="javascript:doRetrieve();" id="toListBtn" />
                    <input  type="button" class="btn btn-default btn-sm" value="글쓰기" onclick="javascript:moveToSave();" id="insertBtn" />                       
                 </div> 
                </form>
              </div>
            </div>
            <!--// 검색 -->
            
        <!-- Grid영역 -->
        <div class="table-responsive">          
            <table id="listTable" class="table table-hover">
                <thead>
                    <tr>
                        <th  class="text-center  ">NO</th>
                        <th  class="text-center  ">제목</th>
                        <th  class="text-center  ">등록자ID</th>
                        <th  class="text-center  ">등록일</th>
                        <th  class="text-center  ">조회수</th>
                        <th style="display:none;">SEQ</th>
                        <th  class="text-center  ">정지상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${list.size()>0 }">
                            <c:forEach var="vo"   items="${list}" >
                                <tr>
                                    <td  class="text-center  hidden-sm hidden-xs "><c:out value="${vo.num }"></c:out></td>
                                    <td title="${vo.title }" class="text-left">
                                        ${fn:substring(vo.title,0,13)}
                                        <c:if test="${fn:length(vo.title) > 18 }">...</c:if>
                                    </td>
                                    <td  class="text-center  hidden-sm hidden-xs "><c:out value="${vo.regId }"></c:out></td>
                                    <td  class="text-center  hidden-sm hidden-xs "><c:out value="${vo.regDt }"></c:out></td>
                                    <td class="text-center  hidden-sm hidden-xs "><c:out value="${vo.cnt }"></c:out></td>
                                    <td style="display:none;"><c:out value="${vo.bno }"></c:out></td>
                                    <td class="text-center  hidden-sm hidden-xs "><c:out value="${vo.views }"></c:out></td>
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
        </div>  
        <!-- paging -->
            <div>
                <%=StringUtil.renderPaging(maxNum, currPageNo, rowsPerPage, bottomCount, url, scriptName)%>
            </div>
        <!--// paging -->            
             
             
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
  <!-- // <script src="js/jquery.timepicker.min.js"></script> -->
  <script src="js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="js/google-map.js"></script>
  <script src="js/main.js"></script>
  
    <script type="text/javascript">
    
    
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
    
    
    
    
        function doSearchPage(url,no){
              var frm = document.searchFrm;
              frm.workDiv.value = "doAdminRetrieve";
              frm.pageNum.value = no;
              frm.action =url;
              frm.submit();
            
        }
        
    
        //listTable자식:dbclick(double click)
        $("#listTable>tbody").on("dblclick","tr",function(event){
            var pTR = $(this);//tr
            var pTRChildren = pTR.children();
            var seq = pTRChildren.eq(5).text();
            var regId = pTRChildren.eq(2).text();
            console.log("seq:"+seq);
            console.log("regId:"+regId);
            var frm = document.searchFrm;
            
            frm.workDiv.value = "doAdminSelectOne";
            frm.seq.value = seq;
            frm.regId.value = regId;
            frm.action = '/MAL_A/roxandrea/board.do';
            frm.submit();
            
        });
    
    
        function doRetrieve(){
            var frm = document.searchFrm;
            event.preventDefault();
            frm.workDiv.value = "doAdminRetrieve";
            frm.pageNum.value = "1";
            frm.action = '/MAL_A/roxandrea/board.do';
            frm.submit();
        }
    
        function moveToSave(){
            if(false==confirm('등록 화면으로 이동 하시겠습니까?'))return;
            var frm = document.searchFrm;
            frm.workDiv.value = "moveToAdminSave";
            frm.action = '/MAL_A/roxandrea/board.do';
            frm.submit();
        }
        
        $("#searchWord").keypress(function(e){
            //console.log('#searchWord');
            //alert('#searchWord');
            //Enter Keycode 13
            if(e.which ==13){
                doRetrieve();
            }
            
        });
        
        
    </script>  
  
  
  
  
    
  </body>
</html>
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
<%@page import="java.util.List"%>
<%@page import="com.mal_a.cmn.SearchVO"%>
<%@page import="com.mal_a.landmark.LandmarkVO"%>
<%@page import="com.mal_a.landmark.LandmarkCont"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/cmn/common.jsp" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:url value="/roxandrea/member.do" var="logOut">
 <c:param name="workDiv" value="doLogout"></c:param>   
</c:url>

<c:url value="/roxandrea/member.do" var="myPage">
 <c:param name="workDiv" value="doSelectOne"></c:param>
</c:url>

<c:url value="/roxandrea/board.do" var="hrUrl">
 <c:param name="workDiv" value="doAdminRetrieve"></c:param>
</c:url>
<%
   List<FileMngVO> outListFileMng = (List<FileMngVO>)request.getAttribute("outListFileMng");
   //for(FileMngVO fvo :outListFileMng) {
      //out.print(fvo+"<br>");
   //}
   LandmarkVO outLandMarkVO = (LandmarkVO)request.getAttribute("outLandMarkVO");
   //out.print(outLandMarkVO+"<br>");
%>
<!DOCTYPE html>
<html>
  <head>
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
                <p class="breadcrumbs mb-2"><span class="mr-2">LANDMARK</a></span>
               <h2 class="mb-4 bread">LANDMARK UPDATE</h2>
            </div>
          </div>
        </div>
      </div>
    </div>
   <section class="ftco-section">
      <div class="container">
             <div class="row">
                <div class="col-md-10 room-single mb-5" align="center">
                     <div class="mt-5" align="center">
                  <form name="form"  id= "form" action=/MAL_A/roxandrea/landmark.do" method="post">
                      <input type="hidden" name="workDiv" value="doSelectOne" id="workDiv" />
                      <input type="hidden" name="searchDiv" value="" id="searchDiv"/>
                      <input type="hidden" name="lno" value="${outLandMarkVO.lno}" id="lno" />
                     <div id="list"></div>
                     <div id="callBackDiv">
                        <table border="1" cellpadding="5" cellspacing="0" width="700">
                           <tr>
                              <td bgcolor="#E6FFFF">이름</td>   
                              <td><input type="text" name="name" id="name" value="${outLandMarkVO.name}" size="50"  maxlength="30"/></td>
                           </tr>
                           
                           <tr>
                              <td bgcolor="#E6FFFF">우편번호</td>   
                              <td><input type="text"  size="50" id="zipNo"  name="zipNo" value="${outLandMarkVO.addrNo}" />
                                 <input type="button" value="우편번호 찾기" onclick="goPopup();"/></td>
                           </tr>
                           <tr>
                              <td bgcolor="#E6FFFF">주소</td>   
                              <td><input type="text"  size="50" id="roadFullAddr"  name="roadFullAddr" value="${outLandMarkVO.addr}" /></td>
                           </tr>
                           
                           <tr>
                              <td bgcolor="#E6FFFF">전화번호</td>
                              <td ><input type="text" name="tel"  id="tel" size="50" value="${outLandMarkVO.tel}"/></td>
                           </tr>   
                           
                           <tr>
                              <td bgcolor="#E6FFFF">상세설명</td>
                              <td ><input type="text" name="cont"  id="cont" size="50" value="${outLandMarkVO.cont}"/></td>
                           </tr>
                           <tr>
                              <td bgcolor="#E6FFFF">카테고리</td>
                              <td>
                                    <select name="category" id="category" >
                                       <optgroup label="카테고리">
                                          <option value="1">주변관광지</option>
                                          <option value="2">축제</option>
                                          <option value="3">즐길거리</option>
                                          <option value="4">맛집</option>   
                                       </optgroup>            
                                    </select>
                               </td>
                           </tr>
                         </table>
                     </div>
                  </form>
               </div>
                
                <!-- 파일 첨부 -->
            <div class="mt-5" align="center">
               <form action="<%=HR_PATH %>/roxandrea/room.do" method="post" name="fileFrm" id="fileFrm">
                  <input type="hidden" name="fileId" id="fileId" value="${roomVO.fileId }">
                  <table>
                     <tbody>
                        <tr>
                           <td><h1>사진 첨부</h1></td>
                           <td><input type="button" onclick="javascript:centerPopup(document.fileFrm);" value="파일첨부" ></td>
                           <td><input type="button" onclick="javascript:doUploadCancle(document.fileFrm);" value="파일삭제" ></td>
                        </tr>
                     </tbody>
                  </table>
                  <table border="1" cellpadding="5" cellspacing="0" width="600">
                     <thead>
                        <tr>
                           <th>체크</th>
                           <th>파일명</th>
                        </tr>
                     </thead>
                     <tbody id="uploadTbody">
                        <c:choose>
                           <c:when test="${null!=outListFileMng && outListFileMng.size()>0 }">
                              <c:forEach var="fileMngVO" items="${outListFileMng }" >
                                 <tr>
                                    <td><input type="checkbox" name="fileCheck"></td>
                                    <td><input type="text" name="orgNm" id="orgNm" value="${fileMngVO.orgNm }"><br/></td>
                                    <td style="display:none;"><input type="hidden" name="saveNm" id="saveNm" value="${fileMngVO.saveNm }"><br/></td>
                                    <td style="display:none;"><input type="hidden" name="savePath" id="savePath" value="${fileMngVO.savePath }"><br/></td>
                                    <td style="display:none;"><input type="hidden" name="fileSize" id="fileSize" value="${fileMngVO.fileSize }"><br/></td>
                                    <td style="display:none;"><input type="hidden" name="ext" id="ext" value="${fileMngVO.ext }"><br/></td>
                                 </tr>
                              </c:forEach>
                           </c:when>
                        </c:choose>
                     </tbody>
                  </table>
               </form>
            </div>
            <!-- //파일 첨부 -->
                
             <div  class="tagcloud" align="center">
                 <form action="/MAL_A/roxandrea/landmark.do" name="lndFrm" id="lndFrm" method="post" >
                  <input type="hidden" name="workDiv" />
                  <input type="hidden" name="searchDiv" />
                  <input type="hidden" name="searchWord01" />
                  <input type="hidden" name="searchWord02" />
                   <div align="right">
                  <a href="#" class="tag-cloud-link" id="updateBtn">수정</a>
                      <a href="javascript:goRetrieve" class="tag-cloud-link" id="landmarkListBtn">목록</a>
                  </div>
               </form>
             </div>
           </div>
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
  <script type="text/javascript">
  
//첨부파일 선택 취소
   function doUploadCancle(frm){
      //alert('asd');
      
      //name을 가지는 checkbox 항목의 전체 개수
      var checkCnt = $("input:checkbox[name='fileCheck']").length;
      //alert(checkCnt);

      //name을 가지는 checkbox 중 체크표시된 항목의 전체 개수
      var checkOnCnt = $("input:checkbox[name='fileCheck']:checked").length;
      //alert(checkOnCnt);
      
      if(checkOnCnt==0){
         alert("삭제할 첨부파일이 없습니다.");
         return;
      }
    
      //현재 체크된 체크박스의 tr삭제
      $("input:checkbox[name='fileCheck']").each(function() {
         if(this.checked){
            var tr = $(this).parent().parent();
            tr.remove().end(); // 삭제하기
         }
      });
   }
   //--파일 선택 취소

   //첨부파일 팝업 콜백
   function setChildValue(fileId, orgNm, saveNm, savePath, fileSize, ext){
        //alert("child:"+name);
        var frm = document.fileFrm;
        
        //name을 가지는 checkbox 항목의 전체 개수
      var checkCnt = $("input:checkbox[name='fileCheck']").length;
      //alert(checkCnt);
      
      var txtFileId = $("#fileId").val();
      //alert(txtFileId);
      
      if(txtFileId.length==0 || txtFileId==""){
         $("#fileId").val(fileId);
           $("#uploadTbody").append(
            "<tr>"
            + "<td><input type='checkbox' name='fileCheck'></td>"
            + "<td><input type='text' name='orgNm' id='orgNm' value="+orgNm+"><br/></td>"
            + "<input type='hidden' name='saveNm' id='saveNm' value="+saveNm+"><br/>"
            + "<input type='hidden' name='savePath' id='savePath' value="+savePath+"><br/>"
            + "<input type='hidden' name='fileSize' id='fileSize' value="+fileSize+"><br/>"
            + "<input type='hidden' name='ext' id='ext' value="+ext+"><br/></td>"
            + "</tr>"
         );
        }else{
           //alert('asd');
           $("#uploadTbody").append(
            "<tr>"
            + "<td><input type='checkbox' name='fileCheck'></td>"
            + "<td><input type='text' name='orgNm' id='orgNm' value="+orgNm+"><br/></td>"
            + "<input type='hidden' name='saveNm' id='saveNm' value="+saveNm+"><br/>"
            + "<input type='hidden' name='savePath' id='savePath' value="+savePath+"><br/>"
            + "<input type='hidden' name='fileSize' id='fileSize' value="+fileSize+"><br/>"
            + "<input type='hidden' name='ext' id='ext' value="+ext+"><br/>"
            + "</tr>"
         );
        }
   }
   //--첨부파일 팝업 콜백

   //첨부파일 팝업 출력
   function centerPopup(frm){
      console.log('openPopup');
      /*
      window.open 옵션
      no:0
      yes:1
      width : 팝업창 가로길이
      height : 팝업창 세로길이
      toolbar=no : 단축도구창(툴바) 표시안함
      menubar=no : 메뉴창(메뉴바) 표시안함
      location=no : 주소창 표시안함
      scrollbars=no : 스크롤바 표시안함
      status=no : 아래 상태바창 표시안함
      resizable=no : 창변형 하지않음
      fullscreen=no : 전체화면 하지않음
      channelmode=yes : F11 키 기능이랑 같음
      left=0 : 왼쪽에 창을 고정(ex. left=30 이런식으로 조절)
      top=0 : 위쪽에 창을 고정(ex. top=100 이런식으로 조절)
      */
      var title ="팝업(제목)";
      var xWidth =window.screen.width/2;
      var xHeight =window.screen.height/2;
      console.log('xWidth:'+xWidth);
      console.log('xHeight:'+xHeight);
      
      var pX =xWidth - 240/2;
      var pY =xHeight - 240/2;
      console.log('pX:'+pX);
      console.log('pY:'+pY);         
      
      var status  ="toolbar=0,scrollbars=no,resizable=0,status=yes,width=240,height=200,left="+pX+',top='+pY;
      window.open("",title,status);
      
      frm.target = title;
      frm.method = "get";
      frm.action = "<c:url value='/roxandrea/file_mng_pop_up.jsp'/>";
      frm.submit();
   }
   //--첨부파일 팝업 출력
  
   //위에서 아래로 해석(인터프리터 방식)
    function goPopup(){

      var pop = window.open("juso_api_pop_up.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
   }
    
   function jusoCallBack(roadFullAddr,zipNo){
       // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
       document.form.roadFullAddr.value = roadFullAddr;
       document.form.zipNo.value = zipNo;
      
   }
   //목록버튼
     $("#landmarkListBtn").on('click',function(){
       console.log("#landmarkListBtn");
      goRetrieve();
   });
   
   //수정버튼
     $("#updateBtn").on('click',function(){
      //var workDiv = $("#workDiv").val();
      //if(workDiv == null || workDiv.trim().length==0){
      //      alert("작업구분을 확인 하세요.");
      //      return;
      //}
      
      var name  = $("#name").val();
      if(name == null || name.trim().length==0){
         $("#name").focus();//focus
         alert("이름을 확인 하세요.");
         return;
      }      
      
      var zipNo  = $("#zipNo").val();
      if(zipNo == null || zipNo.trim().length==0){
         $("#zipNo").focus();
         alert("우편번호를 확인 하세요.");
         return;
      }
      
      var roadFullAddr  = $("#roadFullAddr").val();
      if(roadFullAddr == null || roadFullAddr.trim().length==0){
         $("#roadFullAddr").focus();
         alert("주소를 확인 하세요.");
         return;
      }
      
      var tel = $("#tel").val();
      
      var cont = $("#cont").val();
      if(cont== null || cont.trim().length==0){
         $("#cont").focus();//focus
         alert("상세내용을 입력 하세요.");
         return;
      }
      
      var category = $("#category").val();
      if(category== null || category.trim().length==0){
         $("#category").focus();//focus
         alert("카테고리를 입력 하세요.");
         return;
      }
      
       //첨부파일 객체 생성
       var fileId = $("#fileId").val();
       var filePart = "2";//첨부파일 페이지 분류
      
      //첨부파일 배열 객체 생성
      var orgNm = [];//첨부파일 원본명
      var saveNm = [];//첨부파일 저장명
      var savePath = [];//첨부파일 저장명
      var fileSize = [];//첨부파일 사이즈
      var ext = [];//첨부파일 확장자
      
      //첨부파일 배열 수 만큼 for문 돌려서 배열에 담기
      var size = $("input[name='orgNm']").length;
      for(i=0;i<size;i++){
         orgNm.push($("input[name='orgNm']").eq(i).val());
         saveNm.push($("input[name='saveNm']").eq(i).val());
         savePath.push($("input[name='savePath']").eq(i).val());
         fileSize.push($("input[name='fileSize']").eq(i).val());
         ext.push($("input[name='ext']").eq(i).val());
      }
      
      if(confirm(name+'을(를)\n수정하시겠습니까?')==false) return;
      
        //ajax
      $.ajax({
          type:"POST",
          url:"/MAL_A/roxandrea/landmark.do",
          dataType:"html", 
          traditional: true,
          data:{"workDiv":"doUpdate",
               "lno":$("#lno").val(),
                "name":$("#name").val(),
                "zipNo":$("#zipNo").val(),
                "roadFullAddr":$("#roadFullAddr").val(),
                "tel":$("#tel").val(),
                "cont": $("#cont").val(),
                "category": $("#category").val(),
                "fileId": fileId,
            	"orgNm": orgNm,
           		"saveNm": saveNm,
            	"savePath": savePath,
            	"fileSize": fileSize,
            	"ext": ext,
            	"filePart": filePart
          },
          success:function(data){ //성공
              var jsonObj = JSON.parse(data);
               if(jsonObj != null && jsonObj.msgId=="1"){
                  alert(jsonObj.msgContents);
                  goRetrieve();
                  
               }else{
                 alert(jsonObj.msgId+"|"+jsonObj.msgContents);
               }
               
          },
          error:function(xhr,status,error){
           alert("error:"+error);
          },
          complete:function(data){
          }   
      
      });//--ajax
            
   });//--#insert_btn   
   
   
   $(document).ready(function(){

   
   });

   //목록호출
   function goRetrieve(){
      window.location.href='/MAL_A/roxandrea/landmark.do?workDiv=doRetrieveAdmin&searchDiv=4';
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
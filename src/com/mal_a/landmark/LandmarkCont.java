package com.mal_a.landmark;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mal_a.cmn.StringUtil;
import com.google.gson.Gson;
import com.mal_a.code.CodeVO;
import com.mal_a.filemng.FileMngService;
import com.mal_a.filemng.FileMngVO;
import com.mal_a.member.MemberService;
import com.mal_a.member.MemberVO;
import com.mal_a.room.RoomVO;
import com.mal_a.roomoption.RoomOptionVO;
import com.mal_a.store.StoreService;
import com.mal_a.store.StoreVO;
import com.mal_a.code.CodeService;
import com.mal_a.cmn.SearchVO;
import com.mal_a.cmn.MessageVO;
import com.mal_a.cmn.ContHandler;

/**
 * Servlet implementation class LandmarkCont
 */
@WebServlet(description = "관광명소", urlPatterns = { "/roxandrea/landmark.do" })
public class LandmarkCont extends HttpServlet implements ContHandler {
   private static final long serialVersionUID = 1L;
   /** LandmarkService 객체 */
   private LandmarkService service;
   
   /** StoreService 객체 */
   private StoreService stoService;
   
   /** File Service 객체 */
   private FileMngService fileMngService;
   
   /** CodeService 객체 */
   CodeService cdService;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LandmarkCont() {
        super();
        service = new LandmarkService();
        cdService = new CodeService();
        stoService = new StoreService();
        fileMngService = new FileMngService();
    }

   /**
    * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      LOG.debug("1.doGet---------------"); //전송방식이 get 일때 콘솔에 출력
       serviceHandler(request,response);
   }

   /**
    * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       LOG.debug("1.doPost---------------"); //전송방식이 post 일때 콘솔에 출력
         serviceHandler(request, response);
   }

   @Override
   public void serviceHandler(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        //1.workDiv: 작업구분
         //2.request Encoding: utf-8
         //3.기능별 분해

         
         req.setCharacterEncoding("utf-8"); //request의 인코딩: utf-8
         String workDiv = StringUtil.nvl(req.getParameter("workDiv"));
         
         LOG.debug("2.=====================================");
         LOG.debug("2.workDiv= "+workDiv);
         LOG.debug("2.=====================================");
         switch(workDiv) {//거래분기
         case "doInsert": 			//관리자용 등록
            this.doInsert(req, res);
            break;
         case "doRetrieveAdmin":	//관리자용 다건조회
            this.doRetrieveAdmin(req, res);
            break;
         case "doRetrieveMember":	//회원용 다건조회
            this.doRetrieveMember(req, res);
            break;
         case "doSelectOne":		//단건조회
            this.doSelectOne(req, res);
            break;
         case "moveToSave":  		 //등록화면으로 이동
        	 this.moveToSave(req,res);
         break;
         case "doUpdate":  			//관리자용 수정
          	 this.doUpdate(req, res);
            break;
         case "moveToUpdate":  		//수정화면으로 이동
         	  this.moveToUpdate(req, res);
           break;
         case "doDelete":  			//관리자용 삭제
        	  this.doDel(req, res);
          break;
         default:
            LOG.debug("2.=====================================");
            LOG.debug("2.작업구분을 확인하세요. workDiv= "+workDiv);
            LOG.debug("2.=====================================");
            break;
         }
      
      }

   private void moveToSave(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	   RequestDispatcher dispatcher = req.getRequestDispatcher("/roxandrea/admin_landmark_insert.jsp");
	   dispatcher.forward(req, res);
	
   }
   private void moveToUpdate(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	   RequestDispatcher dispatcher = req.getRequestDispatcher("/roxandrea/admin_landmark_update.jsp");
	   dispatcher.forward(req, res);
	
   }
   
   
   

@Override
   public void doInsert(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
      LOG.debug("3.=====================================");
         LOG.debug("3.doInsert= ");
         LOG.debug("3.=====================================");
         
         LandmarkVO inVO = new LandmarkVO();   //param
         List<FileMngVO> inListFileMngVO = new ArrayList<FileMngVO>();
         
         //1.param read
         //2.param BoardVO
         //3.service 메소드 호출
         
        
         //lno
         String lno = StringUtil.nvl(req.getParameter("lno"));
         //이름
         String name = StringUtil.nvl(req.getParameter("name"),"");
         //우편번호
         String addrno = StringUtil.nvl(req.getParameter("zipNo"),"");
         //주소
         String addr = StringUtil.nvl(req.getParameter("roadFullAddr"),"");
         //전화번호
         String tel = StringUtil.nvl(req.getParameter("tel"),"");
         //상세내용
         String cont = StringUtil.nvl(req.getParameter("cont"),"");
         //카테고리
         String category = StringUtil.nvl(req.getParameter("category"),"");
         //파일
         String fileId = StringUtil.nvl(req.getParameter("fileId"),"");
         LOG.debug("fileId: "+fileId);
         
         //테스트
         String regId = "asdasd";
         
        //첨부파일 단건 파람 받기
  		String filePart = req.getParameter("filePart");
  		LOG.debug("filePart: "+filePart);
  		
  		//첨부파일 배열 파람 받기
  		String[] orgNm = req.getParameterValues("orgNm");
  		String[] saveNm = req.getParameterValues("saveNm");
  		String[] savePath = req.getParameterValues("savePath");
  		String[] fileSize = req.getParameterValues("fileSize");
  		String[] ext = req.getParameterValues("ext");
  		
  		for(int i=0;i<orgNm.length;i++) {
 			LOG.debug(i+"번째 "+"orgNm: "+orgNm[i]);
 			LOG.debug(i+"번째 "+"saveNm: "+saveNm[i]);
 			LOG.debug(i+"번째 "+"savePath: "+savePath[i]);
 			LOG.debug(i+"번째 "+"fileSize: "+fileSize[i]);
 			LOG.debug(i+"번째 "+"ext: "+ext[i]);
 		}
         
         inVO.setLno(lno);
         inVO.setName(name);
         inVO.setAddrNo(addrno);
         inVO.setAddr(addr);
         inVO.setTel(tel);
         inVO.setCont(cont);
         inVO.setCategory(category);
         inVO.setRegId(regId);
         if(!fileId.equals("")) {
 			inVO.setFileId(fileId);
 		}
         
         int flag = this.service.doInsert(inVO);
         LOG.debug("4.=====================================");
         LOG.debug("4.flag= "+flag);
         LOG.debug("4.=====================================");
         
         //응답처리
         res.setContentType("text/html; charset=utf-8"); 
         PrintWriter out = res.getWriter(); //출력할 수 있는 객체
         
         String msg="";
         Gson gson = new Gson();
         if(flag==1) {
            msg = inVO.getName()+"이(가)\n등록되었습니다.";
         }else {
            msg = inVO.getName()+"의\n등록 실패";
         }
         
         String gsonStr = gson.toJson(new MessageVO(String.valueOf(flag),msg));
         LOG.debug("=============================");
         LOG.debug("gsonStr= "+gsonStr);
         LOG.debug("=============================");
         
         //첨부파일 있을 경우
 		if(flag==1 && orgNm!=null) {
 			//첨부파일 VO 셋팅
			for(int i=0;i<orgNm.length;i++) {
				FileMngVO inFileMngVO = new FileMngVO();
				
				inFileMngVO.setFileId(fileId);
				inFileMngVO.setSeq(i+1);
				inFileMngVO.setOrgNm(orgNm[i]);
				inFileMngVO.setSaveNm(saveNm[i]);
				inFileMngVO.setSavePath(savePath[i]);
				inFileMngVO.setFileSize(Integer.parseInt(fileSize[i]));
				inFileMngVO.setExt(ext[i]);
				inFileMngVO.setFilePart(filePart);
				inFileMngVO.setRegId(regId);
				
				inListFileMngVO.add(inFileMngVO);
			}
			
			LOG.debug("------------------------------------");
			for(FileMngVO vo:inListFileMngVO) {
				LOG.debug(vo);
			}
			LOG.debug("------------------------------------");
			
			flag = this.fileMngService.doInsert(inListFileMngVO);
			
			LOG.debug("5==================");
			LOG.debug("5=flag="+flag);
			LOG.debug("5==================");
			
			//응답처리
			res.setContentType("text/html;charset=utf-8");
			out = res.getWriter();
//			if(flag==1) {
//				out.println("<script>alert('등록 성공!');location.href='/DaoWEB/board/board_list.jsp'</script>");
//			}else {
//				out.println("<script>alert('실패!');history.go(-1);</script>");
//			}
			msg = "";
			gson = new Gson();
			if(flag==1) {
				msg = "등록 되었습니다.";
			}else {
				msg = "등록 실패.";
			}
			
			gsonStr = gson.toJson(new MessageVO(String.valueOf(flag), msg));
			LOG.debug("============================");
			LOG.debug("=gsonStr="+gsonStr);
			LOG.debug("============================");
 		}
         
         out.println(gsonStr);
      }

   @Override
   public void doSelectOne(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	 //1.param
		  //2.param to set vo
		  //3.service call
		  //4.requeset set
		  //5.forward
	   
	   	  LOG.debug("*****doSelectOne");
		  
	   	  LandmarkVO inVO = new LandmarkVO();
	   	  FileMngVO inFileMngVO = new FileMngVO();
	   	  
		  String lno = StringUtil.nvl(req.getParameter("lno")).trim();
		  LOG.debug("lno= "+lno);
		  String fileId = StringUtil.nvl(req.getParameter("fileId"));
			LOG.debug("fileId: "+fileId);
		  
	      inVO.setLno(lno);
	      inFileMngVO.setFileId(fileId);
	      
	      LandmarkVO outVO = (LandmarkVO) service.doSelectOne(inVO);
	      LOG.debug("outVO: "+outVO);
	      
	    //첨부파일 리스트 서비스 호출
			List<FileMngVO> outListFileMng = (List<FileMngVO>) fileMngService.doRetrieve(inFileMngVO);
			LOG.debug("outListFileMng: "+outListFileMng);
			
	      req.setAttribute("outLandMarkVO", outVO);
	      req.setAttribute("outListFileMng", outListFileMng);
	      
	      RequestDispatcher dispatcher = req.getRequestDispatcher("/roxandrea/admin_landmark_update.jsp");
	      dispatcher.forward(req, res);
	   }


   @Override
   public void doRetrieve(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	   }
   

   @Override
   public void doUpdate(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	     LOG.debug("3.=====================================");
	     LOG.debug("3.doUpdate= ");
	     LOG.debug("3.=====================================");
	      
	     LandmarkVO inVO = new LandmarkVO();   //param
	     List<FileMngVO> inListFileMngVO = new ArrayList<FileMngVO>();
	      
         //lno
         String lno = StringUtil.nvl(req.getParameter("lno"));
         //이름
         String name = StringUtil.nvl(req.getParameter("name"));
         //우편번호
         String addrno = StringUtil.nvl(req.getParameter("zipNo"));
         //주소
         String addr = StringUtil.nvl(req.getParameter("roadFullAddr"));
         //전화번호
         String tel = StringUtil.nvl(req.getParameter("tel"));
         //상세내용
         String cont = StringUtil.nvl(req.getParameter("cont"));
         //카테고리
         String category = StringUtil.nvl(req.getParameter("category"));
         //파일
         String fileId = StringUtil.nvl(req.getParameter("fileId"));
         
         //작성자/수정자
         String regId = "asdsad";
         
       //첨부파일 단건 파람 받기
 		String filePart = req.getParameter("filePart");
 		LOG.debug("filePart: "+filePart);
 		
 		//첨부파일 배열 파람 받기
 		String[] orgNm = req.getParameterValues("orgNm");
 		String[] saveNm = req.getParameterValues("saveNm");
 		String[] savePath = req.getParameterValues("savePath");
 		String[] fileSize = req.getParameterValues("fileSize");
 		String[] ext = req.getParameterValues("ext");
 		
 		for(int i=0;i<orgNm.length;i++) {
			LOG.debug(i+"번째 "+"orgNm: "+orgNm[i]);
			LOG.debug(i+"번째 "+"saveNm: "+saveNm[i]);
			LOG.debug(i+"번째 "+"saveNm: "+savePath[i]);
			LOG.debug(i+"번째 "+"fileSize: "+fileSize[i]);
			LOG.debug(i+"번째 "+"ext: "+ext[i]);
		}
         
         inVO.setLno(lno);
         inVO.setName(name);
         inVO.setAddrNo(addrno);
         inVO.setAddr(addr);
         inVO.setTel(tel);
         inVO.setCont(cont);
         inVO.setCategory(category);
         inVO.setModId(regId);
         if(!fileId.equals("")) {
 			inVO.setFileId(fileId);
 		}

	     int flag = this.service.doUpdate(inVO);
	     LOG.debug("4.=====================================");
	     LOG.debug("4.flag= "+flag);
	     LOG.debug("4.=====================================");
	     
	     //응답처리
	     res.setContentType("text/html; charset=utf-8"); 
	     PrintWriter out = res.getWriter(); //출력할 수 있는 객체      
	     String msg="";
	     Gson gson = new Gson();
	     if(flag==1) {
	        msg = inVO.getName()+"이(가)\n수정되었습니다.";
	     }else {
	        msg = inVO.getName()+"이\n등록 실패";
	     }
	     
	     String gsonStr = gson.toJson(new MessageVO(String.valueOf(flag),msg));
	     LOG.debug("=============================");
	     LOG.debug("gsonStr= "+gsonStr);
	     LOG.debug("=============================");
	     
	    //첨부파일 삭제용 VO 객체 생성
		FileMngVO inFileMngDeleteVO = new FileMngVO();
		inFileMngDeleteVO.setFileId(fileId);
		
		//첨부파일 전부 삭제
		this.fileMngService.doDelete(inFileMngDeleteVO);
		
		//첨부파일 있을 경우
		if(flag==1 && orgNm!=null) {
			//첨부파일 VO 셋팅
			for(int i=0;i<orgNm.length;i++) {
				FileMngVO inFileMngVO = new FileMngVO();
				
				inFileMngVO.setFileId(fileId);
				inFileMngVO.setSeq(i+1);
				inFileMngVO.setSavePath(savePath[i]);
				inFileMngVO.setOrgNm(orgNm[i]);
				inFileMngVO.setSaveNm(saveNm[i]);
				inFileMngVO.setFileSize(Integer.parseInt(fileSize[i]));
				inFileMngVO.setExt(ext[i]);
				inFileMngVO.setFilePart(filePart);
				inFileMngVO.setRegId(regId);
				
				inListFileMngVO.add(inFileMngVO);
			}
			
			LOG.debug("------------------------------------");
			for(FileMngVO vo:inListFileMngVO) {
				LOG.debug(vo);
			}
			LOG.debug("------------------------------------");
			
			flag = this.fileMngService.doInsert(inListFileMngVO);
			
			LOG.debug("5==================");
			LOG.debug("5=flag="+flag);
			LOG.debug("5==================");
			
			//응답처리
			res.setContentType("text/html;charset=utf-8");
			out = res.getWriter();
//			if(flag==1) {
//				out.println("<script>alert('등록 성공!');location.href='/DaoWEB/board/board_list.jsp'</script>");
//			}else {
//				out.println("<script>alert('실패!');history.go(-1);</script>");
//			}
			msg = "";
			gson = new Gson();
			if(flag==1) {
				msg = "등록 되었습니다.";
			}else {
				msg = "등록 실패.";
			}
			
			gsonStr = gson.toJson(new MessageVO(String.valueOf(flag), msg));
			LOG.debug("============================");
			LOG.debug("=gsonStr="+gsonStr);
			LOG.debug("============================");
		}
	     
	     out.println(gsonStr);
   }

   @Override
   public void doDel(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		   LOG.debug("==========================");
		   LOG.debug("doDel=");
		   LOG.debug("==========================");
		   
		   //1.vo 변수 선언
		   //2.param read
		   //3.vo에 param set
		   //4.service호출
		   //5.Gson message
		   //6.forward
		   
		   LandmarkVO inVO = new LandmarkVO();
		   String lno = StringUtil.nvl(req.getParameter("lno"));
		   inVO.setLno(lno.trim());
		   int flag = this.service.doDelete(inVO);
		   
		   Gson gson = new Gson();
		   String msg="";
		   String gsonString = "";
		   MessageVO msgVO = new MessageVO();
		   if(flag>0) {
			   msg = "삭제되었습니다.";
		   }else {
			   msg = "삭제실패";
		   }
		   
		   msgVO.setMsgId(String.valueOf(flag));
		   msgVO.setMsgContents(msg);
		   
		  gsonString= gson.toJson(msgVO);
		  LOG.debug("gsonString= "+gsonString);
		  
		  res.setContentType("text/html;charset=utf-8");
		  PrintWriter out = res.getWriter();
		  out.print(gsonString);
      
   }
   
   
   public  void doRetrieveAdmin(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	   	  SearchVO inVO= new SearchVO();
	   	  StoreVO stoVO = new StoreVO();
	      String searchDiv = StringUtil.nvl(req.getParameter("searchDiv"),"4");
	      String searchWord = StringUtil.nvl(req.getParameter("searchWord"));
	      String searchWord02 = StringUtil.nvl(req.getParameter("searchWord02"));
	      String pageSize = StringUtil.nvl(req.getParameter("pageSize"),"10");
	      String pageNum = StringUtil.nvl(req.getParameter("pageNum"),"1");
	      String sno = StringUtil.nvl(req.getParameter("sno"));
	      
	      stoVO.setSno(sno);
	      LOG.debug("=======================");
	      LOG.debug("=searchDiv="+searchDiv);
	      LOG.debug("=searchWord="+searchWord);
	      LOG.debug("=searchWord02="+searchWord02);
	      LOG.debug("=======================");
	      
	      inVO.setSearchDiv(searchDiv);
	      inVO.setSearchWord(searchWord);
	      inVO.setSearchWord02(searchWord02);
	      inVO.setPageSize(Integer.parseInt(pageSize));
	      inVO.setPageNum(Integer.parseInt(pageNum));
	      
	      LOG.debug("=======================");
	      LOG.debug("inVO= "+inVO);
	      LOG.debug("=======================");
	      //--------------------------------------------------------
	      // CODE 조회
	      //    landmarkSearchDiv(검색조건)
	      //   		 1:지역, 2:카테고리, 3:지역+카테고리, 4:전체조회
	      //	comPageSize(페이지 사이즈)
	      //--------------------------------------------------------      
	      CodeVO searchDIV = new CodeVO();
	      searchDIV.setMstId("landmarkSearchDiv");
	      List<CodeVO> searchList = (List<CodeVO>) this.cdService.doRetrieve(searchDIV);

	      searchDIV.setMstId("comPageSize");
	      List<CodeVO> pageSizeList = (List<CodeVO>) this.cdService.doRetrieve(searchDIV);
	      searchDIV.setMstId("CATEGORY");
	      
	      List<CodeVO> categoryList = (List<CodeVO>) this.cdService.doRetrieve(searchDIV);
	      searchDIV.setMstId("LOC");
	      List<CodeVO> locList = (List<CodeVO>) this.cdService.doRetrieve(searchDIV);
	      
	      //Landmark
	      List<List> list = (List<List>)this.service.doRetrieveAdmin(inVO);
	      LOG.debug("----------------------------------------------");
	      for(List vo:list) {
	         LOG.debug(vo+"\n");
	      }
	      LOG.debug("----------------------------------------------");
	      
	      //총 글수
	      int totalCnt = 0;
	      if(null!=list && list.size()>0) {
			List testList = (List) list.get(0).get(0);
			//토탈 CNT
			LandmarkVO totalVO = (LandmarkVO) testList.get(0);
			LOG.debug("totalVO: "+totalVO);
			totalCnt = totalVO.getTotal();
	      }
	      LOG.debug("totalCnt: "+totalCnt);
	      
	      //code
	      req.setAttribute("searchList", searchList);	    //search code
	      req.setAttribute("pageSizeList", pageSizeList);	//pageSize code
	      req.setAttribute("categoryList", categoryList);   //category code
	      req.setAttribute("locList", locList);   //category code

	      req.setAttribute("list", list);					//landmarkVO
	      req.setAttribute("paramVO", inVO);				//검색조건,검색어,페이지사이즈,페이지 수
	      req.setAttribute("totalCnt", totalCnt);
	      
	      
    	  RequestDispatcher  dispatcher=req.getRequestDispatcher("/roxandrea/admin_landmark_list_all.jsp");
    	  dispatcher.forward(req, res);
	      
	   }
   
   public void doRetrieveMember(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	      SearchVO inVO = new SearchVO();
	      StoreVO stoVO = new StoreVO();
	      
          String searchDiv = StringUtil.nvl(req.getParameter("searchDiv"),"1");
          String searchWord = StringUtil.nvl(req.getParameter("searchWord"));
          String searchWord02=StringUtil.nvl(req.getParameter("searchWord02"));
          String pageSize = StringUtil.nvl(req.getParameter("pageSize"),"10");
          String pageNum = StringUtil.nvl(req.getParameter("pageNum"),"1");
          String autho =StringUtil.nvl(req.getParameter("autho"));
          String sno = StringUtil.nvl(req.getParameter("sno"));
 
          LOG.debug("============================================");
          LOG.debug("searchWord= "+searchWord);
          LOG.debug("============================================");
          LOG.debug("============================================");
          LOG.debug("searchWord02= "+searchWord02);
          LOG.debug("============================================");
          inVO.setSearchDiv(searchDiv);
          inVO.setSearchWord(searchWord);
          inVO.setSearchWord02(searchWord02);
          inVO.setPageSize(Integer.parseInt(pageSize));
          inVO.setPageNum(Integer.parseInt(pageNum));
          
          stoVO.setSno(sno);
          LOG.debug("============================================");
          LOG.debug("inVO= "+inVO);
          LOG.debug("============================================");
//          
	      //--------------------------------------------------------
	      // CODE 조회
	      //    landmarkSearchDiv(검색조건)
	      //   		 1:지역, 2:카테고리, 3:지역+카테고리, 4:전체조회
	      //	comPageSize(페이지 사이즈)
	      //--------------------------------------------------------      
	      CodeVO searchDIV = new CodeVO();
	      searchDIV.setMstId("landmarkSearchDiv");
	      List<CodeVO> searchList = (List<CodeVO>) this.cdService.doRetrieve(searchDIV);

	      searchDIV.setMstId("comPageSize");
	      List<CodeVO> pageSizeList = (List<CodeVO>) this.cdService.doRetrieve(searchDIV);
	      searchDIV.setMstId("CATEGORY");
	      
	      List<CodeVO> categoryList = (List<CodeVO>) this.cdService.doRetrieve(searchDIV);
	      searchDIV.setMstId("LOC");
	      List<CodeVO> locList = (List<CodeVO>) this.cdService.doRetrieve(searchDIV);
	      
	      //Landmark
	      List<List> list = (List<List>)this.service.doRetrieveMember(inVO);
	      LOG.debug("----------------------------------------------");
	      for(List vo:list) {
	         LOG.debug(vo+"\n");
	      }
	      LOG.debug("----------------------------------------------");
       
	      //총 글수
	      int totalCnt = 0;
	      if(null!=list && list.size()>0) {
			List testList = (List) list.get(0).get(0);
			//토탈 CNT
			LandmarkVO totalVO = (LandmarkVO) testList.get(0);
			LOG.debug("totalVO: "+totalVO);
			totalCnt = totalVO.getTotal();
	      }
	      LOG.debug("totalCnt: "+totalCnt);
	      
	      //code
	      req.setAttribute("searchList", searchList);	    //search code
	      req.setAttribute("pageSizeList", pageSizeList);	//pageSize code
	      req.setAttribute("categoryList", categoryList);   //category code
	      req.setAttribute("locList", locList);   			//category code
	      req.setAttribute("list", list);
	      req.setAttribute("paramVO", inVO);
	      req.setAttribute("stoVO", stoVO);
	      req.setAttribute("totalCnt", totalCnt);
//	      req.setAttribute("stoVO", storeList);
	      
	      if(autho.equals("3")) {
		      RequestDispatcher dispatcher = req.getRequestDispatcher("/roxandrea/admin_landmark_list_all.jsp");
		      dispatcher.forward(req, res);
	      }else {
		      RequestDispatcher dispatcher = req.getRequestDispatcher("/roxandrea/landmark_list.jsp");
		      dispatcher.forward(req, res);
	      }
      
   }

}
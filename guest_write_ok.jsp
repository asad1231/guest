<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%-- 웹 DB연동을 하기 위해서는 java.sql패키지의 api를 읽어들여야 한다. --%>
<%
	request.setCharacterEncoding("UTF-8");//method=post방식으로 전달된 한글을 안깨지게 해준다.
	
	String gname = request.getParameter("gname");//글쓴이
	String gtitle = request.getParameter("gtitle");//글제목
	String gpwd = request.getParameter("gpwd");//비번
	String gcont = request.getParameter("gcont");//글내용
	
	String driver="oracle.jdbc.OracleDriver";//jdbc 라이브러리 *.jar로 부터 읽어옴. 
	//oracle.jdbc는 패키지 폴더명,OracleDriver는 오라클 jdbc드라이버 클래스명
	String url="jdbc:oracle:thin:@localhost:1521:XE";//오라클 접속 주소, 1521은 오라클 연결 포트번호,
	//xe는 데이터베이스 명
	String user="day";//오라클 연결 사용자
	String password="day";//오라클 사용자 비번
	
	Connection con = null;//데이터 베이스 연결 con
	Statement stmt=null;//쿼리문 수행
	String sql=null;//쿼리문 저장
	
	
	try{
		Class.forName(driver);//jdbc드라이버 클래스 로드
		con=DriverManager.getConnection(url, user, password);//메서드 인자값으로 db접속주소, 사용자,
		//비번을 전달해서 DB연결 con을 생성
		stmt=con.createStatement();//쿼리문 수행할 stmt를 생성
		
		sql="insert into guestbook (gno,gname,gtitle,gpwd,gcont,gdate)"
		+ " values(gno_seq.nextval, '"+gname+"','"+gtitle+"','"+gpwd+"','"+gcont+"',sysdate)";
		
		int re=stmt.executeUpdate(sql);//insert,update.delete쿼리문은 executeUpdate()메서드를 사용해서
		//쿼리문을 수행하고 수행후 성공한 레코드 행의 개수를 반환
		
		if(re == 1){
			out.println("<script>");
			out.println("alert('방명록 저장에 성공했습니다!');");
			out.println("location='guest_list.jsp';");
			out.println("</script>");
		}
	}catch(Exception e){e.printStackTrace();}
	finally{
		try{
			if(stmt != null) stmt.close();
			if(con != null) con.close();
		}catch(Exception e){e.printStackTrace();}
	}
%>
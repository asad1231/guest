<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>

<%

	String driver="oracle.jdbc.OracleDriver";//jdbc 라이브러리 *.jar로 부터 읽어옴. 
	//oracle.jdbc는 패키지 폴더명,OracleDriver는 오라클 jdbc드라이버 클래스명
	String url="jdbc:oracle:thin:@localhost:1521:XE";//오라클 접속 주소, 1521은 오라클 연결 포트번호,
	//xe는 데이터베이스 명
	String user="day";//오라클 연결 사용자
	String password="day";//오라클 사용자 비번
	
	Connection con = null;//데이터 베이스 연결 con
	PreparedStatement pstmt=null;//쿼리문 수행
	ResultSet rs =null;//쿼리문 저장
	String sql = null;//쿼리문 저장 변수
	try{
		Class.forName(driver);
		con=DriverManager.getConnection(url, user, password);
		sql="select * from guestbook order by gno desc";
		pstmt=con.prepareStatement(sql);//쿼리문을 미리 컴파일 하여 수행할 pstmt생성
		rs=pstmt.executeQuery();//select문 수행후 결과 레코드를 rs에 저장
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록 목록</title>
</head>
<body>
	<table border="1">
	 <tr>
	  <th colspan="5">방명록 목록보기</th>
	 </tr>
	 <tr>
	  <th>번호</th><th>글제목</th><th>글쓴이</th><th>조회수</th><th>등록날짜</th>
	 </tr>
	 <% while(rs.next()){//next()메서드는 다음 레코드 행이 존재하면 참%>
	 <tr>
	  <th><%=rs.getInt(1) %></th><%-- 1은 select문 뒤에 검색되는 컬럼 순번을 의미한다. 해당 컬럼의 레코드가 정수
	  숫자이면 getInt()메서드로 가져온다. --%>
	  <th><a href="guest_cont.jsp?no=<%=rs.getInt(1)%>"><%=rs.getString("gtitle") %></a></th>
	  <%-- *.jsp?no=번호값 형태의 get방식으로 주소창 노출해서 값을 전달한다. --%>
	  <th><%=rs.getString("gname") %></th><%-- gname컬럼의 레코드가 문자열이면 getString()메서드로 가져옴 --%>
	  <th><%=rs.getInt("ghit") %></th>
	  <th><%=rs.getString("gdate").substring(0, 10) %></th>
	  <%-- 0이상 10미만 사이의 년월일만 반환 --%>
	 </tr>
	 <%}//while end%>
	 <tr>
	  <th colspan="5"><input type="button" value="방명록 글쓰기" onclick="location='guest_write.jsp';"></th>
	 </tr>
	</table>
</body>
</html>
<%
	}catch(Exception e){e.printStackTrace();}
	finally{
		try{
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
		}catch(Exception e){e.printStackTrace();}
	}
%>
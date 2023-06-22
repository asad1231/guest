<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int no=Integer.parseInt(request.getParameter("no"));//get으로 전달된 번호값을 받아서 정수 숫자로 변경
	
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
		sql="select * from guestbook where gno=?";
		pstmt= con.prepareStatement(sql);
		pstmt.setInt(1,no);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록 수정폼</title>
<script src="../js/jquery.js"></script>
<script src="../js/guest.js"></script>
</head>
<body>
	<form action="guest_edit_ok.jsp" method="post" onsubmit="return check();">
	<input type="hidden" name="gno" value="<%=no%>">
	<%-- hidden은 브라우저 주소창에서 안 만들어 지지만 gno 네임피라미터 이름에 value속성값을 담아서 전달할 때 유용하게 사용한다.
	이때 전달되는 번호값은 문자열 타입니다. 하지만 페이지 소스보기에서는 노출된다. 그러므로 보안상 중요한 비번같은 데이터는 히든으로 전달하지 않는다. --%>
	 <table border="1">
	  <tr>
	   <th colspan="2">jsp 방명록 글수정폼 </th>
	  </tr>
	  <tr>
	   <th>글쓴이</th>
	   <td><input name="gname" id="gname" size="14" value="<%=rs.getString("gname")%>"></td>
	   		<%-- type속성을 생략하면 기본값으로 text이다. text는 한줄 입력박스를 만든다. --%>
	  </tr>
	  
	  <tr>
	   <th>글제목</th>
	    <td><input name="gtitle" id="gtitle" size="36"value="<%=rs.getString("gtitle")%>"></td>
	  </tr>
	   <tr>
	   <th>비밀번호</th>
	   <td><input name="gpwd" id="gpwd" size="14"></td>
	  </tr>
	   <tr>
	   <th>글내용</th>
	    <td>
	     <textarea rows="10" cols="36" name="gcont" id="gcont"><%=rs.getString("gcont")%></textarea>
	     <%-- textarea에는 value속성이 없다. --%>
	    </td>
	  </tr>
	  <tr>
	  	<th colspan="2"> 
	  	 <input type="submit" value="방명록수정">
	  	 <input type="reset" value="취소" onclick="$('#gname').focus();">
	  	</th>
	  </tr>
	 </table>
	</form>
</body>
</html>
<%} //if end
	}catch(Exception e){e.printStackTrace();}
	finally{
		try{
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(con != null) con.close();
		}catch(Exception e){e.printStackTrace();}
	}
%>
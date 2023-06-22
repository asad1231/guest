<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록 글쓰기 폼</title>
<script src="../js/jquery.js"></script>
<script src="../js/guest.js"></script>
</head>
<body>
	<form action="guest_write_ok.jsp" method="post" onsubmit="return check();">
	 <table border="1">
	  <tr>
	   <th colspan="2">jsp 방명록 글쓰기폼 </th>
	  </tr>
	  <tr>
	   <th>글쓴이</th>
	   <td><input name="gname" id="gname" size="14"></td>
	   		<%-- type속성을 생략하면 기본값으로 text이다. text는 한줄 입력박스를 만든다. --%>
	  </tr>
	  
	  <tr>
	   <th>글제목</th>
	    <td><input name="gtitle" id="gtitle" size="36"></td>
	  </tr>
	   <tr>
	   <th>비밀번호</th>
	   <td><input name="gpwd" id="gpwd" size="14"></td>
	  </tr>
	   <tr>
	   <th>글내용</th>
	    <td>
	     <textarea rows="10" cols="36" name="gcont" id="gcont"></textarea>
	    </td>
	  </tr>
	  <tr>
	  	<th colspan="2"> 
	  	 <input type="submit" value="방명록저장">
	  	 <input type="reset" value="취소" onclick="$('#gname').focus();">
	  	</th>
	  </tr>
	 </table>
	</form>
</body>
</html>
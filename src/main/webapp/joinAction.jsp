<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="capStone.model.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="capStone.model.User" scope="page"/> 

<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>

	<%
	
		String userID=null;
		if(session.getAttribute("userID")!=null){
			userID=(String)session.getAttribute("userID");
		}
		if(userID!=null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인 되어있습니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");	
		}
		
		if(user.getUserID()==null || user.getUserPassword()==null || user.getUserGender()==null ||
				user.getUserEmail()==null || user.getUserName()==null){
			PrintWriter script=response.getWriter();
			script.println("<script>");
			script.println("alert('모든 정보를 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{
			UserDAO userDAO = new UserDAO();
			int result =userDAO.join(user);
			System.out.println(result);
			if(result==1){
				session.setAttribute("userID", user.getUserID());
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("'회원가입이 완료되었습니다.'");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			}
			else if(result==-2){
				PrintWriter script=response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.')");
				script.println("history.back()"); // 이전 상황으로 되돌리기
				script.println("</script>");		
			}
		}
	%>

</body>
</html>
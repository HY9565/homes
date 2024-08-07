<%@page import="java.util.ArrayList"%>
<%@page import="com.homes.room.RoomDTO"%>
<%@page import="com.homes.db.HomesDB"%>
<%@page import="java.util.Date" %>
<jsp:useBean id="homedto" class="com.homes.room.RoomDTO"></jsp:useBean>
<jsp:useBean id="homedao" class="com.homes.room.RoomDAO"></jsp:useBean>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/hostMainLayout.css">
</head>
<%
int roomidx = Integer.parseInt(String.valueOf(session.getAttribute("useridx")));

	
	
ArrayList<RoomDTO> arr= homedao.RoomSchedule(roomidx); 
	
%>
<body>
<%@ include file="/header.jsp" %>
<%@include file="hostheader.jsp" %>
<section>
<%
		if(arr==null||arr.size()==0){
			%>
				<h3>등록된 숙소가 없습니다.</h3>
			<%
		}else{
			int a = arr.size();
			for(int i=0;i<arr.size();i++){
				%>
		<div id="div111">
		<article id= "main">
			<img src ="<%=arr.get(i).getImage()%>">
		</article>
		<article id="maininfo">
			<h3><%=arr.get(i).getRoom_name() %></h3>
				<ul>
					<li>시작날짜:<%=arr.get(i).getStartday()%></li>
					<li>끝 날짜:<%=arr.get(i).getEndday()%></li>
					<li>결제 상태:<%=arr.get(i).getReason()%></li>
				</ul>
		</article>
	</div>
		<div id="hr">
		<hr>
		</div>
				<%
			}
		}
	%>
	   <div class="date-picker">

			<div id="date-input">
				<div class="search_item">
					<label for="checkin">체크인</label> <input type="text"
						id="check_in" class="date" required readonly="readonly"
						id="from">
				</div>
				<div class="search_item">
					<label for="checkin">체크아웃</label> <input type="text"
						id="check_out" class="date" required readonly="readonly"
						id="to">
				</div>
			</div>

			<%-- <%@ include file="host_cal.jsp"%> --%>
			
		</div>
</section>
</body>
</html>
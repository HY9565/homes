<%@page import="java.util.ArrayList"%>
<%@page import="com.homes.room.RoomDTO"%>
<%@page import="com.homes.db.HomesDB"%>
<%@page import="java.util.Date" %>
<jsp:useBean id="roomdto" class="com.homes.room.RoomDTO"></jsp:useBean>
<jsp:useBean id="roomdao" class="com.homes.room.RoomDAO"></jsp:useBean>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/hostMainLayout.css">
</head>

<body>
<%@ include file="/header.jsp" %>
<%@include file="hostheader.jsp" %>
<%
ArrayList<RoomDTO> rarr= roomdao.HomesList(userid); 
%>
<section>
<%
if (rarr == null || rarr.size() == 0) {
%>
    <h3>등록된 숙소가 없습니다.</h3>
<%
} else {
    for (int i = 0; i < rarr.size(); i++) {
        request.setAttribute("room", rarr.get(i));
%>
        <div id="div111">
            <article id="main">
                <img src="<%= rarr.get(i).getImage() %>">
            </article>
            <article id="maininfo">
                <h3><%= rarr.get(i).getRoom_name() %></h3>
                <!-- PJW part -->
                 <jsp:include page="host_cal.jsp">
                    <jsp:param name="room" value="<%= rarr.get(i).getRoom_idx() %>" />
                    <jsp:param name="seq" value="<%= i %>" />
                </jsp:include> 
            </article>
        </div>
        <div id="hr">
            <hr>
        </div>
<%
    }
}
%>
</section>
</body>
</html>
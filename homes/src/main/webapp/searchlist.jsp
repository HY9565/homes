<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.homes.region.RegionDTO" %>
<jsp:useBean id="rdto" class="com.homes.region.RegionDTO"></jsp:useBean>
<jsp:useBean id="rdao" class="com.homes.region.RegionDAO"></jsp:useBean>    
<%@ page import="com.homes.region.Region_DetailDTO" %>
<jsp:useBean id="rddto" class="com.homes.region.Region_DetailDTO"></jsp:useBean>
<jsp:useBean id="rddao" class="com.homes.region.Region_DetailDAO"></jsp:useBean>
<%@ page import="com.homes.room.RoomDTO" %>
<jsp:useBean id="rmdto" class="com.homes.room.RoomDTO"></jsp:useBean>
<jsp:useBean id="rmdao" class="com.homes.room.RoomDAO"></jsp:useBean>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/homes/css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/indexLayout.css">
<%
	String region_idx=request.getParameter("select_location");
	int p_region_idx=Integer.parseInt(region_idx);
	String check_in=request.getParameter("check_in");
	String check_out=request.getParameter("check_out");
	String num=request.getParameter("guest_num");
	if(num==null||num.equals("")){
		num="0";
	}
	int guest_num=Integer.parseInt(num);
%>
<%
	//1.총게시물수
	int totalCnt=0;
	if(!(num.equals("0"))){
		totalCnt=rmdao.getRoomCount(p_region_idx, guest_num, check_in, check_out);
	} else{
		totalCnt=rmdao.getRoomCount(p_region_idx);
	}
	//2.보여줄 리스트수
	int listSize=6;
	//3.페이지수
	int pageSize=5;
	//4.사용자 현재위치
	String cp_s=request.getParameter("cp");
	if(cp_s==null||cp_s.equals("")){
		cp_s="1";
	}
	int cp=Integer.parseInt(cp_s);
	
	int totalPage=(totalCnt/listSize)+1;
	if(totalCnt%listSize==0) totalPage--;
	
	//사용자 현재 위치의 그룹번호
	int userGroup=cp/pageSize;
	if(cp%pageSize==0)userGroup--;
%>
</head>
<script>
function validateForm() {
    var checkin = document.getElementById('check_in').value;
    var checkout = document.getElementById('check_out').value;
    var checkinDate = new Date(checkin);
    var checkoutDate = new Date(checkout);
    var now = new Date();
    
    if (checkinDate <= now) {
        alert('체크인 날짜는 현재 날짜와 시간 이후여야 합니다.');
        return false; // 폼 제출을 막음
    }
    
    if (checkoutDate <= now) {
        alert('체크아웃 날짜는 현재 날짜와 시간 이후여야 합니다.');
        return false; // 폼 제출을 막음
    }
    
    if (checkoutDate <= checkinDate) {
        alert('체크아웃 날짜는 체크인 날짜 이후여야 합니다.');
        return false; // 폼 제출을 막음
    }
    
    var checkIn = document.getElementById('check_in');
    var checkOut = document.getElementById('check_out');
	
   
    if (!checkIn || !checkOut || checkin==''||checkout=='' ) {
        alert("체크인, 체크아웃을 입력해주세요.");
        return false; // 폼 제출을 막습니다.
    }
    
    return true; // 폼 제출을 허용
}
</script>
<body>
<%@ include file="header.jsp"%>
<section>
<article id="search_box">
<fieldset class="search_box_fs">
<form name="search" action="searchlist.jsp" onsubmit="return validateForm()">
<div class="select_box">
	<div class="search_item">
		<label for="destination">여행지</label>
		<select name="select_location" class="select_things">
		<%
		ArrayList<RegionDTO> region=new ArrayList<>();
		region=rdao.getRegion();
				
		for(int i=0;i<region.size();i++){%>
			 <option value="<%= region.get(i).getRegion_idx() %>"
			                <% if(p_region_idx == region.get(i).getRegion_idx()) { %> selected <% } %>>
			            <%= region.get(i).getRegion_name() %>
        	</option>	   
       <%} %>
		</select>
	</div> 

	<div class="date-picker">
		<div id="date-input">
			<div class="search_item">
				<label for="checkin">체크인</label> <input type="text" id="check_in" name="check_in" class="date" required="required" readonly="readonly" value="<%= (request.getParameter("check_in") != null && !request.getParameter("check_in").isEmpty() && !request.getParameter("check_in").equals("null")) ? request.getParameter("check_in") : "" %>">
			</div>
			<div class="search_item">
				<label for="checkout">체크아웃</label> <input type="text" id="check_out" name="check_out" class="date" required="required" readonly="readonly" value="<%= (request.getParameter("check_out") != null && !request.getParameter("check_out").isEmpty() && !request.getParameter("check_out").equals("null")) ? request.getParameter("check_out") : "" %>" >
			</div>
		</div>

		<%@ include file="cal.jsp"%>
		
		<div id="select_guest_div">
			<label for="checkin">인원수</label> <input type="number" name="guest_num" id="select_guest" min="2" step="1"
			       value="<%= (request.getParameter("guest_num") != null && !request.getParameter("guest_num").isEmpty() && !request.getParameter("guest_num").equals("0")) ? request.getParameter("guest_num") : "" %>" 
			       required="required">
		</div>
		<div class="search_button">
			<input type="submit" value="검색" class="button">
		</div>
	</div>
</div>
</form>
</fieldset>
</article>

<article id="search_room">
<table id="search_room_table">
<tbody>
	<%
	int user_idx=0;
	if(!(session.getAttribute("useridx")==null || session.getAttribute("useridx")=="")){ 
		user_idx=(Integer)session.getAttribute("useridx");
	}
	
	String redheart = "&hearts;";
	String blankheart = "&#9825;";
	ArrayList<RoomDTO> room=new ArrayList<>();
	//room=rmdao.getRoom(p_region_idx,cp,listSize);
	if(!(num.equals("0"))){
		room=rmdao.getRoom(p_region_idx,cp,listSize,guest_num,check_in,check_out);
	} else {
		room=rmdao.getRoom(p_region_idx,cp,listSize);
	}
	if(room==null||room.size()==0){
		%>
		<tr>
			<td colspan="3" align="center">
				<%rddao.countUpdate(p_region_idx); %>
				검색된 숙소가 없습니다
			</td>
		</tr>
		<%
	} else {
		for(int i=0;i<room.size();i++){ %>
			<%if(i%2==0) {%>
		   		<tr>
		   	<%} %>
	      		<td>
	      			<div id="room_card">
		      			<a href="rooms/information.jsp?room_idx=<%= room.get(i).getRoom_idx() %>&check_in=<%=check_in %>&check_out=<%=check_out %>&guest_num=<%=guest_num%>">
		      			<img src="<%=room.get(i).getImage() %>" onerror="this.src='/homes/img/no_image.jpg'"></a>
		      			<%
	      				int like_idx = gdao.like(user_idx, room.get(i).getRoom_idx());
	      				if(like_idx!=0){ 	      				
	      				%>
		      				<div id="room_heart">
	           					 <a id="room_heartlink" href="#"><%= redheart %></a>
	       					</div>
       					<%
       					} else if (user_idx!=0){
       					%>
		      				<div id="room_heart">
	           					 <a id="room_heartlink" href="#"><%= blankheart %></a>
	       					</div>
       					<%	
       					}
       					%>
		      		</div>
		      			<p><%=room.get(i).getRoom_name() %></p>
	      		</td>
	   		<%if(i%2==1 || i==room.size()-1) {%>
		   		</tr>
		   	<%} %>
		<%}
	}%>
</tbody>
<tfoot>
	<% if(!(room==null||room.size()==0)){%>
	<tr>
		<td colspan="3" align="center">
			<%
			if(userGroup!=0){
				%><a href="searchlist.jsp?cp=<%=(userGroup-1)*pageSize+pageSize %>&select_location=<%=p_region_idx %>
				<%
				if(!(num.equals("0"))){
					%>&check_in=<%=check_in %>&check_out=<%=check_out %>&guest_num=<%=guest_num %><%
				}
				%>
				">&lt;&lt;</a><%
			}
			%>
			
			<%
			for(int i=userGroup*pageSize+1;i<=userGroup*pageSize+pageSize;i++){
				%>
				&nbsp;&nbsp;<a href="searchlist.jsp?cp=<%=i %>&select_location=<%=p_region_idx %>
				<%
				if(!(num.equals("0"))){
					%>&check_in=<%=check_in %>&check_out=<%=check_out %>&guest_num=<%=guest_num %><%
				}
				%>
				"><%=i %></a>&nbsp;&nbsp;
				<%
				if(i==totalPage){
					break;
				}
			}
			%>
			
			<%
			if(userGroup!=(totalPage/pageSize-(totalPage%pageSize==0?1:0))){
				%><a href="searchlist.jsp?cp=<%=(userGroup+1)*pageSize+1 %>&select_location=<%=p_region_idx %>
				<%
				if(!(num.equals("0"))){
					%>&check_in=<%=check_in %>&check_out=<%=check_out %>&guest_num=<%=guest_num %><%
				}
				%>
				">&gt;&gt;</a><%
			}
			%>
		</td>
	</tr>
	<%} %>
</tfoot>
</table>
</article>
</section>
<%@ include file="footer.jsp"%>
</body>
</html>
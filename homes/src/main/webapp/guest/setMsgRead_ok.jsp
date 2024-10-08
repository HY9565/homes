<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper, com.fasterxml.jackson.core.type.TypeReference" %>
<%@ page import="java.util.*"%>
<%@ page import="java.util.stream.*"%>
<jsp:useBean id="gdao" class="com.homes.guest.GuestDAO" scope="session"></jsp:useBean>
<%
request.setCharacterEncoding("utf-8");
String json = request.getReader().lines().collect(Collectors.joining());
ObjectMapper mapper = new ObjectMapper();

Map<String, List<Integer>> data = mapper.readValue(json, new TypeReference<Map<String, List<Integer>>>() {});
List<Integer> setReadIdxs = data.get("setReadidx");
String userid=(String)session.getAttribute("userid");
if(setReadIdxs!=null){
	for(int msg_idx : setReadIdxs){
		gdao.setMsgRead(msg_idx, userid);
	}
}
%>
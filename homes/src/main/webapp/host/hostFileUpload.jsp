<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean id="wf" class="com.homes.host.WebFolderDAO" scope="session"></jsp:useBean>
<%@page import="com.oreilly.servlet.*"%>
    
<!-- ��ǥ �������ε� -->
<%
	String savepath=wf.getHomePath()+wf.getImgpath();
	MultipartRequest mr= new MultipartRequest(request,savepath,(int)wf.getFreeSize(),"UTF-8");//
	
%>
<script>
	window.alert('<%=request%>���� �ø��� ����!'');
	opener.window.location.reload();
	window.self.close();
</script>
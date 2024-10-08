<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="adao" class="com.homes.admin.AdminTestDAO"></jsp:useBean> 
<%
String idx_s=request.getParameter("regionIdx");
int idx=Integer.parseInt(idx_s);
String name=request.getParameter("regionName");
String pidx_s=request.getParameter("select_parent");
int pidx=Integer.parseInt(pidx_s);

boolean check=true;
if(pidx==0){	
	check=adao.nameCheck(name);
} else {	
	check=adao.nameCheck(pidx, name);
}

if(!check){
	int result=0;
	if(pidx==0){	
		result=adao.regionUpdateSubmit(idx, name);
	} else {	
		result=adao.regionUpdateSubmit(idx, name, pidx);
	}
	
	String msg=result>0 ? "지역 수정 완료" : "지역 수정 실패";
	%>
	<script>
	window.alert('<%=msg %>');
	opener.window.location.reload();
	window.self.close();
	
	</script>
<%} else {
	%>
	<script>
	window.alert('이미 존재하는 지역명입니다');
	history.back();
	</script>
	<%
}%>
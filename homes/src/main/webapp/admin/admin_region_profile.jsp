<%@page import="com.homes.room.RoomDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<jsp:useBean id="adao" class="com.homes.admin.AdminTestDAO"></jsp:useBean>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/mainLayout.css">
<link rel="stylesheet" type="text/css" href="/homes/css/adminLayout.css">
<style>
.content {
    flex-grow: 1;
    padding: 20px;
}
.card {
    background-color: #f4f4f4;
    padding: 20px;
    margin-bottom: 20px;
    border-radius: 5px;
}
.buttons>button {
	font-weight: bold; 
	margin-top: 10px;
	margin-right: 8px; 
	margin-bottom: 8px; 
	height: 45px;
	width : 90px;
}

.card_cover {
    display: flex;
    margin-top: 20px;
    justify-content: space-between;
}

.card_cover .rg_img {
	cursor: pointer;
	width: 300px;
	height: 200px;
	position: relative;
	background-size: contain;  
    background-repeat: no-repeat;  
    background-position: center;
}

img {
	max-width: 100%;
 	max-height: 100%;
}

.card_cover .rg_value {
	padding : 10px;
}
input[type="submit"]{
    background-color: #cd280e;
    padding: 10px;
    width: 150px;
    border-radius: 5px;
    border: 0;
    color: lemonchiffon;
    font-size: 20px;
    font-family: 'goorm-sans-bold';
}
input[type="submit"]:hover{opacity:0.5;}
</style>
<%
	String region_idx_s=request.getParameter("param");
	int region_idx=Integer.parseInt(region_idx_s);
%>
<script>
function loadImage(reader) {
    var output = document.querySelector('.rg_img');
    output.style.backgroundImage = 'url(' + reader.result + ')';
}
function selectImage(event) {
    var reader = new FileReader();
    
    reader.onload = function() {
        loadImage(reader);
    };    
    reader.readAsDataURL(event.target.files[0]);
}

function setInitialBackground() {
    var img = new Image();
    var output = document.querySelector('.rg_img');
    img.src = '<%=adao.getRegionImg(region_idx) %>';
    
    img.onload = function() {
        output.style.backgroundImage = 'url(' + img.src + ')';
    };
    
    img.onerror = function() {
        output.style.backgroundImage = 'url(/homes/img/no_image.jpg)';
    };
}

window.onload = setInitialBackground;
</script>
</head>
<body>
<%@ include file="adminheader.jsp"%>
<section>
<article>
<fieldset class="title">
<h2>관리자페이지</h2>
</fieldset>
</article>
<article class="adminContent">
<%@include file="adminSideBar.jsp" %>
<fieldset class="fs_adminContent">
	
	<form name="fileUpload" method="post" enctype="multipart/form-data" action="admin_region_profile_ok.jsp">
	<div class="content">
		<div>
			<label for="region_sum" class="label">
	       		<span>지역이름: </span>
	       		<span><%=adao.getParentName(region_idx) %></span>
				<input type="hidden" name="ridx" value="<%=region_idx %>">
	       </label>		

		</div>
    	<label for="region_sum" class="label">
       </label>
        <div class="card_cover">
        	<div class="rg_img">       		
        	</div>
        	<div class="rg_value">
        		<label for="thumb_nail" class="label">	
					<span style="font-size: 15px;">지역을 대표하는 이미지</span>
					<br>
					<small style="color: #A6A6A6;">확장자: jpg, jpeg, png</small>
				</label>
				<br>
				<input type="file" name="selectFile" class="form-control" accept="image/*" style="width: 500px; margin-top: 15px;" onchange="selectImage(event)">
        		
	        	<div style="float : right; margin-top: 50px; margin-right: 10px;">
	        		<input type="submit" value="확인">
				</div>
        	</div>
       </div>			
	</div>
	</form>		
</fieldset>
</article>
</section>
<%@ include file="../footer.jsp"%>
</body>
</html>d
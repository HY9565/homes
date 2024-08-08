<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import ="com.homes.host.*" %>
<%@ page import ="java.util.*" %>
<jsp:useBean id="sdao" class="com.homes.host.ScheduleDAO"></jsp:useBean>
<style>
.date{
	width: 200px;
    border: 3px solid black;
    padding: 10px;
    font-size: 20px;
    font-family: 'SBAggroB';
}
.date-picker {
	position: relative;
	display: flex;
    align-items: center;
}
.date-picker>div{
 	float:left;
}
.date-picker>div>div{
 	float:left;
}
#date-input {
	width: 417px;
	padding: 8px;
	font-size: 16px;
	cursor: pointer;
	display:flex;
	font-family: 'SBAggroB';
    font-size:25px;
}
.calendar {
	position: absolute;
	top: 90%;
	left: -30px;
	width: 615px;
	z-index: 10;
	/* border: 1px solid black; */
	border:0px;
	background-color: #e2dccc;
	/* box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); */
}
.prev-month{
	font-size: 30px;
    width: 40px;
    border: 3px solid black;
    background-color: #dec022;
    font-weight: bold;
}
.next-month{
	font-size: 30px;
    width: 40px;
    border: 3px solid black;
    background-color: #dec022;
    font-weight: bold;
}
.month {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px;
	background-color: #e2dccc;
	width: -webkit-fill-available;
	border:3px solid black;
}
.weekdays, .days {
	display: flex;
	flex-wrap: wrap;
}
.weekdays span, .days span {
	width: 14.28%;
	text-align: center;
	padding: 10px 0;
}
.days span {
	cursor: pointer;
}
.days span:hover {
	background-color: #f2f2f2;
}
.days .selected {
	background-color: #007bff;
	color: white;
}
.line {
	background-color: blue;
}

.side_cal {
	display: flex;
}

.one_month_cal {
	display: inline;
	float: left;
	border: 4px solid black;
	width: 300px;
}

.month-year {
	text-align: center;
}

.disabled {
	text-decoration: line-through;
	background-color: lightgray;
}

.sunday {
	color: red;
}

.month-year {
	font-size: 25px;
	/* background-color: lightgray; */
	background-color:#dec022;
	border-bottom:3px solid black;
}
#select_guest_div{
	margin-left:115px;
	display: flex;
    flex-direction: column;
    padding: 10px;
}
#select_guest_div label{
	padding-bottom:5px;
}
#select_guest{
	border: 3px solid black;
    width: 200px;
    font-size: 20px;
    padding: 10px;
    font-family: 'SBAggroB';
}
.button{
	width:80px;
	background-color:#dec022;
	border:3px solid black;
	font-family: 'SBAggroB';
	padding:10px;
	font-size:20px;
}
</style>

<div class="calendar" id="calendar" style="display: block;">
	<div class="month">
		<button class="prev-month">‹</button>
		<span class="month-year">초기화</span>
		<button class="next-month">›</button>
	</div>
	<div class="side_cal">
		<!-- 날짜가 여기에 동적으로 추가됩니다 -->
	</div>
</div>

<%
ArrayList cal_arr = sdao.getSchedule(1);


for(int i=0; i<cal_arr.size(); i++){
%>
	<input type="text" value="<%=cal_arr.get(i)%>" >
<%
}
%>
<script>
    const dateInput = document.getElementById('date-input');
    const from = document.getElementById('check_in');
    const to = document.getElementById('check_out');
    const calendar = document.getElementById('calendar');
    const reset = calendar.querySelector('.month-year');
    const prevMonthBtn = calendar.querySelector('.prev-month');
    const nextMonthBtn = calendar.querySelector('.next-month');
    const side_cal = calendar.querySelector('.side_cal');
	var cals = [];
	var date_from_to = [];
    let currentDate = new Date();
    let nextDate = new Date();
    var loc = 0;
    
    reset.addEventListener('click', () => {
        side_cal.querySelectorAll('.line').forEach(el => el.setAttribute('class', 'none'));
		from.value='';
		to.value='';
		
    });
	
    
    document.addEventListener('DOMContentLoaded', () => {
        

    	renderCalendar(currentDate);
        dateCheck();
        renderCalendar(nextDate);
        

        
        
        });

    prevMonthBtn.addEventListener('click', () => {
    	if(loc==0) return;
		nextDate.setMonth(nextDate.getMonth()- 1);

		
		for(var i=0; i<cals.length; i++){
			
			cals[i].style.display='none';
		}
 		cals[loc+1].style.display='none';
		cals[loc].style.display='block';
		cals[loc-1].style.display='block';

    	loc--;


    });

    nextMonthBtn.addEventListener('click', () => {
    	dateCheck();

		for(var i=0; i<cals.length; i++){
			
			cals[i].style.display='none';
		}

        
        if(loc+2==cals.length){
        	renderCalendar(nextDate);
            cals[loc+1].style.display='block';
        } else {
            cals[loc+1].style.display='block';
            cals[loc+2].style.display='block';
        }
   
    	loc++;

        
/* 		alert((loc+9)%12);
 */		

    });
    
	function dateCheck(){
		var checkDate = nextDate.getDate();
		nextDate.setDate(1);
    	nextDate.setMonth(nextDate.getMonth()+1);

    	var temp = new Date(nextDate.getFullYear(), nextDate.getMonth() + 1, 0).getDate();
    	nextDate.setDate(Math.min(checkDate, temp));

	}
	
    function addWeekdays(){

    	const weekdays  = document.createElement('div');
		weekdays.classList.add('weekdays');

        for(let i =0; i<7; i++ ){
        	const dow_span = document.createElement('span');
        	weekdays.appendChild(dow_span);
        }
        
		one_month_cal.appendChild(weekdays);
        side_cal.appendChild(one_month_cal);
        

		for(let i=0; i<document.querySelectorAll(".weekdays>span").length; i++){
			switch (i%7) {
			case 0:
				document.querySelectorAll(".weekdays>span")[i].textContent='일';
				document.querySelectorAll(".weekdays>span")[i].setAttribute('class','sunday');

				break;
			case 1:
				document.querySelectorAll(".weekdays>span")[i].textContent='월';
				break;
			case 2:
				document.querySelectorAll(".weekdays>span")[i].textContent='화';
				break;
			case 3:
				document.querySelectorAll(".weekdays>span")[i].textContent='수';
				break;
			case 4:
				document.querySelectorAll(".weekdays>span")[i].textContent='목';
				break;
			case 5:
				document.querySelectorAll(".weekdays>span")[i].textContent='금';
				break;
			case 6:
				document.querySelectorAll(".weekdays>span")[i].textContent='토';
				break;
			default:
				break;
			}
		}

        return one_month_cal;
    }
    
    function setYMD(){
		/* <span class="month-year"></span> */
		
		const one_month_cal  = document.createElement('div');
		cals.push(one_month_cal);
		one_month_cal.classList.add('one_month_cal');
		const month_year  = document.createElement('div');
		month_year.setAttribute('class','month-year');
		one_month_cal.appendChild(month_year);
		
    	const year = nextDate.getFullYear();
        const month = nextDate.getMonth();
        const tot = '';
        month_year.textContent = year+'년'+(month+1)+'월';
        
        return one_month_cal;
        
        
    }
    
    function renderCalendar(date) {
    	one_month_cal = setYMD();
    	addWeekdays(one_month_cal);


        /* 
        const year = date.getFullYear();
        const month = date.getMonth();
        const tot = '';
        monthYear.textContent = year+'년'+(month+1)+'월'; */
     
      	const monthContainer  = document.createElement('div');
      	monthContainer.innerHTML = '';
      	monthContainer.classList.add('days');
      	
      	const year = nextDate.getFullYear();
        const month = nextDate.getMonth();
      	
        const firstDay = new Date(year, month, 1).getDay();
        const lastDate = new Date(year, month + 1, 0).getDate();

        for (let i = 0; i < firstDay; i++) {
            const emptyCell = document.createElement('span');
            monthContainer.appendChild(emptyCell);
        }
		
        for (let day = 1; day <= lastDate; day++) {
            const dayElement = document.createElement('span');

            dayElement.setAttribute('class','none');

            dayElement.textContent = day;
            dayElement.id = 'd' + year + (month + 1).toString().padStart(2, '0') + (day.toString().padStart(2, '0'));
            


            dayElement.addEventListener('click', () => {   	
				chooseDate(year, month, day, dayElement);
            });
            monthContainer.appendChild(dayElement);
            
            if(cals.length==1 && day<currentDate.getDate()){
                dayElement.classList.add('disabled');
                const clone = dayElement.cloneNode(true);
                dayElement.parentNode.replaceChild(clone, dayElement);
            }
        }
        one_month_cal.appendChild(monthContainer);
    }
    
    function chooseDate(year, month, day, dayElement) {
    	
        document.querySelectorAll('.none').forEach(span => span.classList.remove('selected'));
        dayElement.classList.add('selected');
		// span태그 + none클래스 : => remove selected
		
		// line none 클릭마다 변환
/*     	if (dayElement.classList.contains('line')) {
            dayElement.classList.replace('line', 'none');
            
        } else {
            dayElement.classList.replace('none', 'line');

        } */
        dayElement.classList.replace('none', 'line');

        selectedDates = document.querySelectorAll('.selected');

        if (document.querySelectorAll('.selected').length  == 1) {
        	date_from_to[0] = dayElement;
 /*             const firstDateId = selectedDates[0].id.replaceAll('d', '');
            const firstDate = new Date(
                    firstDateId.substring(0, 4),
                    parseInt(firstDateId.substring(4, 6)) - 1,
                    firstDateId.substring(6, 8)
                );
 			const allDays = side_cal.querySelectorAll('span');
            allDays.forEach(dayElement => {
                const dayId = dayElement.id;
                if(dayId!=null && dayId!="")

                if (dayId) {
                    const currentDate = new Date(
                        dayId.substring(1, 5),
                        parseInt(dayId.substring(5, 7)) - 1,
                        dayId.substring(7, 9),
                    );

                    if (currentDate < firstDate) {
                        dayElement.classList.add('disabled');
                        const clone = dayElement.cloneNode(true);
                        dayElement.parentNode.replaceChild(clone, dayElement);
                    }
                }
            }); */
            
         	from.value = ''+year+'-'+(month+1).toString().padStart(2,'0')+'-'+(day.toString().padStart(2,'0'));

/*             calendar.style.display = 'none';
 */            
        } else if (document.querySelectorAll('.selected').length ==2){

        	date_from_to[1] = dayElement;

            const firstDateId = selectedDates[0].id.replaceAll('d', '');
            const lastDateId = selectedDates[1].id.replaceAll('d', '');

            const firstDate = new Date(
                firstDateId.substring(0, 4),
                parseInt(firstDateId.substring(4, 6)) - 1,
                firstDateId.substring(6, 8)
            );
            const lastDate = new Date(
                lastDateId.substring(0, 4),
                parseInt(lastDateId.substring(4, 6)) - 1,
                lastDateId.substring(6, 8)
            );
			
            const allDays = side_cal.querySelectorAll('span');
            
            allDays.forEach(dayElement => {
                const dayId = dayElement.id;
                if(dayId!=null && dayId!="")

                if (dayId) {
                    const currentDate = new Date(
                        dayId.substring(1, 5),
                        parseInt(dayId.substring(5, 7)) - 1,
                        dayId.substring(7, 9),
                    );

                    if (currentDate >= firstDate && currentDate <= lastDate) {
                        dayElement.classList.add('line');
                    }
                }
            });
         	to.value = ''+year+'-'+(month+1).toString().padStart(2,'0')+'-'+(day.toString().padStart(2,'0'));
        	
           

        } else {

        	const length = selectedDates.length;
        	
            const firstDate = date_from_to[0];
            const lastDate = date_from_to[1];
 			
            if(selectedDates[0]===firstDate){


        		if(selectedDates[1]===lastDate){
                	lastDate.setAttribute('class','none');
            		selectedDates[2].setAttribute('class','none');
                	date_from_to[1] = selectedDates[2];
            	} else {
            		lastDate.setAttribute('class','none');
            		selectedDates[1].setAttribute('class','none');
            		date_from_to[1] = selectedDates[1];
            	}
        		
                side_cal.querySelectorAll('.line:not(.selected)').forEach(el => el.setAttribute('class', 'none'));
				
            	
            } else {
            	firstDate.setAttribute('class','none');
            	selectedDates[0].setAttribute('class','none');
                side_cal.querySelectorAll('.line:not(.selected)').forEach(el => el.setAttribute('class', 'none'));

            	date_from_to[0] = selectedDates[0];
            }
            

			againChooseDate(year, month, day, dayElement);
        }
        

    }
    
 function againChooseDate(year, month, day, dayElement) {
        document.querySelectorAll('.none').forEach(span => span.classList.remove('selected'));
        dayElement.classList.add('selected');
        
        /* alert(date_from_to[0].id);
        alert(date_from_to[1].id); */

    	if (dayElement.classList.contains('line')) {
            dayElement.classList.replace('line', 'none');
            
        } else {
            dayElement.classList.replace('none', 'line');
        }
		
        selectedDates = document.querySelectorAll('.selected');
        const firstDateId = selectedDates[0].id.replaceAll('d', '');
        const lastDateId = selectedDates[1].id.replaceAll('d', '');

        const firstDate = new Date(
                firstDateId.substring(0, 4),
                parseInt(firstDateId.substring(4, 6)) - 1,
                firstDateId.substring(6, 8)
        );
        const lastDate = new Date(
                lastDateId.substring(0, 4),
                parseInt(lastDateId.substring(4, 6)) - 1,
                lastDateId.substring(6, 8)
        );
			
            const allDays = side_cal.querySelectorAll('span');
            
            allDays.forEach(dayElement => {
                const dayId = dayElement.id;
                if(dayId!=null && dayId!="")

                if (dayId) {
                    const currentDate = new Date(
                        dayId.substring(1, 5),
                        parseInt(dayId.substring(5, 7)) - 1,
                        dayId.substring(7, 9),
                    );

                    if (currentDate >= firstDate && currentDate <= lastDate) {
                        dayElement.classList.add('line');
                    }
                }
            });

			
         	from.value = makeIdToDate(date_from_to[0].id)
         	to.value = makeIdToDate(date_from_to[1].id)
        }
        
		function makeIdToDate(id){
			
			var date_id = id.slice(1);
			
			return date_id.slice(0, 4)+'-'+date_id.slice(4, 6)+'-'+date_id.slice(6, 8);
		}
    


    document.addEventListener('click', (event) => {
        if (!document.querySelector('.date-picker').contains(event.target)) {
            calendar.style.display = 'none';
        }
    });
    
</script>
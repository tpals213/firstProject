<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="/ssm/resources/js/jquery-3.7.0.min.js"></script>

<link href="/ssm/resources/js/fullcalendar-5.0.1/lib/main.css" rel="stylesheet" />
<script type="text/javascript" src="/ssm/resources/js/fullcalendar-5.0.1/lib/main.js"></script>
<script type="text/javascript" src="/ssm/resources/js/fullcalendar-5.0.1/lib/locales/ko.js"></script>

<!-- <link rel="stylesheet" href="/ssm/resources/css/jquery-ui-1.13.2/jquery-ui.min.css" /> -->
<link rel="stylesheet" href="/ssm/resources/css/jquery-ui-themes-1.13.2/themes/base/jquery-ui.css" />
<script type="text/javascript" src="/ssm/resources/css/jquery-ui-1.13.2/jquery-ui.min.js"></script>

<link rel="stylesheet" href="/ssm/resources/css/bootstrap-4.4.1-dist/css/bootstrap.min.css" />
<script type="text/javascript" src="/ssm/resources/css/bootstrap-4.4.1-dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="resources/css/common/main.css" />

<style type="text/css">
body {
	line-height:14px;
}

#contents {
	/* padding-top: 150px; */
	margin: 0 auto;
	width: 900px;
}

#calendar {
	/* max-width: 1100px; */
	/* max-width: 900px; */
	/* max-width: 800px; */
	/* max-width: 500px; */
	margin: 0 auto;
}

section .inner-section {
	/* padding: 140px 0 0 0; */
}

#form-div {
	background-color: '';
	padding: 5px 5px 5px;
	width: 100%;
	margin-top: 5px;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
}

/* #dialog { font-size: 25px; } */
#dialog {
	font-size: 12px;
}

#dialog h2 {
	font-size: larger;
}

#dialog div {
	/* font-size: 12px; */
	font-size: 14px;
}

#dialog div.bigger {
	font-size: 150%;
}

#dialog .input-field {
  padding-left: 3px;
}

#dialog .textarea-field {
  padding-left: 3px;
}

/* #dialog p { font-size: x-small; background-color: blue; } */
.feedback-input {
	color: #3c3c3c;
	font-family: Helvetica, Arial, sans-serif;
	/* font-weight:400; */
	font-size: 12px;
	border-radius: 0;
	line-height: 12px;
	/* line-height: 22px; */
	background-color: #ffffff;
	/* padding: 3px 3px 3px 6px; */
	/* margin-bottom: 10px; */
	/* width:100%; */
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	-ms-box-sizing: border-box;
	box-sizing: border-box;
	/* border: 3px solid rgba(0,0,0,0); */
	/* border: 3px solid; */
	border: 1px solid;
}

.feedback-input:focus {
	background: #fff;
	box-shadow: 0;
	/* border: 3px solid #3498db; */
	border: 1px solid #3498db;
	border-color: #3498db;
	color: #3498db;
	/* outline: none; */
	/* padding: 13px 13px 13px 54px; */
}

.focused {
	color: #30aed6;
	border: #30aed6 solid 3px;
}

/* Icons */
#name {
	/* background-image: url(http://rexkirby.com/kirbyandson/images/name.svg); */
	/* 이미지 없음(2024.04.07) */
	background-size: 30px 30px;
	background-position: 11px 8px;
	background-repeat: no-repeat;
}

#email {
	/* background-image: url(http://rexkirby.com/kirbyandson/images/email.svg); */
	/* 이미지 없음(2024.04.07) */
	background-size: 30px 30px;
	background-position: 11px 8px;
	background-repeat: no-repeat;
}

#comment {
	/* background-image: url(http://rexkirby.com/kirbyandson/images/comment.svg); */
	/* 이미지 없음(2024.04.07) */
	background-size: 30px 30px;
	background-position: 11px 8px;
	background-repeat: no-repeat;
}

#rsrvMemo {
	/* background-image: url(http://rexkirby.com/kirbyandson/images/comment.svg); */
	/* 이미지 없음(2024.04.07) */
	background-size: 30px 30px;
	background-position: 11px 8px;
	background-repeat: no-repeat;
}

textarea {
	/* width: 100%; */
	/* width: 90%; */
	/* height: 150px; */
	/* height: 120px; */ /* 2024.04.07 modify */
	/* line-height: 150%; */
	/* line-height: 110%;  *//* 2024.04.07 modify */
	/* resize: vertical; */
}

input:hover, textarea:hover, input:focus, textarea:focus {
	background-color: white;
}

#button-blue {
	font-family: 'Montserrat', Arial, Helvetica, sans-serif;
	float: left; /* 플롯 중요(::after 가상요소 이용)*/
	width: 100%;
	border: #fbfbfb solid 4px;
	cursor: pointer;
	/* background-color: #3498db; */
	color: white;
	font-size: 24px;
	padding-top: 22px;
	padding-bottom: 22px;
	-webkit-transition: all 0.3s;
	-moz-transition: all 0.3s;
	transition: all 0.3s;
	margin-top: -4px;
	font-weight: 700;
}

#button-blue:hover {
	background-color: rgba(0, 0, 0, 0);
	color: #0493bd;
}

.ease {
	width: 0;
	height: 74px;
	background-color: #fbfbfb;
	-webkit-transition: .3s ease;
	-moz-transition: .3s ease;
	-o-transition: .3s ease;
	-ms-transition: .3s ease;
	transition: .3s ease;
}

.submit:hover .ease {
	width: 100%;
	background-color: white;
}

.ui-icon-gripsmall-diagonal-se
{
	background-color:#fff!important;
	border-radius: 50%; -moz-border-radius: 50%; -webkit-border-radius: 50%; -khtml-border-radius: 50%;
	background-image:url('resize.png')!important;
	background-position:center center;
	background-size: cover!important;
	-ms-transform: scale(2);
	-webkit-transform: scale(2);
	transform: scale(2);
}

/* modal title (일정관리) */
span#ui-id-1 {
    font-size: 14px;
}

#dialog #textareameno label {
  float: left; /* label을 왼쪽으로 띄웁니다. */
}

#dialog #textareameno textarea {
  margin-left: 55px;
}

</style>

<script type="text/javascript">
	$(()=> {
		$("header").css("position", "static");	
	});
</script>

<script type="text/javascript">
	//var isAdm = "${isAdm}";
	var isAdm = 1;
	var edit = false;
	if (isAdm == 1) {
		edit = true;
	}

	var diaLogOpt = {
		modal : true, ////모달대화상자
		resizable : false, ////크기 조절 못하게
		/* width : "570", // dialog 넓이 지정 */
		width : "515", // dialog 넓이 지정
		/* height: "470" */// dialog 높이 지정
		height : "380" // dialog 높이 지정
	};

	//=========================================== function ===========================================
	//calFunc[s]ojbect create start
	var calFunc = {
		calcDate : function(arg, calendar) {
			var rObj = new Object();

			var start = null;
			var end = null;
			var allDay = arg.allDay;
			var startDisp = null;
			var endDisp = null;
			var id = null;
			var xcontent = null;
			var title = null;
			//// 추가(2024.04.05)
			var groupId = null;
			var rsrvdate = null;   //// 2024.04.12 추가
			var rsrvname = null;
			var rsrvtelno = null;
			var rsrvtime = null;
			var rsrvinwon = null;
			var rsrvmemo = null;
			var writedate = null;

			//============================== date get / set ============================
			//// 그룹id(2024.02.04)
			//evnet 값들
			if (arg.groupId != "" && arg.groupId != null
					&& arg.groupId != undefined) {
				groupId = arg.groupId;
			}

			if (arg.id != "" && arg.id != null && arg.id != undefined) {
				id = arg.id;
			}
			
			if (arg.title != "" && arg.title != null && arg.title != undefined) {
				title = arg.title;
			}
			
			////console.log("custome : " + JSON.stringify(arg.extendedProps));

			//// event외에 값들
			if (arg.extendedProps != undefined) {
				
				if (arg._def.extendedProps.xcontent != ""
						&& arg._def.extendedProps.xcontent != null
						&& arg._def.extendedProps.xcontent != undefined) {
					xcontent = arg._def.extendedProps.xcontent;
				}

				//// 추가(2024.04.12) : 예약일자는 start 일자로 사용
				//if (arg.extendedProps.rsrvdate != ""
				//	&& arg.extendedProps.rsrvdate != null
				//	&& arg.extendedProps.rsrvdate != undefined) {
				//	rsrvdate = arg.extendedProps.rsrvdate;
				//}
				
				/// 추가(2024.04.05)
				//// 예약자명
				//console.log("예약자명2 : " + arg.rsrvname);
				if (arg.extendedProps.rsrvname != ""
						&& arg.extendedProps.rsrvname != null
						&& arg.extendedProps.rsrvname != undefined) {
					rsrvname = arg.extendedProps.rsrvname;
				}

				//// 연락처
				if (arg.extendedProps.rsrvtelno != ""
						&& arg.extendedProps.rsrvtelno != null
						&& arg.extendedProps.rsrvtelno != undefined) {
					rsrvtelno = arg.extendedProps.rsrvtelno;
				}

				//// 예약시간
				if (arg.extendedProps.rsrvtime != ""
						&& arg.extendedProps.rsrvtime != null
						&& arg.extendedProps.rsrvtime != undefined) {
					rsrvtime = arg.extendedProps.rsrvtime;
				}

				//// 인원
				if (arg.extendedProps.rsrvinwon != ""
						&& arg.extendedProps.rsrvinwon != null
						&& arg.extendedProps.rsrvinwon != undefined) {
					rsrvinwon = arg.extendedProps.rsrvinwon;
				}

				//// 메모
				if (arg.extendedProps.rsrvmemo != ""
						&& arg.extendedProps.rsrvmemo != null
						&& arg.extendedProps.rsrvmemo != undefined) {
					rsrvmemo = arg.extendedProps.rsrvmemo;
				}
				
				//console.log("cs : " + arg.extendedProps.rsrvmemo);
				
				/// 작성일자
				if (arg.extendedProps.writedate != ""
						&& arg.extendedProps.writedate != null
						&& arg.extendedProps.writedate != undefined) {
					writedate = arg.extendedProps.writedate;
				}

			}

			if (allDay) { //// 하루종일이면
				var start = arg.start.toISOString().slice(0, 10); //returnCdate(calendar,arg.start);
				//// 이벤트 변경시 처리
				rsrvdate = start;
				
				var end = null;
				if (arg.end != "" && arg.end != null && arg.end != undefined) {
					end = arg.end.toISOString().slice(0, 10); //// 실제 데이터는 날짜를 하루 빼지 않는다 
				}

				if (start == end) { //// 같은날이면 end날짜 없음
					end = null;
				}
				startDisp = start;

				if (end != null) { //// 알릴 때만 날짜 하루 빼기
					endDisp = dateRel(arg.end.toISOString().slice(0, 10));
				}
			} else { //// 시간이 같이 들어오면
				start = arg.start.toISOString();
				rsrvdate = arg.start.toISOString().slice(0, 10);  //// 예약일자 설정(2024.04.12)
				
				if (arg.end != "" && arg.end != null && arg.end != undefined) {
					end = arg.end.toISOString();
				}

				startDisp = returnCdate(calendar, arg.start);

				if (end != null) {
					endDisp = returnCdate(calendar, arg.end);
				}
			}

			/////////////////////////////////////////////////////////
			/////////////////////////////////////////////////////////
			rObj.groupId = groupId; /* 2024.04.05 add */
			rObj.start = start;
			rObj.end = end;
			rObj.startDisp = startDisp;
			rObj.endDisp = endDisp;
			rObj.id = id;
			rObj.xcontent = xcontent;
			rObj.title = title;

			/// add(2024.04.05)
			rObj.rsrvdate  = rsrvdate;
						

			rObj.rsrvname = rsrvname;
			rObj.rsrvtelno = rsrvtelno;
			rObj.rsrvtime = rsrvtime;
			rObj.rsrvinwon = rsrvinwon;
			rObj.rsrvmemo = rsrvmemo;
			rObj.writedate = writedate;

			//============================== date get / set ======================================
			return rObj;
		},
		//// 등록 초기
		setDateRangeView : function(xobj) {

			var dispStr = xobj.startDisp;

			if (xobj.endDisp != null) {
				dispStr += " ~ " + xobj.endDisp;
			}

			$("form#diaForm").find("input[name='actType']").val("C"); //// 등록

			$("form#diaForm").find("input[name='rsrvDate']").val(xobj.start.substring(0, 10)); //// 예약일자
			
		},
		//// form안에 name값을 $obj에 주입
		getFormValue : function() {
			var $dForm = $("form#diaForm");

			var $obj = new Object();

			/////////////////////////////////////////////////////////////////////
			//// object 값 생성하기
			/////////////////////////////////////////////////////////////////////
			$("form#diaForm")
					.find("input,textarea,select")
					.not(
							"input[name='actType'], input[name='id'], input[name='xwriteDate']")
					.each(function() {
						var xval = $(this).val();

						$obj[$(this).attr("name")] = xval;
					});

			return $obj;
		},
		//// 모든 태그 비활성화
		formDsbTrue : function() {
			$("form#diaForm").find("input,textarea,select").each(function() {
				$(this).attr("disabled", true);
			});
		},

		//// 모든 태그 활성화
		formDsbFalse : function() {
			$("form#diaForm").find("input,textarea,select").each(function() {
				$(this).attr("disabled", false);
			});
		},
		//// 데이터 조회
		setDataForm : function(xobj) {

			var dispStr = xobj.startDisp;

			if (xobj.endDisp != null) {
				dispStr += " ~ " + xobj.endDisp;
			}

			$("form#diaForm").find("input[name='actType']").val("U"); //// 수정

			$("form#diaForm").find("input[name='rsrvNum']").val(xobj.groupId); ////번호 = groupId
			////$("form#diaForm").find("input[name='rsrvDate']").val(xobj.start); ////예약일자 = start
			$("form#diaForm").find("input[name='rsrvDate']").val(xobj.rsrvdate); ////예약일자 = rsrvdate(2024.04.12 변경)
			$("form#diaForm").find("input[name='rsrvName']").val(xobj.rsrvname); //// 예약자명
			$("form#diaForm").find("input[name='rsrvTelno']").val(xobj.rsrvtelno); //// 연락처
			$("form#diaForm").find("input[name='rsrvTime']").val(xobj.rsrvtime); //// 예약시간
			$("form#diaForm").find("input[name='rsrvInwon']").val(xobj.rsrvinwon); //// 예약인원
			$("form#diaForm").find("input[name='rsrvSubject']").val(xobj.title); //// 제목
			$("form#diaForm").find("textarea[name='rsrvMemo']").val(xobj.rsrvmemo);
			$("form#diaForm").find("input[name='xwriteDate']").val(xobj.writedate); /// 작성일자
		}
	};
	//calFunc[e]---- ojbect create end

	//////////////////////////////////////////////////
	//// 등록 액션
	//////////////////////////////////////////////////
	function createClnd(cal, xobj) {
		//// 등록을 위해서 넘겨줘야 할 값
		var $obj = calFunc.getFormValue();
		
		//// 필수 입력 사항 check..
		if ($obj.rsrvName == "" || $obj.rsrvName == "undefined" || $obj.rsrvName == null) {
			alert("예약자명을 입력하세요.");
			return false;
		}
		
		if ($obj.rsrvTelno == "" || $obj.rsrvTelno == "undefined" || $obj.rsrvTelno == null) {
			alert("연락처를 입력하세요.");
			return false;
		}
		
		if ($obj.rsrvTime == "" || $obj.rsrvTime == "undefined" || $obj.rsrvTime == null) {
			alert("시간을 입력하세요.");
			return false;
		}

		//// 시간 : 문자열 길이 체크
		var time_length_chk = $obj.rsrvTime.replace(/:/g, '');
		if (time_length_chk.length < 4) {
			alert("시간은 숫자 4자리를 입력하세요.");
			return false;
		}
		
		if ($obj.rsrvSubject == "" || $obj.rsrvSubject == "undefined" || $obj.rsrvSubject == null) {
			alert("제목을 입력하세요.");
			return false;
		}

		if (!confirm("일정을 등록 하시겠습니까?")) {
			return false;
		}
		
		$.ajax({
			url : "rsrvinsert.do",
			type : "POST",
			contentType : "application/json;charset=UTF-8",
			data : JSON.stringify($obj)
		}).done(function(data) {
			var result = jQuery.parseJSON(data);

			////모든 소스에서 이벤트를 다시 가져와 화면에 다시 렌더링
			cal.refetchEvents();

		}).fail(function(e) {
			alert("실패하였습니다." + e);
		}).always(function() {
			/////////////////////////////////////////////
			//// popup 화면 값 초기화
			/////////////////////////////////////////////
			funDiaFormClear();
		});
		
		return true;
	}

	//////////////////////////////////////////////////
	//// 수정 액션
	//////////////////////////////////////////////////
	function updateClnd(cal, xobj, event) {
		//// 수정을 위해서 넘겨줘야 할 값
		var $obj = calFunc.getFormValue();
		
		//// 필수 입력 사항 check..
		if ($obj.rsrvName == "" || $obj.rsrvName == "undefined" || $obj.rsrvName == null) {
			alert("예약자명을 입력하세요.");
			return false;
		}
		
		if ($obj.rsrvTelno == "" || $obj.rsrvTelno == "undefined" || $obj.rsrvTelno == null) {
			alert("연락처를 입력하세요.");
			return false;
		}
		
		if ($obj.rsrvTime == "" || $obj.rsrvTime == "undefined" || $obj.rsrvTime == null) {
			alert("시간을 입력하세요.");
			return false;
		}
		
		//// 시간 : 문자열 길이 체크
		var time_length_chk = $obj.rsrvTime.replace(/:/g, '');
		if (time_length_chk.length < 4) {
			alert("시간은 숫자 4자리를 입력하세요.");
			return false;
		}
		
		if ($obj.rsrvSubject == "" || $obj.rsrvSubject == "undefined" || $obj.rsrvSubject == null) {
			alert("제목을 입력하세요.");
			return false;
		}
		
		if (!confirm("해당 일정을 정말로 수정 하시겠습니까?")) {
			if (event != undefined) {
				alert("이벤트 처리 되돌리기 : ");
				event.revert();  /// 이전 상태로 되돌리는 작업을 합니다.
			}
			return false;
		}

		$.ajax({
			url : "rsrvupdate.do",
			type : "POST",
			contentType : "application/json;charset=UTF-8",
			data : JSON.stringify($obj)
		}).done(function(data) {
			var result = jQuery.parseJSON(data);

			cal.refetchEvents();

		}).fail(function(e) {
			alert("실패하였습니다." + e);
		}).always(function() {
			/////////////////////////////////////////////
			//// popup 화면 값 초기화
			/////////////////////////////////////////////
			funDiaFormClear();
		});
		
		return true;
	}
	///////////////////////////////////////////////////
	/// 삭제 액션
	///////////////////////////////////////////////////
	function deleteClnd(cal, xobj) {
		if (!confirm("해당일정을 정말로 삭제 하시겠습니까?")) {
			return false;
		}

		var $obj = calFunc.getFormValue();

		$.ajax({
			url : "rsrvdelete.do",
			type : "POST",
			contentType : "application/json;charset=UTF-8",
			data : JSON.stringify($obj)
		}).done(function(data) {
			var result = jQuery.parseJSON(data);
			cal.refetchEvents();
		}).fail(function(e) {
			alert("실패하였습니다." + e);
		}).always(function() {
			/////////////////////////////////////////////
			//// popup 화면 값 초기화
			/////////////////////////////////////////////
			funDiaFormClear();
		});
	}

	/// modal popu 화면 값 clear(2024.04.05)
	function funDiaFormClear() {
		$("#id").val("");
		$("#rsrvNum").val(""); //// 예약번호
		$("#rsrvDate").val(""); //// 예약일자  
		$("#rsrvName").val(""); //// 예약자명
		$("#rsrvTelno").val(""); //// 연락처
		$("#rsrvTime").val(""); //// 예약시간
		$("#rsrvInwon").val("1"); //// 인원(기본값 1)
		$("#rsrvSubject").val(""); //// 제목
		$("#rsrvMemo").val(""); //// 메모
		$("#xwriteDate").val(""); //// 작성일자
	}

	//// 핸드폰번호 유효성 체크
    $(function() {
        $("#rsrvTelno").blur(function() {
            // 입력된 전화번호 가져오기
            var phoneNumber = $("#rsrvTelno").val();
            if(phoneNumber) {
                // 정규식을 사용하여 형식 검사
                var regex = /^(01[0-9]{1}-?[0-9]{4}-?[0-9]{4}|01[0-9]{8})$/;

                if (regex.test(phoneNumber)) {
                    // 올바른 형식일 경우
                } else {
                    // 잘못된 형식일 경우
                    alert("잘못된 형식의 전화번호 입니다.");
                    $("#rsrvTelno").val("");
                    this.focus();
                    return false;
                }

                var pcs = phoneNumber;

                // 입력된 문자열에서 하이픈('-')을 제거하여 숫자만 추출
                var pcs = pcs.replace(/[^0-9]/g, '');

                // 전화번호 형식 (010-1234-5678)으로 변환
                if (pcs.length === 10) {
                    pcs = pcs.substring(0, 3) + '-' + pcs.substring(3, 7) + '-' + pcs.substring(7, 11);
                } else if (pcs.length === 11) {
                    pcs = pcs.substring(0, 3) + '-' + pcs.substring(3, 7) + '-' + pcs.substring(7, 11);
                }

                $("#rsrvTelno").val(pcs);
            }
        });
        
        //// 시간
        $("#rsrvTime").blur(function() {
            // 입력된 전화번호 가져오기
            var reserveTime = $("#rsrvTime").val();
            
            if (reserveTime) {
                // 정규식을 사용하여 형식 검사
                var regex = /^(?:[01]?[0-9]|2[0-3])(?::?[0-5]?[0-9])?$/;

                if (regex.test(reserveTime)) {
                    // 올바른 형식일 경우
                } else {
                    // 잘못된 형식일 경우
                    alert("잘못된 형식의 시간 입니다.");
                    $("#rsrvTime").val("");
                    this.focus();
                    return false;
                }

                var timecnv = reserveTime;

                // 입력된 문자열에서 하이픈(':')을 제거하여 숫자만 추출
                var timecnv = timecnv.replace(/[^0-9]/g, '');

				// 시간 형식 (09:00)으로 변환
                if (timecnv.length === 3) {
					timecnv = timecnv.substring(0, 2) + ':' + timecnv.substring(2, 4);
                } else if (timecnv.length === 4) {
                    timecnv = timecnv.substring(0, 2) + ':' + timecnv.substring(2, 4);
                }

                $("#rsrvTime").val(timecnv);
            } else {
				this.focus();
				return false;
            }
        });
        
    });
    
	//=========================================== function =========================================== 

	//// 관리자만 ,주,일 옵션 뷰
	var rightm = "";
	rightm += ',listWeek'; /// 주일정 보이게 하기 위한 설정(2024.04.03 comment 처리)

	////////////////////////////////////////////////////////
	//// 달력 생성 [s]
	////////////////////////////////////////////////////////

	//////////////////////////////////////////////////////////////////
	//// DOMContentLoaded Event DOM Tree가 모두 로딩된 이후에 발생하는 이벤트
	//////////////////////////////////////////////////////////////////
	document.addEventListener('DOMContentLoaded', function() {

		var calendarEl = document.getElementById('calendar');

		var calendar = new FullCalendar.Calendar(calendarEl, {
			headerToolbar : {
				left : 'prev, next today',
				center : 'title',
				right : 'dayGridMonth' + rightm
			},
			allDay : false,
			theme : true,
			themeSystem : 'bootstrap',
			locale : 'ko',
			timeZone : 'Asia/Seoul',
			navLinks : true, //// can click day/week names to navigate views
			selectable : true,
			selectMirror : true,
			select : function(arg) {
				if (isAdm == 0) {
					return false;
				}

				var xObj = calFunc.calcDate(arg, calendar); //// get event data

				//================ dialog 옵션 추가 ===================
				var btnOpt = {
					"저장" : function() {
						//////////////////////////////////////////////
						//////////////////////////////////////////////
						var result = false;
						result = createClnd(calendar, xObj); //// 저장 클릭시 액션 함수
						if (result == true) {
							$(this).dialog("close");
						}
					},
					"취소" : function() {
						$(this).dialog("close");
					}
				}

				var dOpt = diaLogOpt;
				dOpt.buttons = btnOpt;

				//////////////////////////////////////////////////////////////////
				/// object clear
				//////////////////////////////////////////////////////////////////
				funDiaFormClear();

				//================ dialog 옵션 추가 ===================
				//calFunc.formDsbFalse(); //// Form data disabeld false

				$('#dialog').dialog(dOpt); //// 다이얼로그 오픈

				calFunc.setDateRangeView(xObj); //// SET Form data

				calendar.unselect();
			},
			/////////////////////////////////////////////////////////////
			//// 클릭 함수 [s]
			/////////////////////////////////////////////////////////////
			eventClick : function(calEvent, jsEvent) {

				var xObj = calFunc.calcDate(calEvent.event, calendar); //// get event data

				//console.log("이벤트 : " + JSON.stringify(calEvent));

				//================ dialog 옵션 추가 ===================
				var btnOpt = {
					"삭제" : function() {
						deleteClnd(calendar, xObj); //삭제클릭시 액션 함수
						$(this).dialog("close");
					},
					"수정" : function() {
						var result = false;
						
						result = updateClnd(calendar, xObj); //// 수정 클릭시 액션 함수
						
						if (result == true) {
							$(this).dialog("close");
						}
					},
					"닫기" : function() {
						$(this).dialog("close");
					}
				}
				//================ dialog 옵션 추가 ===================

				//======================관리자 =======================
				if (isAdm == 1) {
					calFunc.formDsbFalse(); //Form data disabeld false
				} else {
					calFunc.formDsbTrue(); //// Form data disabeld true
					delete btnOpt['수정']; //// 일반사용자 수정 히든 처리
					delete btnOpt['삭제']; //// 일반사용자 삭제 히든 처리
				}

				//======================관리자 =======================

				//================ dialog 옵션 추가 ===================
				var dOpt = diaLogOpt;
				dOpt.buttons = btnOpt;
				//================ dialog 옵션 추가 ===================

				//================ 실행  ===================
				$("#dialog").dialog(dOpt); //// 다이얼로그 오픈
				calFunc.setDataForm(xObj); //// SET Form Data

				//================ 실행 ===================
			},
			//// 클릭 함수 [e]
			editable : edit, //관리자 외 false
			eventOrder : "displayOrder", //// 일정을 sql 조회 순서로 적용
			dayMaxEvents : true, //// allow "more" link when too many events 
			//// 새로운 이벤트 데이터가 필요할 때마다 이 함수를 호출 (데이터 조회)
			events : function(fetchInfo, successCallback, failureCallback) {
				var start = fetchInfo.start.toISOString().slice(0, 7);
				var end = fetchInfo.end.toISOString().slice(0, 7);

				var start2 = fetchInfo.start.toISOString().slice(0, 10);
				var end2 = fetchInfo.end.toISOString().slice(0, 10);
				var param = "";

				param += "start=" + start2;
				param += "&end=" + end2;

				$.ajax({
					url : "rsrvlist.do",
					type : "POST",
					data : param
				}).done(function(data) {
					var result = jQuery.parseJSON(data);

					//console.log("값 : " + JSON.stringify(result));

					successCallback(result.list);

				}).fail(function(e) {
					alert("실패하였습니다." + e);
				}).always(function() {
					/////////////////////////////////////////////////////
					/////////////////////////////////////////////////////
				});
			},
			eventDrop : function(info) {
				var xObj = calFunc.calcDate(info.event, calendar); //// get event data

				calFunc.setDataForm(xObj); //// Set Form Data

				updateClnd(calendar, xObj, info);

			},
			eventResize : function(info) {
				var xObj = calFunc.calcDate(info.event, calendar); //// get event data

				calFunc.setDataForm(xObj); //// Set Form Data

				updateClnd(calendar, xObj, info);
			},
			eventTimeFormat : {
				hour : '2-digit',
				minute : '2-digit',
				hour12 : false
			},
		});

		calendar.render();

		$("span.fa-chevron-left").html("이전달");
		$("span.fa-chevron-right").html("다음달");

	});
	//////////////////////////////////////////////////////////////////
	//// 달력 생성 [e]-end
	//////////////////////////////////////////////////////////////////

	//// 특정일자 하루전
	function dateRel(date) {
		var selectDate = date.split("-");
		var changeDate = new Date();

		changeDate.setFullYear(selectDate[0], selectDate[1] - 1, selectDate[2] - 1);

		var y = changeDate.getFullYear();
		var m = changeDate.getMonth() + 1;
		var d = changeDate.getDate();

		if (m < 10) {
			m = "0" + m;
		}

		if (d < 10) {
			d = "0" + d;
		}
		var resultDate = y + "-" + m + "-" + d;

		return resultDate;
	}

	function returnCdate(cal, time) {
		return cal.formatDate(time, {
			month : 'long',
			year : 'numeric',
			day : 'numeric',
			hour : 'numeric',
			minute : 'numeric',
			timeZone : 'Asia/Seoul',
			locale : 'ko'
		});
	}
	
	//// 입력 모드 설정 함수(2024.04.11)
	function setLanguage(language) {
	    if (language === 'ko') {
	        document.getElementById("rsrvName").lang = "ko"; //// 한글 입력 모드로 설정
	    } else if (language === 'en') {
	        ////document.getElementById("email").lang = "en"; //// 영문 입력 모드로 설정
	    }
	}
</script>
<title>RERVATION-Calendar</title>
</head>
<body>
	<c:import url="/WEB-INF/views/common/header.jsp" />
	<div class="section-container">
		<%-- section1 --%>
		<section class="sec1">
			<div class="inner-section">
				<div id="contents">
					<div id="dialog" title="일정 관리" style="display: none;">
						<div id="form-div">
							<form class="diaForm" id="diaForm">
								<div>
									<input type="hidden" name="actType" value="C" />
									<!-- C:등록 U:수정 D:삭제 -->
									<input type="hidden" name="rsrvNum" id="rsrvNum" value="" />
								</div>
								<div>
									<label for="rsrvDate" style="width: 80px;">예약일자</label> 
									<input type="text" name="rsrvDate" id="rsrvDate" class="input-field" readonly="readonly" disabled style="border:none;"/>
								</div>
								<div>
									<label for="rsrvName" style="width: 80px;">예약자명</label>
									<input type="text" name="rsrvName" id="rsrvName" class="input-field" maxlength="10" required onfocus="setLanguage('ko')"> <!-- 한글 입력 모드로 설정 -->
								</div>
								<div>
									<label for="rsrvTelno" style="width: 80px">연락처</label>
									<input type="text" name="rsrvTelno" id="rsrvTelno" class="input-field" maxlength="13" placeholder="010-1234-5678" />
								</div>
								<div>
									<label for="rsrvTime" style="width: 80px;">예약시간</label>
									<input type="text"   name="rsrvTime" id="rsrvTime" class="input-field" maxlength="5" placeholder="10:00" />
								</div>
								<div>
									<label for="rsrvInwon" style="width: 80px">인원</label>
									<input type="number" name="rsrvInwon" id="rsrvInwon" class="input-field" min="1" max="10" />
									<script type="text/javascript">
										document.getElementById("rsrvInwon").addEventListener("input", function() {
										    var maxDigits = 2; //// 최대 입력 길이
										    if (this.value.length > maxDigits) {
										        this.value = this.value.substring(0, maxDigits); //// 최대 길이를 초과하는 경우 입력을 제한합니다.
										    }
										});
									</script>
								</div>
								<div>
									<label for="rsrvSubject" style="width: 80px">제목</label>
									<input type="text" name="rsrvSubject" id="rsrvSubject" class="input-field" maxlength="20" />
								</div>
								<div id="textareameno">
									<label for="rsrvMemo">메모</label>
									<textarea name="rsrvMemo" id="rsrvMemo" class="textarea-field" rows="4" cols="50" maxlength="50" onfocus="setLanguage('ko')"></textarea>
								</div>
								<div>
									<label for="xwriteDate" style="width: 80px;">작성일자</label>
									<input type="text" name="xwriteDate" id="xwriteDate" class="input-field"  style="border:none;"/>
								</div>
							</form>
						</div>
					</div>
					<br />
					<div id='calendar'></div>
				</div>
			</div>
		</section>
	</div>

</body>
</html>
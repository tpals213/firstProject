/**
 * 
 */
 
 $(function() {
		//해당 유저의 불편사항 최신순 5개 조회
		$.ajax({
					url : "inconvtop5.do",
					type : "post",
					dataType : "json",
					data: { id: $("#loginUserId").val()},
					success : function(data) {
						console.log("success : " + data);
						//object --> string
						var str = JSON.stringify(data);
						//string --> json
						var json = JSON.parse(str);
						var string = "";
						values = "";
						for ( var i in json.ilist) {
							if (json.ilist[i].status == '1') {
								string = "조치전"
							} else if (json.ilist[i].status == '2') {
								string = "조치중"
							} else {
								string = "조치완료"
							}
							;
							values += "<tr onclick='javascript:location.href=\"inconvdetail.do?ino="
									+ json.ilist[i].ino
									+ "\";'><td>"
									+ decodeURIComponent(json.ilist[i].ititle)
											.replace(/\+/gi, " ")
									+ "</td><td>"
									+ string + "</td></tr>";
						}
						// 결과가 5개 미만일 때 빈 행을 추가하여 총 5개의 행
						for (var j = json.ilist.length; j < 5; j++) {
							values += "<tr><td>&nbsp;</td><td>&nbsp;</td></tr>";
						}

						$('#inconvinienceUser').html(
								$('#inconvinienceUser').html() + values);
					},
					error : function(jqXHR, textStatus, errorThrown) {
						console.log("error : " + jqXHR + ", " + textStatus
								+ ", " + errorThrown);
					}
				});
				$.ajax({
					url : "inconvtop10.do",
					type : "post",
					dataType : "json",
					success : function(data) {
						console.log("success : " + data);

						//object --> string
						var str = JSON.stringify(data);

						//string --> json
						var json = JSON.parse(str);
						var string = "";
						values = "";
						for ( var i in json.ilist) {
							if (json.ilist[i].status == '1') {
								string = "조치전"
							} else if (json.ilist[i].status == '2') {
								string = "조치중"
							} else {
								string = "조치완료"
							}
							;
							values += "<tr onclick='javascript:location.href=\"inconvdetail.do?ino="
									+ json.ilist[i].ino
									+ "\";'><td>"
									+ decodeURIComponent(json.ilist[i].ititle)
											.replace(/\+/gi, " ")
									+ "</td><td>"
									+ json.ilist[i].iwriter
									+ "</td><td>"
									+ string + "</td></tr>";
						}
						// 결과가 10개 미만일 때 빈 행을 추가하여 총 10개의 행
						for (var j = json.ilist.length; j < 10; j++) {
							values += "<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>";
						}

						$('#inconvinienceAdmin').html(
								$('#inconvinienceAdmin').html() + values);
					},
					error : function(jqXHR, textStatus, errorThrown) {
						console.log("error : " + jqXHR + ", " + textStatus
								+ ", " + errorThrown);
					}
				});
	});//document ready
	//그래프그리기
$(function() {
		// 현재 년도 구하기
		var currentYear = new Date().getFullYear();

		// 그래프 그리기 함수 호출
		drawVisualization(currentYear);

		// 왼쪽 버튼 클릭 시 이벤트 처리
		$("#leftButton").click(function() {
			currentYear -= 1; // 현재 년도에서 1을 빼기
			drawVisualization(currentYear); // 그래프 다시 그리기
		});

		// 오른쪽 버튼 클릭 시 이벤트 처리
		$("#rightButton").click(function() {
			currentYear += 1; // 현재 년도에서 1을 더하기
			drawVisualization(currentYear); // 그래프 다시 그리기
		});

		function drawVisualization(year) {
			$.ajax({
				url : "countUser.do",
				type : "post",
				data : {
					year : year
				},
				dataType : "json",
				success : function(data) {
					var countMap = data.countMap;
					var countSubMap = data.countSubMap;
					var calculateSalesMap = data.salesMap;
					google.charts.load('current', {
						'packages' : [ 'corechart' ]
					});
					google.charts.setOnLoadCallback(function() {
						drawChart(countMap, countSubMap, year);
						drawChart2(calculateSalesMap, year);
					});
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log("error : " + jqXHR + ", " + textStatus + ", "
							+ errorThrown);
				}
			});
		}

		function drawChart(countMap, countSubMap, year) {
			var data = google.visualization.arrayToDataTable([
					[ 'Month', '가입자 수', '결제 수' ],
					[ '01', parseInt(countMap["01"]),
							parseInt(countSubMap["01"]) ],
					[ '02', parseInt(countMap["02"]),
							parseInt(countSubMap["02"]) ],
					[ '03', parseInt(countMap["03"]),
							parseInt(countSubMap["03"]) ],
					[ '04', parseInt(countMap["04"]),
							parseInt(countSubMap["04"]) ],
					[ '05', parseInt(countMap["05"]),
							parseInt(countSubMap["05"]) ],
					[ '06', parseInt(countMap["06"]),
							parseInt(countSubMap["06"]) ],
					[ '07', parseInt(countMap["07"]),
							parseInt(countSubMap["07"]) ],
					[ '08', parseInt(countMap["08"]),
							parseInt(countSubMap["08"]) ],
					[ '09', parseInt(countMap["09"]),
							parseInt(countSubMap["09"]) ],
					[ '10', parseInt(countMap["10"]),
							parseInt(countSubMap["10"]) ],
					[ '11', parseInt(countMap["11"]),
							parseInt(countSubMap["11"]) ],
					[ '12', parseInt(countMap["12"]),
							parseInt(countSubMap["12"]) ] ]);

			var options = {
				title : year + '년도 월간 이용자수/가입자수 추이',
				vAxis : {
					title : 'Users'
				},
				hAxis : {
					title : 'Month'
				},
				seriesType : 'bars'
			};

			var chart = new google.visualization.ComboChart(document
					.getElementById('chart_div'));
			chart.draw(data, options);
		}
		function drawChart2(calculateSalesMap, year) {
			var data = google.visualization.arrayToDataTable([
					[ 'Month', '매출'],
					[ '01', parseInt(calculateSalesMap["01"])],
					[ '02', parseInt(calculateSalesMap["02"])],
					[ '03', parseInt(calculateSalesMap["03"])],
					[ '04', parseInt(calculateSalesMap["04"])],
					[ '05', parseInt(calculateSalesMap["05"])],
					[ '06', parseInt(calculateSalesMap["06"])],
					[ '07', parseInt(calculateSalesMap["07"])],
					[ '08', parseInt(calculateSalesMap["08"])],
					[ '09', parseInt(calculateSalesMap["09"])],
					[ '10', parseInt(calculateSalesMap["10"]) ],
					[ '11', parseInt(calculateSalesMap["11"]) ],
					[ '12', parseInt(calculateSalesMap["12"])]
						]);

			var options = {
				title : year + '년도 월별 매출',
				vAxis : {
					title : 'Sales'
				},
				hAxis : {
					title : 'Month'
				},
				seriesType : 'bars'
			};

			var chart = new google.visualization.ComboChart(document
					.getElementById('chart_div2'));
			chart.draw(data, options);
		}
	});	
	

      
      google.charts.load('current', {'packages':['corechart']});

      google.charts.setOnLoadCallback(drawChart3);

      function drawChart3() {

		var monthlyPdPrice = document.getElementById('monthlyPdPrice').textContent;
		var monthlyRent = document.getElementById('monthlyRent').textContent;
		var monthlyTax = document.getElementById('monthlyTax').textContent;
		var monthlyCost = document.getElementById('monthlyCost').textContent;
		var monthlySales = document.getElementById('monthlySales').textContent;
		var profit = monthlySales - monthlyPdPrice - monthlyRent - monthlyTax - monthlyCost;
	
        var data = new google.visualization.DataTable();
        data.addColumn('string', '항목');
        data.addColumn('number', '금액');
        data.addRows([
        
          ['매출', parseInt(monthlySales)],
          ['발주액', parseInt(monthlyPdPrice)],
          ['월세', parseInt(monthlyRent)],
          ['세금', parseInt(monthlyTax)],
          ['기타비용', parseInt(monthlyCost)],
          ['수익', parseInt(profit)]
        ]);

        // Set chart options
       var options = {
	        'title': '월 매출',
	        'width': 600,
	        'height': 400// 각 항목의 색상을 지정합니다.
	    };


        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.BarChart(document.getElementById('chart_div_sale'));
        chart.draw(data, options);
      }
      
      google.charts.load('current', {packages: ['corechart', 'line']});
google.charts.setOnLoadCallback(drawAxisTickColors);

function drawAxisTickColors() {
      var data = new google.visualization.DataTable();
      data.addColumn('number', 'X');
      data.addColumn('number', '수익');
      data.addColumn('number', '매출');

      data.addRows([  
        [1, 10, 5],   
        [2, 23, 15],  
        [3, 17, 9],   
        [4, 18, 10],  
        [5, 9, 5],
        [6, 11, 3],   
        [7, 27, 19],  
        [8, 33, 25],  
        [9, 40, 32],  
        [10, 32, 24], 
        [11, 35, 27],
        [12, 30, 22]
      ]);

      var options = {
        hAxis: {
          title: '월',
          width: 600,
	      height: 400,
          textStyle: {
            color: 'black',
            fontSize: 20,
            fontName: 'Arial',
            bold: true,
            italic: true
          },
          titleTextStyle: {
            color: 'black',
            fontSize: 16,
            fontName: 'Arial',
            bold: true,
            italic: true
          },
          ticks: [1, 6, 12]
        },
        vAxis: {
          title: '금액',
          textStyle: {
            color: 'black',
            fontSize: 20,
            bold: true
          },
          titleTextStyle: {
            color: 'black',
            fontSize: 16,
            bold: true
          }
        },
        colors: ['#a52714', '#097138']
      };
      var chart = new google.visualization.LineChart(document.getElementById('chart_div_year'));
      chart.draw(data, options);
    }
      
// 발주액 가져오기
function onChangeMonth() {  
    var jarr = new Array();
    var job = new Object();
    
    var selectElement = document.getElementById("monthSelect");
    var month = selectElement.value; 
    
    job.id = document.getElementById("idDisplay").textContent;
    job.month = month;
    
    jarr.push(job);
    
            $.ajax({
                type: "POST",
                url: "monthlyPdPrice.do",
                data: JSON.stringify(jarr),
                contentType: "application/json; charset=utf-8",
                success: function(result) {
                	var spanElement = document.getElementById("monthlyPdPrice");
                    spanElement.textContent = result;
                },
                error: function(request, status, errorData) {
                    console.log("error code : " + request.status
                        + "\nMessage : " + request.responseText
                        + "\nError : " + errorData);
                } 
            });   
            
            // input 값에 값 넣기
            $.ajax({
                type: "POST",
                url: "monthlyCost.do",
                data: JSON.stringify(jarr),
                contentType: "application/json; charset=utf-8",
                success: function(response) {
                	var dataArray = JSON.parse(response); // JSON 배열을 JavaScript 배열로 변환
            
            // 변수 초기화
            var monthlySales = 0;
            var monthlyPdPrice = document.getElementById("monthlyPdPrice").textContent;
            var monthlyTax = 0;
            var monthlyRent = 0;
            var monthlyCost = 0;

            // 값 설정
            for (var i = 0; i < dataArray.length; i++) {
                var data = dataArray[i];
                if (data.monthlycost !== undefined) {
                    monthlyCost = data.monthlycost;
                    document.getElementById("monthlyCost").textContent = monthlyCost;
                }
                if (data.monthlytax !== undefined) {
                    monthlyTax = data.monthlytax;
                    document.getElementById("monthlyTax").textContent = monthlyTax;
                }
                if (data.monthlyrent !== undefined) {
                    monthlyRent = data.monthlyrent;
                    document.getElementById("monthlyRent").textContent = monthlyRent;
                }
                if (data.monthlysale !== undefined) {
                    monthlySales = data.monthlysale;
                    document.getElementById("monthlySales").textContent = monthlySales;
                }
            }

            // 수익 계산
            var profit = monthlySales - monthlyPdPrice - monthlyTax - monthlyRent - monthlyCost;
            document.getElementById("profit").textContent = profit;

            drawChart3();
        },
        error: function(request, status, errorData) {
            console.log("error code : " + request.status
                + "\nMessage : " + request.responseText
                + "\nError : " + errorData);
        } 
    }); 
}
      
      
      // 지금 년월 자동 선택
      window.onload = function() {
        var today = new Date();
        var year = today.getFullYear();
        var month = today.getMonth() + 1; // getMonth()는 0부터 시작하므로 1을 더해줍니다.
        var monthString = month < 10 ? '0' + month : '' + month; // 달이 한 자리 수일 경우 앞에 0을 추가합니다.
        var currentMonthYear = year + '-' + monthString;
        var selectElement = document.getElementById('monthSelect');
        var options = selectElement.options;
        for (var i = 0; i < options.length; i++) {
            if (options[i].value === currentMonthYear) {
                options[i].selected = true;
                break;
            }
        }
        onChangeMonth();
    };
$(function(){
	if($("#message").val().length>0){
				alert($("#message").val());
			}
});
$(function() {
			$('tr').click(function(){
			// 클릭한 행의 체크박스 상태를 변경
			var checkbox = $(this).find(
					'input[type="checkbox"]');
			checkbox.prop("checked", !checkbox
					.prop("checked"));
			// 다른 행의 체크박스 상태를 모두 해제
			$('tr').not(this).find(
					'input[type="checkbox"]').prop(
					"checked", false);
		});
			// 이미지를 클릭했을 때 선택 토글 기능 구현
	        $('img').click(function() {
	            // 이미지 선택 상태를 토글
	            $(this).toggleClass('selected');
	            
	            // 선택된 이미지 외에는 선택 상태를 해제
	            $('img').not(this).removeClass('selected');
	        });
			});//document ready
function checkAgreements() {
        var option1 = document.getElementById('option-1-checkbox');
        var option2 = document.getElementById('option-2-checkbox');
        var option3 = document.getElementById('option-3-checkbox');

        if (!option1.checked||!option2.checked||!option3.checked) {
        	alert('약관을 모두 동의해주세요');
        	return false;
        }
        return true;
    }

			
function pay(){
		var productsSelected = false;
        var paymentMethodSelected = false;

        // 상품 선택 여부 확인
        var productCheckboxes = document.querySelectorAll('input[type="checkbox"]');
        for (var i = 0; i < productCheckboxes.length; i++) {
            if (productCheckboxes[i].checked) {
                productsSelected = true;
                break;
            }
        }

        // 결제 방법 선택 여부 확인
        var paymentImages = document.querySelectorAll('#payment-method img');
        for (var i = 0; i < paymentImages.length; i++) {
            if (paymentImages[i].classList.contains('selected')) {
                paymentMethodSelected = true;
                break;
            }
        }

        if (!productsSelected) {
            // 상품이 선택되지 않았을 때
            alert("상품을 선택해주세요.");
            return;
        }

        if (!paymentMethodSelected) {
            // 결제 방법이 선택되지 않았을 때
            alert("결제 방법을 선택해주세요.");
            return;
        }
		if(checkAgreements()){
		var firstPaymentFlag = false;
        var IMP = window.IMP; // 생략가능
        IMP.init('imp71144855'); 
        var msg;
        var paymentMethod = $('img.selected').data('payment-method');
     // 선택된 행에서 체크박스를 찾음
        var selectedRow = $('tr').has('input[type="checkbox"]:checked');
        var userId = $('#userId').val();
        var id = $('#id').val();
        // 선택된 행에서 가격 열을 찾음
        var subscribeNo = selectedRow.find('td:eq(1)').text();
		var subscribeName = selectedRow.find('td:eq(2)').text();
        var priceColumn = selectedRow.find('td:eq(3)'); // 0부터 시작하므로 4번째 열을 선택    
        // 해당 가격 열에서 가격 값을 가져옴
        var price = priceColumn.text();
        IMP.request_pay({
            pg : paymentMethod,
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : subscribeName,
            amount : price,
            customer_id : id,
            buyer_email : $('#email').val(),
            buyer_name : $('#businessStoreName').val(),
            buyer_tel : $('#phone').val(),
            //buyer_addr : '구매자주소',
            //buyer_postcode : '구매자우편번호',
            //m_redirect_url : 'https://www.yourdomain.com/payments/complete'
            //모바일 결제시, 결제가 끝나고 랜딩되는 URL을 지정 
            //(카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
        }, function(rsp) {
            if ( rsp.success ) {  //결제성공 
            console.log("rsp 결제성공");
                jQuery.ajax({
                    url: "subsPayment.do", //cross-domain error가 발생하지 않도록 주의해주세요
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid,
                        subscribeNo : subscribeNo,
                        userId: userId,
                        id : id,
                        payMethod : paymentMethod
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                   if(rsp.paid_amount === data.response.amount){
                        console.log("결제 성공");
                    } else {
                        console.log("결제 실패");
                    }
                })
                .fail(function(xhr, textStatus, errorThrown){console.log("xhr : " + xhr + "/ textStatus : " + textStatus + "errorThrown : " + errorThrown )});
                location.href='firstcheck.do?userId='+userId;
            } else {
             msg = '결제에 실패하였습니다.';
             msg += '에러내용 : ' + rsp.error_msg;
           //실패시 이동할 페이지
           	alert(msg);
             location.href="slist.do";
							}
						});
	}
	};		//function pay()
	
    function showDetail(option) {
        var detail = document.querySelector('.agreeDetail');
        detail.style.display = 'none'; // 모든 세부 내용을 숨김

        var selectedDetail = document.getElementById('detail-' + option);
        selectedDetail.style.display = 'block'; // 선택된 세부 내용을 표시
    }
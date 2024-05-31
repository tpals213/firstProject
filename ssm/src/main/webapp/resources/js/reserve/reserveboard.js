function wrapCreateBoardByMask() {
 	//화면의 높이와 너비를 구한다.
 	var maskHeight = $(document).height();
 	var maskWidth = $(windows).width();
 	
 	//마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
 	$('#mask_board_move').css({
 		'width': maskWidth,
 		'height': maskHeight
 	});
 	
 	$('#mask_board_move').fadeTo("slow", 0.7);
 	
 	$('.normal_move_board_modal').show();
 }
 
 $(function(){
 	//검은 막 띄위기
 	//기본 모달창
 	$('.openMask_board_move').click(function(e) {
 		//클릭 시 이벤트
 		console.log('모달 켭니다.');
 		e.preventDefault();
 		wrapCreateBoardByMask();
 	});
 	
 	//닫기 버튼을 눌렀을 때
 	$('.normal_move_board_modal .top .close').click(function(e) {
 		//링크 기본동작은 작동하지 않도록 한다.
 	 	e.preventDefault();
 	 	$('#mask_board_move, .normal_move_board_modal').hide();
 	});
 	
 	//검은 막을 눌렀을 때
 	$('#mask_board_move').click(function() {
 		$(this).hide();
 		$('.normal_move_board_modal').hide();
 	});
 	
 });
 
 
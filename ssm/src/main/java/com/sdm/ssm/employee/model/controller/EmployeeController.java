package com.sdm.ssm.employee.model.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestScope;

import com.sdm.ssm.common.Search;
import com.sdm.ssm.employee.model.service.CalendarService;
import com.sdm.ssm.employee.model.service.CommuteInfoService;
import com.sdm.ssm.employee.model.service.EmployeeService;
import com.sdm.ssm.employee.model.service.RecordTimeService;
import com.sdm.ssm.employee.model.service.SalaryInfoService;
import com.sdm.ssm.employee.model.vo.Calendar;
import com.sdm.ssm.employee.model.vo.CommuteInfo;
import com.sdm.ssm.employee.model.vo.Employee;
import com.sdm.ssm.employee.model.vo.SalaryInfo;
import com.sdm.ssm.user.model.vo.User;

@Controller("EmployeeController")
public class EmployeeController {

	private static final Logger logger = LoggerFactory.getLogger(EmployeeController.class);

	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private SalaryInfoService salaryInfoService;
	@Autowired
	private CommuteInfoService commuteInfoService;
	
	@Autowired
	private CalendarService calendarService;
	
	@Autowired
	private RecordTimeService recordTimeService;
	
//직원 관리-----------------------
//	// 직원 관리 메인 페이지 이동
//	@RequestMapping(value = "mainEmpPage.do", method = { RequestMethod.POST, RequestMethod.GET })
//	public String emplyeeMainPage(Employee employee, Model model) {
//		return "employee/employeeMainPage";
//	}

	// 직원 정보 등록 페이지로 이동
	@RequestMapping(value = "insertemp.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String moveEmployeePage(@RequestParam("id") int id) {		
	
	return "employee/EmployeeRegister";
	}
	 
	// 직원 등록 페이지에서 직원 정보를 저장하는 메서드
    @RequestMapping(value = "insertEmp.do", method = { RequestMethod.POST, RequestMethod.GET })
    public String insertEmployee(Employee employee) {
        logger.info("insertEmployee" + "0000000000000000000000");
        // 세션에서 로그인한 사용자 정보를 가져옴
        logger.info(employee.getId()+"");	  
		  // 직원 등록 처리 
		  int result = employeeService.insertEmployee(employee);
		  logger.info(employee + "22222"); if (result > 0) { 
			  logger.info(result +  "333333");
			  // 직원 등록 성공 시 목록 페이지로 리다이렉트 
		  return "redirect:selectemp.do?id="+ employee.getId(); } 
		  else { logger.info("4444444");
		  return "employee/EmployeeRegister"; } 
    }
	// 직원 목록 페이지로 이동
	@RequestMapping(value = "selectemp.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String moveSelectEmpPage(@RequestParam("id") int id, @RequestParam(name="empId", required=false) String empId, Model model) {
		//유저 아이디로 테이블 조회
    // 여기서는 직원 정보를 가져오는 서비스 레이어 메서드를 호출하여 직원 정보를 가져옵니다.
    List<Employee> employeeList = employeeService.getAllEmployees(id);
	    // 모델에 직원 정보를 추가하여 View로 전달합니다.
    if(empId!=null && empId.length()>0) {
    	Employee emp = employeeService.getEmployeeDetails(id, Integer.parseInt(empId));
    	model.addAttribute("empDetail", emp);
    	model.addAttribute("employeeList", employeeList);
    	return "employee/EmployeeList";
    }
    
	model.addAttribute("employeeList", employeeList);
	    // 직원 정보가 표시되는 페이지로 이동합니다.
	return "employee/EmployeeList";
	}
	
	// 직원 상세조회
	@RequestMapping(value = "employeeDetails.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String employeeDetails(@RequestParam("id") int id,@RequestParam("empId") int empId, Model model) {
	    // 선택된 직원의 상세 정보 조회
		model.addAttribute("empId", empId);
		model.addAttribute("id", id);

		return "redirect:selectemp.do";
	}

	// 직원 정보 수정 페이지로 이동하고 직원 정보를 가져오는 메서드
	@RequestMapping(value = "updateEmployee.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String moveAndUpdateEmployeePage(
			Employee employee, /* @RequestParam("empId") int empId, */
	 Model model) {
	    // 여기서는 특정 직원의 정보를 가져오는 프로시저를 호출하여 직원 정보를 가져옵니다.
		logger.info(employee.toString());
		employeeService.updateEmployee(employee);
	    // 가져온 직원 정보가 null이 아니면
	        model.addAttribute("id", employee.getId());
	        return "redirect:selectemp.do"; // 직원 정보 수정 페이지로 이동
	}

	//직원 수정 처리
	@RequestMapping(value="moveUpdateEmployee.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String updateEmployee(
			Model model, Employee emp) {	
		Employee emp2 = employeeService.selectEmpInfo(emp);
		logger.info(emp2.toString());
		if(emp2 !=null) {
			model.addAttribute("employee", emp2);
			model.addAttribute("id", emp.getId());
			return "employee/upEmployee";	
		}else {
			return "employee/EmployeeList";
		}
	}
	    
		//직원 삭제
//	    @RequestMapping(value = "deleteEmployee.do", method = { RequestMethod.POST, RequestMethod.GET })
//	    public ResponseEntity<String> deleteEmployee(@RequestParam("empId") int empId, HttpServletResponse response) {
//	        int result = employeeService.deleteEmployee(empId);
//	        if (result > 0) {
//	            // 직원 삭제 후 목록 페이지로 Redirect
//	            try {
//	                response.sendRedirect("employee/EmployeeList");
//	            } catch (IOException e) {
//	                e.printStackTrace();
//	                return new ResponseEntity<>("페이지 이동 실패", HttpStatus.INTERNAL_SERVER_ERROR);
//	            }
//	            return new ResponseEntity<>("직원 삭제 성공", HttpStatus.OK);
//	        } else {
//	            return new ResponseEntity<>("직원 삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
//	        }
//	    }
	    	
	    @RequestMapping(value = "deleteEmployee.do", method = {RequestMethod.GET, RequestMethod.POST})
		public String deleteEmployee(
				Employee employee, /* @RequestParam("empId") int empId, */
		 Model model) {
		    // 여기서는 특정 직원의 정보를 가져오는 프로시저를 호출하여 직원 정보를 가져옵니다.
			logger.info(employee.toString());
			employeeService.deleteEmployee(employee);
		    // 가져온 직원 정보가 null이 아니면
		        model.addAttribute("id", employee.getId());
		        return "redirect:selectemp.do";
		}
		 // 직원 검색
	    @PostMapping("employeessearch.do")
	    public String employeeSearchMethod(@RequestBody Search search, Model model) {
	        List<Employee> list = employeeService.employeeSearchMethod(search);
	        model.addAttribute("employees", list);
	        return "employee/EmployeeList";
	    }
	//급여 관련처리들------------------
	    
	 // 직원 급여 정보 페이지 이동 (GET 방식)
	    @RequestMapping(value = "selectSalary.do", method = RequestMethod.GET)
	    public String moveSalaryPage(
	            @RequestParam(value = "hourlyWage", required = false, defaultValue = "0") int hourlyWage,
	            @RequestParam("id") int id, Model model) {
	        List<SalaryInfo> list = salaryInfoService.getSalaryDate(id);
	        // 시급을 모델에 추가
	        model.addAttribute("hourlyWage", hourlyWage);
	        List<Integer> monthlySalaries = new ArrayList<>();
	        for (SalaryInfo salaryInfo : list) {
	            try {
	                // 시급과 해당 직원의 정보를 사용하여 월급을 계산하고 리스트에 추가
	            	int monthlySalary = (int) (Integer.parseInt(salaryInfo.getTotalWorkingHours()) * hourlyWage
	                        - Integer.parseInt(salaryInfo.getPremium()) - Integer.parseInt(salaryInfo.getTax()));
	                monthlySalaries.add(monthlySalary);
	            } catch (NumberFormatException e) {
	                // 숫자로 변환할 수 없는 값이 있을 경우 처리
	                // 예외 처리를 하거나 해당 값을 기본값으로 대체하거나 필요에 따라 다른 처리를 수행할 수 있습니다.
	                e.printStackTrace(); // 현재는 예외를 출력하는 방식으로 처리합니다.
	            }
	        }
	        model.addAttribute("monthlySalaries", monthlySalaries);
	        model.addAttribute("employees", list);
	        return "employee/SalaryInfo";
	    }
	// 직원 급여 정보 페이지 이동
	/*
	 * @RequestMapping(value = "selectSalary.do", method = RequestMethod.GET) public
	 * String moveSalaryPage(
	 * 
	 * @RequestParam(value = "hourlyWage", required = false, defaultValue = "0") int
	 * hourlyWage,
	 * 
	 * @RequestParam("id") int id, Model model) { List<SalaryInfo> list =
	 * salaryInfoService.getSalaryDate(id); // 시급을 모델에 추가
	 * model.addAttribute("hourlyWage", hourlyWage); List<Integer> monthlySalaries =
	 * new ArrayList<>(); for (SalaryInfo salaryInfo : list) { try { // 시급과 해당 직원의
	 * 정보를 사용하여 월급을 계산하고 리스트에 추가 int monthlySalary = (int)
	 * (Integer.parseInt(salaryInfo.getTotalWorkingHours()) * hourlyWage -
	 * Integer.parseInt(salaryInfo.getPremium()) -
	 * Integer.parseInt(salaryInfo.getTax())); monthlySalaries.add(monthlySalary); }
	 * catch (NumberFormatException e) { // 숫자로 변환할 수 없는 값이 있을 경우 처리 // 예외 처리를 하거나
	 * 해당 값을 기본값으로 대체하거나 필요에 따라 다른 처리를 수행할 수 있습니다. e.printStackTrace(); // 현재는 예외를
	 * 출력하는 방식으로 처리합니다. } }
	
	    model.addAttribute("monthlySalaries", monthlySalaries);
	    model.addAttribute("employees", list);
	    return "employee/SalaryInfo";
	}
	*/
	// 급여정보 검색하는 폼
	@RequestMapping(value = "selectSalary.do", method = RequestMethod.POST)
	public String selectSalaryPage(
			@RequestParam(value = "hourlyWage", required = false, defaultValue = "0") int hourlyWage,
			@ModelAttribute Search search, Model model) {
	    // Search 객체를 사용하여 급여 정보를 검색하고, 검색 결과를 모델에 추가
	    // 이후에는 적절한 뷰를 반환하도록 수정해야 합니다.
	    List<SalaryInfo> searchResult = salaryInfoService.searchSalary(search);
	    List<Integer> monthlySalaries = new ArrayList<>();
	    for (SalaryInfo salaryInfo : searchResult) {
	        if (salaryInfo.getPremium() != null && salaryInfo.getTax() != null) {
	            try {
	                // 값이 null이 아닌 경우에만 변환 및 계산
	                int premium = Integer.parseInt(salaryInfo.getPremium());
	                int tax = Integer.parseInt(salaryInfo.getTax());
	                int monthlySalary = (int) (Integer.parseInt(salaryInfo.getTotalWorkingHours()) * hourlyWage
	                        - premium - tax);
	                monthlySalaries.add(monthlySalary);
	            } catch (NumberFormatException e) {
	                e.printStackTrace();
	                // 예외 처리를 추가하거나, 해당 값을 무시하거나, 기본값을 설정할 수 있습니다.
	            }
	        } else {
	            // premium 또는 tax 값이 null인 경우에 대한 처리를 추가
	            // 예를 들어, 기본값을 설정하거나, 해당 값을 무시할 수 있습니다.
	        }
	    }
	    model.addAttribute("monthlySalaries", monthlySalaries);
	    model.addAttribute("searchResult", searchResult);
	    return "employee/SalaryInfo"; // 적절한 뷰의 이름을 반환
	}
	
	//시급 입력폼 처리용
	@PostMapping("/calculateMonthlySalary")
    @ResponseBody
    public String calculateMonthlySalary(@RequestParam("hourlyWage") double hourlyWage) {
        // 시급을 기반으로 월급 계산 로직을 작성
        // 예를 들어, 시급 * 근무시간 * 월 평균 근무일 수 등을 계산하여 월급을 구함

        double monthlySalary = hourlyWage * 8 * 20; // 간단한 예시로 월급을 계산

        // 결과를 JSON 형식으로 반환
        return "{\"monthlySalary\": " + monthlySalary + "}";
    }
	 // 급여 정보 상세조회용
    @RequestMapping("selectSalary.do")
    public String selectSalaryInfoMethod(@RequestParam("empId") int empId, Model model) {
        // empId를 사용하여 직원의 급여 정보를 조회
        ArrayList<SalaryInfo> elist = salaryInfoService.selectSalaryInfoMethod(empId);
        model.addAttribute("salaryInfos", elist);
        return "employee/SalaryInfo"; 
    }

	// 직원 급여정보 등록 페이지 이동
	@RequestMapping(value = "insertSalary.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String moveInsertSalaryPage(HttpServletRequest request, Employee employee) {
		return "employee/salaryInfoDate";
	}

	// 직원 급여 정보 수정 페이지 이동
	@RequestMapping(value="updateSalaryInfo.do",method = { RequestMethod.POST, RequestMethod.GET })
	public String moveUpdateSalaryPage(SalaryInfo salaryInfo, Model model, HttpServletRequest request) {
		return "employee/salaryInfoDate";
	}
	
	
	//근태-------------------------------
	// 근태관리 페이지로 이동
	@RequestMapping(value = "commuteInfoPage.do",method = { RequestMethod.POST, RequestMethod.GET })
	public String moveSelectCommutelnPage() {	
		return "employee/commuteInfoPage";
	}

	// 출퇴근시간 조회 페이지 이동
	@RequestMapping(value = "recordTimePage.do",method = { RequestMethod.POST, RequestMethod.GET })
	public String moveRecordTimePage() {
		return "employee/CommuteQRPage";
	}
	
	 // 세션에 저장된 사용자 정보를 가져오는 메서드
    public User getLoggedInUser(HttpServletRequest request) {
    	HttpSession session = request.getSession(false);
	    if (session != null) {
	    return (User) session.getAttribute("loggedInUser");
	        }
	        return null;
	    }
	    
	// 특정 직원의 이름으로 출퇴근 정보 검색
    @PostMapping("searchCommuteInfoByName.do")
    public ResponseEntity<List<CommuteInfo>> searchCommuteInfoByName(@RequestParam("empName") String empName) {
        try {
            List<CommuteInfo> commuteInfoList = commuteInfoService.searchCommuteInfoByName(empName);
            if (!commuteInfoList.isEmpty()) {
                return ResponseEntity.ok(commuteInfoList);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    
    //출근시간
    @RequestMapping("recordTimeData.do")
    public String recordMethod(Employee emp) {
    	logger.info(emp.toString());
    	recordTimeService.insertTime(emp);
    	return "employee/CommuteQRPage";
    }
    //퇴근시간
    @RequestMapping("recordEndTime.do")
    public String emdTimeMethod(Employee emp) {
    	logger.info(emp.toString());
    	recordTimeService.updateTime(emp);
    	return "employee/CommuteQRPage";
    }
	
	
	/* 
	 * @RequestMapping(value = "recordTimeData.do", method = { RequestMethod.POST,
	 * RequestMethod.GET }) public ResponseEntity<String>
	 * recordTime(HttpServletRequest request) { try { String empName =
	 * request.getParameter("empName"); // 사용자 이름 받기 List<Employee> employees
	 * =employeeService.searchEmployeeByName(empName); if (!employees.isEmpty()) {
	 * int empId = employees.get(0).getId(); String action =
	 * request.getParameter("action"); // 출퇴근 유형 받기 CommuteInfo commuteInfo = new
	 * CommuteInfo(); commuteInfo.setEmpId(empId); commuteInfo.setAction(action);
	 * 
	 * // 현재 시간을 한국 시간대로 가져오기 ZonedDateTime koreanTime =
	 * ZonedDateTime.now(ZoneId.of("Asia/Seoul")); String formattedTime =
	 * DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss").format(koreanTime).
	 * toString(); commuteInfo.setKoreanTime(formattedTime);
	 * 
	 * // 출퇴근 정보 저장 boolean success =
	 * commuteInfoService.recordCommuteInfo(commuteInfo); if (success) { return
	 * ResponseEntity.ok("출퇴근 정보 저장 성공 - " + formattedTime); } else { return
	 * ResponseEntity.badRequest().body("출퇴근 정보 저장 실패"); } } else { return
	 * ResponseEntity.notFound().build(); // 해당 직원을 찾을 수 없는 경우 } } catch (Exception
	 * e) { e.printStackTrace(); return
	 * ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류 발생"); } }
	 */
	    	
	// 특정 직원의 급여 정보 조회
	    @GetMapping("selectEmpSalary.do")
	    public ResponseEntity<List<SalaryInfo>> selectSalaryInfoByEmpId(@RequestParam("empId") int empId , @RequestParam("id") int id) {
	        try {
	            List<SalaryInfo> salaryInfoList = (List<SalaryInfo>) salaryInfoService.selectSalaryInfoByEmpId(id);
	            if (!salaryInfoList.isEmpty()) {
	                return ResponseEntity.ok(salaryInfoList);
	            } else {
	                return ResponseEntity.notFound().build();
	            }
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	        }
	    }
	    
	    // 시급 입력 폼 처리
		@RequestMapping(value="calculateSalary", method= { RequestMethod.POST , RequestMethod.GET })
	    public String calculateSalary(@RequestParam("hourlyWage") double hourlyWage, 
	    		Model model) {
	        
			model.addAttribute("hourlyWage", hourlyWage);
	        return "employee/SalaryInfo"; // 시급을 입력하는 페이지로 이동
	    }
		
		// 직원 급여명세서 페이지로 이동
		@RequestMapping("mvPayStub.do")
		public String movePayStubMethod() {
			return "account/payStub";
		}
	    
		// QR 페이지 이동
		@RequestMapping(value="QRimages.do",method = { RequestMethod.POST, RequestMethod.GET })
		public String moveQRPage() {
			return "employee/QRcommuteInfo"; 
		}

		// 메세지 페이지 이동
		@RequestMapping("kakaoM.do")
		public String moveKakaoMessagePage(Model model, HttpServletRequest request) {
			return "employee/kakao";
		}

		//직원 스케줄 조회 페이지 이동
		@RequestMapping(value="calendarPage.do", method ={ RequestMethod.POST, RequestMethod.GET })
		public String moveCalendarPage(Employee employee, Model model) {
		List<Calendar> schedules = calendarService.getAllcalendar(employee.getId()); 
		model.addAttribute("schedules", schedules);
		return "employee/calendarPage";
		}
				
}

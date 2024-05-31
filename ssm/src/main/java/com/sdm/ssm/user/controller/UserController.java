package com.sdm.ssm.user.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;
import com.sdm.ssm.common.FileNameChange;
import com.sdm.ssm.user.model.service.UserService;
import com.sdm.ssm.user.model.vo.User;
import com.sdm.ssm.user.model.vo.UserFinkOut;

@Controller
public class UserController {
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	private final String setFrom = "msj102525@naver.com"; // 2단계 인증 x, 메일 설정에서 POP/IMAP 사용 설정에서 POP/SMTP 사용함으로 설정o
	
	@Autowired
	private UserService userService;

	@Autowired
	private JavaMailSenderImpl mailSender;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPwEncoder;
	
	@Autowired
	private KakaoLoginAuth kakaologinAuth;
	
	@Autowired
	private NaverLoginAuth naverloginAuth;
	
	@Autowired
	private GoogleLoginAuth googleloginAuth;
	
	public UserController() {
		super();
	}
	
	private void addAuthURLsMethod(Model model, HttpSession session) {
        String kakaoAuthURL = kakaologinAuth.getAuthorizationUrl(session);
        String naverAuthURL = naverloginAuth.getAuthorizationUrl(session);
        String googleAuthURL = googleloginAuth.getAuthorizationUrl(session);

        model.addAttribute("kakaourl", kakaoAuthURL);
        model.addAttribute("naverurl", naverAuthURL);
        model.addAttribute("googleurl", googleAuthURL);
    }

	// 뷰 페이지 내보내기
	@RequestMapping(value="goLogin.do", method={RequestMethod.GET, RequestMethod.POST})
	public String goLogin(Model model, HttpSession session) {
		addAuthURLsMethod(model, session);
		
		return "user/login";
	}

	@RequestMapping(value="goEnroll.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String goEnroll(Model model, HttpSession session) {
		addAuthURLsMethod(model, session);
		
		return "user/enroll";
	}

	@RequestMapping("logout.do")
	public String logoutMethod(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);

		if (session != null) {
			session.invalidate();
			return "common/main";
		} else {
			model.addAttribute("message", "로그인 세션이 없거나 만료됐습니다");
			return "common/error";
		}
	}
	
	// 카카오
	@RequestMapping(value="kcallback.do", produces="application/json",
			method= {RequestMethod.GET, RequestMethod.POST})
	public String kakaoLogin(@RequestParam String code, Model model, HttpSession session, SessionStatus status) {
		
		// 로그인 결과값을 node에 담기
		JsonObject node = kakaologinAuth.getAccessToken(code);
		
		// accessToken에 사용자의 로그인한 모든 정보가 들어있음
		JsonPrimitive accessToken = node.getAsJsonPrimitive("access_token");
		
		// 사용자 정보 추출
		JsonObject userInfo = kakaologinAuth.getKakaoUserInfo(node.getAsJsonPrimitive("access_token"));
		
		// db table 에 기록할 회원정보 추출함 : 카카오 회원가입시
		//userInfo 에서 properties 정보 추출
		JsonObject properties = (JsonObject) node.get("properties");
		
		JsonObject kakao_account = (JsonObject) userInfo.get("kakao_account");
		String id = userInfo.get("id").getAsString();
		
		// 유저 테이블에서 회원 정보 조회해 오기
		User loginUser = null;
		User kUser = userService.selectUserById(id);
		
		if(kUser == null) {
			return "redirect:goEnroll.do?id=" + id
													+ "&passWd=DefaultSSMPassword!";
		} else {
			loginUser = kUser;
			session.setAttribute("loginUser", loginUser);
			status.setComplete();
			return "redirect:main.do";
		}
		
	}
	
	// 네이버
	public UserController(NaverLoginAuth naverLoginAuth) {
        this.naverLoginAuth = naverLoginAuth;
    }
	
	private NaverLoginAuth naverLoginAuth;
	String apiResult = null;
	
	@RequestMapping(value="ncallback.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String naverLogin(@RequestParam String code, @RequestParam String state, Model model, HttpSession session, SessionStatus status) throws IOException, ParseException {
	    
	    // 1. 코드, 세션 및 상태를 사용하여 getAccessToken을 호출합니다.
	    OAuth2AccessToken node = naverloginAuth.getAccessToken(session, code, state); 
	    // 이제 accessToken을 사용하여 사용자 정보를 가져와서 JsonObject를 만들거나 다른 작업을 수행할 수 있습니다.
	    if(node == null) {
	    	model.addAttribute("message", "Naver Token Error 브라우저 캐시를 지우고 다시 시도해 주세요");
	    	return "common/error";
	    } else {
	    	 // 2. accessToken에 사용자의 로그인한 모든 정보가 들어있음
		    apiResult = naverloginAuth.getUserProfile(node);
			
			// 3. String형식인 apiResult를 json형태로 바꿈
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(apiResult);
			JSONObject jsonObj = (JSONObject) obj;
			
			// 4. 데이터 파싱
			// Top레벨 단계 _response 파싱
			JSONObject response_obj = (JSONObject)jsonObj.get("response");
			String nickname = (String)response_obj.get("nickname");
			String email = (String)response_obj.get("email");
			String birthyear = (String)response_obj.get("birthyear");
			String birthday = (String)response_obj.get("birthday");
			String phone = (String)response_obj.get("mobile");
			
			String birth = birthyear + birthday.replaceAll("-", "");
			
			// 유저 테이블에서 회원 정보 조회해 오기
			User loginUser = null;
			User nUser = userService.selectUserById(email);
			
			if(nUser == null) {
				return "redirect:goEnroll.do?id="
							+ email
							+ "&email=" + email
							+ "&birth=" + birth
							+ "&phone=" + phone
							+ "&passWd=DefaultSSMPassword!";
			} else {
				loginUser = nUser;
				session.setAttribute("loginUser", loginUser);
				status.setComplete();
				return "redirect:main.do";
			}
	    }
	    
	}
	
	// 구글
	public UserController(GoogleLoginAuth googleLoginAuth) {
		this.googleLoginAuth = googleLoginAuth;
	}
	
	private GoogleLoginAuth googleLoginAuth;
	
	@RequestMapping(value="gcallback.do", method= {RequestMethod.GET, RequestMethod.POST})
	public String googleLogin(@RequestParam String code, @RequestParam String state, Model model, HttpSession session, SessionStatus status) throws IOException, ParseException {
	    
	    OAuth2AccessToken node = googleloginAuth.getAccessToken(session, code, state); 
	    
	    if(node == null) {
	    	model.addAttribute("message", "google Token Error 브라우저 캐시를 지우고 다시 시도해 주세요");
	    	return "common/error";
	    } else {
	    	apiResult = googleloginAuth.getUserProfile(node);
			
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(apiResult);
			JSONObject jsonObj = (JSONObject) obj;
			
			String name = (String)jsonObj.get("name");
			String id = (String)jsonObj.get("id");
			String email = (String)jsonObj.get("email");
			
			User loginUser = null;
			User gUser = userService.selectUserById(email);

			if (gUser == null) {
				return "redirect:goEnroll.do?id=" + email 
						+ "&email=" + email
						+ "&passWd=DefaultSSMPassword!";
			} else {
				loginUser = gUser;
				session.setAttribute("loginUser", loginUser);
				status.setComplete();
				return "redirect:main.do";
			}
	    }
		 
	}
	
	// 마이페이지 이동
	@RequestMapping("goMyPage.do")
	public String goMypageMethod(@RequestParam("userId") String userId, Model model,
			@RequestParam(name = "profileUrl", required = false) String profilUrl) {
		User loginUser = userService.selectUserById(userId);
		logger.info("goMypage!!!!");
		
		if(profilUrl == null || profilUrl.isEmpty()) {
			logger.info("profilUrl!!!! : " + profilUrl);			
		    loginUser.setProfileUrl(null);
		} else {
		    logger.info("profilUrl!!!! : " + profilUrl);
		    loginUser.setProfileUrl(profilUrl);
		}

		
		if(loginUser != null) {
			model.addAttribute("loginUser", loginUser);
			return "user/myPage";			
		} else {
			model.addAttribute("message", userId + "정보 조히 실패");
			return "common/error";
		}
	}
	
	// 아이디 찾기 이동
	@RequestMapping("goSearchId.do")
	public String goSearchIdMethod() {
		return "user/searchId";
	}
	
	// 비밀번호 찾기 이동
	@RequestMapping("goSearchPw.do")
	public String goSearcPwdMethod() {
		return "user/searchPw";
	}
		
	

	// 서비스 메소드 실행
	// 로그인
	@RequestMapping("login.do")
	public String loginMethod(User user, HttpSession session, SessionStatus status, Model model) {
		User loginUser = userService.selectUserById(user.getUserId());
		
		String loginOk = loginUser.getLoginOk();
		
		if(loginUser != null && 
				this.bcryptPwEncoder.matches(	user.getPassWd(), loginUser.getPassWd())) {
			
			if(loginOk.equals("N") || loginOk.equals(null)) {
				model.addAttribute("message", "로그인 제한된 회원입니다. 관리자에게 문의하세요.");
				return "common/error";
			}else {
				session.setAttribute("loginUser", loginUser);
				status.setComplete();  //로그인 성공 요청 결과로 HttpStatus code 200 보냄
				return "common/main";
			}
			
		}else {
			model.addAttribute("message", "로그인 실패! 아이디나 암호를 다시 확인하세요.");
			return "common/error";
		}

	}

	// 아이디 중복 체크
	@RequestMapping(value = "idchk.do", method = RequestMethod.POST)
	public void dupChkIDMethod(@RequestParam("userId") String userId, HttpServletResponse response) {

		int idCount = userService.selectUserCountById(userId);

		String result = null;
		if (idCount == 0) {
			result = "ok";
		} else {
			result = "dup";
		}

		logger.info("result!!!!!!!!!!!!!!" + result);
		PrintWriter out = null;
		response.setContentType("text/html; charset=utf-8");
		try {
			out = response.getWriter();
			out.append(result);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			out.close();
		}
	}

	// 이메일 인증

	@RequestMapping(value = "emailAuth.do", method = RequestMethod.POST)
	@ResponseBody
	public String emailAuthMethod(
			@RequestParam("userEmail") String email) {
		// 난수의 범위 111111 ~ 999999 (6자리 난수)
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

		// 이메일 보낼 양식
		String toMail = email;
		String title = "회원가입 인증 이메일 입니다.";
		String content = "인증 코드는 " + checkNum + " 입니다." + "<br>" + "해당 인증 코드를 인증 코드 확인란에 기입하여 주세요.";
		
		try {
			MimeMessage message = mailSender.createMimeMessage(); // Spring에서 제공하는 mail API
			MimeMessageHelper mailHelper = new MimeMessageHelper(message, "utf-8");
			
			mailHelper.setFrom(setFrom);
			mailHelper.setTo(toMail);
			mailHelper.setSubject(title);
			mailHelper.setText(content, true);
			mailSender.send(message);
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		logger.info("랜덤숫자 : " + checkNum);
		
		JSONObject jOb = new JSONObject();
		jOb.put("authCode", checkNum);
		
		return jOb.toJSONString();
	}
	
	// 회원 가입 요청
	@RequestMapping(value="enroll.do", method=RequestMethod.POST)
	public String userInsertMethod(User user, Model model) {
		
		logger.info("입력 : " + user.getPassWd());
		user.setPassWd(bcryptPwEncoder.encode(user.getPassWd()));
		logger.info("enroll.do : " + user.toString());
		// 패스워드 암호화 처리
		logger.info("암호화 : " + user.getPassWd());
		
		if(userService.insertUser(user) > 0) {
			return "user/login";
		} else {
			model.addAttribute("message", "회원가입 오류");
			return "common/error";
		}
		
		
	}
	
	// 유저 정보 수정
	@RequestMapping(value = "userInfoUpdate.do", method = RequestMethod.POST)
	public String userUpdateMethod(User user, Model model, HttpSession session, HttpServletRequest request,
			@RequestParam(name = "upfile", required = false) MultipartFile mfile) {

		String savePath = request.getSession().getServletContext().getRealPath("resources/user_upfiles");

		if (!mfile.isEmpty()) {
			String fileName = mfile.getOriginalFilename();
			String renameFileName = null;

			if (fileName != null && fileName.length() > 0) {
				renameFileName = FileNameChange.change(fileName, "yyyyMMddHHmmss");
				logger.info("첨부 파일명 변경 확인 : " + fileName + ", " + renameFileName);

				 try {
					mfile.transferTo(new File(savePath + "\\" + renameFileName));
				} catch (Exception e) {
					e.printStackTrace();
					model.addAttribute("message", "첨부 파일 저장 실패!");
					return "common/error";
				}
			} 
			user.setProfileUrl(renameFileName);
		} else {
			user.setProfileUrl(user.getProfileUrl());			
		}

		String userPwd = user.getPassWd().trim();
		logger.info("새로운 암호 : " + userPwd + ", " + userPwd.length());

		String originUserPwd = user.getPassWd();

		if (userPwd != null && userPwd.length() > 0) {
			if (!this.bcryptPwEncoder.matches(userPwd, originUserPwd)) {
				user.setPassWd(this.bcryptPwEncoder.encode(userPwd));
			}
		} else {
			user.setPassWd(originUserPwd);
		}

		if (userService.updateUser(user) > 0) {
			return "redirect:main.do";
		} else {
			model.addAttribute("message", "유저 정보 수정 오류");
			return "common/error";
		}
	}
	
	// 아이디 찾기
	@RequestMapping(value="searchId.do", method=RequestMethod.POST)
	public String searchIdMethod(User user, HttpSession session) {
		User findUser = userService.searchIdByEmailBName(user);
		logger.info(findUser.toString());
		
		if(findUser != null) {
			session.setAttribute("findUser", findUser);
			return "user/findUserId";
		} else {
			return "common/error";
		}
	}
	
	// 비밀번호 찾기
	@RequestMapping(value = "searchPw.do", method = RequestMethod.POST)
	public String searchPwMethod(User user, Model model) {
		User findUser = null;
		findUser = userService.selectUserByEmailId(user);

		if (findUser != null) {
			//소문자, 대문자, 숫자 
		    final String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+=";
		    
		    SecureRandom rm = new SecureRandom();
		    StringBuilder newPw = new StringBuilder();
		    
		    for(int i=0; i<11; i++) {
		        //무작위로 문자열의 인덱스 반환
		        int index = rm.nextInt(chars.length());
		        //index의 위치한 랜덤값
		        newPw.append(chars.charAt(index));
		    }

			// 이메일 보낼 양식
			String toMail = user.getEmail();
			String title = "임시 비밀번호 입니다.";
			String content = "임시 비밀번호는 " + newPw + " 입니다." + "<br>" + "해당 비밀번호로 로그인 해주세요.";
			
			try {
				MimeMessage message = mailSender.createMimeMessage(); // Spring에서 제공하는 mail API
				MimeMessageHelper mailHelper = new MimeMessageHelper(message, "utf-8");
				
				mailHelper.setFrom(setFrom);
				mailHelper.setTo(toMail);
				mailHelper.setSubject(title);
				mailHelper.setText(content, true);
				mailSender.send(message);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			logger.info("임시 비밀번호 : " + newPw);
			
			user.setPassWd(bcryptPwEncoder.encode(newPw.toString()));
			
			if(userService.updateUserPw(user) <= 0) {
				model.addAttribute("message", "비밀번호 업데이트 오류");
				return "common/error";
			}
			
			return "user/login";
		} else {
			model.addAttribute("message", "일치하는 사람 없음");
			return "common/error";
		}
	}
	
	@RequestMapping(value="withdraw.do", method=RequestMethod.POST) 
	public String withdrawMethod(
			@RequestParam("userId") String userId, Model model,
			@RequestParam("id") int id,
			@RequestParam("email") String email) {
		
		UserFinkOut userFO = new UserFinkOut();
		
		userFO.setFinkOutNo(id);
		userFO.setfUserId(userId);
		userFO.setfEmail(email);
		
		logger.info(userFO.toString());
		
		if (userId != null && userId.length() > 0) {
			if (userService.updateUserLoginOkToNByUserId(userId) > 0) {
				if (userService.insertUserFinkOut(userFO) > 0) {
					return "redirect:logout.do";
				} else {
					model.addAttribute("message", "탈퇴한 유저테이블에 유저 insert 실패!");
					return "common/error";
				}
			} else {
				model.addAttribute("message", "회원탈퇴 실패!");
				return "common/error";
			}
		} else {
			model.addAttribute("message", "아이디값이 없습니다!!");
			return "common/error";
		}
		
	}

}

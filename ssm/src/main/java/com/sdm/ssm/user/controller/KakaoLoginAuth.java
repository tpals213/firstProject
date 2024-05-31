package com.sdm.ssm.user.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonPrimitive;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

@Component("kakaoLoginAuth")
public class KakaoLoginAuth {
    private final static Logger logger = LoggerFactory.getLogger(KakaoLoginAuth.class);

    // js app key
    private final static String K_CLIENT_ID = "416eb2f9ae17657a348268fa2c296e77";
    // 로그인용 redirect uri
    private final static String K_REDIRECT_URI = "http://127.0.0.1:8080/ssm/kcallback.do";

    // 카카오 로그인 페이지로 이동 url 리턴용
    public String getAuthorizationUrl(HttpSession session) {
        String kakaoURL =
                "https://kauth.kakao.com/oauth/authorize?"
                        + "client_id=" + K_CLIENT_ID
                        + "&redirect_uri=" + K_REDIRECT_URI
                        + "&response_type=code";

        logger.info("kakaoURL : " + kakaoURL);

        return kakaoURL;
    }

    // 카카오 api 서버 접근 토큰받아서 리턴
    public JsonObject getAccessToken(String authorize_code) {
        final String RequestURL =
                "https://kauth.kakao.com/oauth/token";
        final List<NameValuePair> postParams = new ArrayList<>();

        postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
        postParams.add(new BasicNameValuePair("client_id", K_CLIENT_ID));
        postParams.add(new BasicNameValuePair("redirect_uri", K_REDIRECT_URI));
        postParams.add(new BasicNameValuePair("code", authorize_code));

        final HttpClient client = HttpClientBuilder.create().build();
        final HttpPost post = new HttpPost(RequestURL);

        JsonObject returnObject = null;

        try {
            post.setEntity(new UrlEncodedFormEntity(postParams));
            final HttpResponse response = client.execute(post);
            BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
            StringBuilder result = new StringBuilder();
            String line;
            while ((line = rd.readLine()) != null) {
                result.append(line);
            }
            JsonParser parser = new JsonParser();
            returnObject = parser.parse(result.toString()).getAsJsonObject();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObject;
    }

    // 사용자 정보 얻어오기
    public JsonObject getKakaoUserInfo(JsonPrimitive jsonPrimitive) {
        final String RequestURL = "https://kapi.kakao.com/v2/user/me";
        final HttpClient client = HttpClientBuilder.create().build();
        final HttpPost post = new HttpPost(RequestURL);

        // header 에 추가
        //** 주의 : accessToken 값은 JsonObject 형이어야 함
        // Bearer 뒤에 스페이스바 꼭 추가

        logger.info("jsonPrimitive!!! : " + jsonPrimitive.getAsJsonPrimitive().getAsString());
        post.addHeader("Authorization", "Bearer " + jsonPrimitive.getAsJsonPrimitive().getAsString());

        logger.info("post!!! : " + post.toString());

        JsonObject returnObject = null;

        try {
            final HttpResponse response = client.execute(post);
            BufferedReader rd = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
            StringBuilder result = new StringBuilder();
            String line;
            while ((line = rd.readLine()) != null) {
                result.append(line);
            }
            JsonParser parser = new JsonParser();
            returnObject = parser.parse(result.toString()).getAsJsonObject();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnObject;
    }

    // 카카오 로그아웃
    public void logout() {
        String url = "https://kauth.kakao.com/oauth/logout?"
                + "client_id=" + K_CLIENT_ID
                + "&logout_redirect_uri=http://localhost:8080/ssm/logout.do";
    }
}

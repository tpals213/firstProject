package com.sdm.ssm.employee.model.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import net.sf.json.JSONObject;

@Controller("recordTime.do")
public class RecordTimeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 클라이언트에서 전송한 JSON 데이터 추출
        String requestBody = request.getReader().lines().reduce("", (accumulator, actual) -> accumulator + actual);

        // JSON 데이터 파싱
        JSONObject jsonObject = new JSONObject();
        String username = jsonObject.getString("username");
        String action = jsonObject.getString("action");
        String time = jsonObject.getString("time");

        // 데이터베이스에 데이터 저장
        saveToDatabase(username, action, time);

        // 응답 전송
        PrintWriter out = response.getWriter();
        out.println("Data received and saved successfully!");
    }

    // 데이터베이스에 데이터 저장 메서드
    private void saveToDatabase(String username, String action, String time) {
        Connection connection = null;
        PreparedStatement statement = null;

		/*
		 * try { // JDBC 드라이버 로딩 Class.forName("com.mysql.cj.jdbc.Driver"); // 데이터베이스 연결
		 * connection =
		 * DriverManager.getConnection("jdbc:mysql://localhost:3306/your_database_name",
		 * "your_username", "your_password");
		 * 
		 * // SQL 쿼리 작성 String sql =
		 * "INSERT INTO time_records (username, action, time) VALUES (?, ?, ?)";
		 * statement = connection.prepareStatement(sql);
		 * 
		 * // 파라미터 설정 statement.setString(1, username); statement.setString(2, action);
		 * statement.setString(3, time);
		 * 
		 * // 쿼리 실행 statement.executeUpdate(); } catch (ClassNotFoundException |
		 * SQLException e) { e.printStackTrace(); } finally { // 리소스 해제 try { if
		 * (statement != null) statement.close(); if (connection != null)
		 * connection.close(); } catch (SQLException e) { e.printStackTrace(); } }
		 */
    }
    
   
    
    
}

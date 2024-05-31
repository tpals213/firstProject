package com.sdm.ssm.employee.model.controller;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.sdm.ssm.employee.model.vo.CommuteInfo;

@RestController
public class TimeRecordController {

    @PostMapping("recordTime.do")
    public HttpStatus recordTime(@RequestBody TimeRecordData data) {
        System.out.println("Action: " + data.getAction());
        System.out.println("Time: " + data.getTime());
        // 여기서 데이터를 처리하고 응답을 반환할 수 있음
        return HttpStatus.OK;
    }

    static class TimeRecordData {
        private String action;
        private String time;

        public String getAction() {
            return action;
        }

        public void setAction(String action) {
            this.action = action;
        }

        public String getTime() {
            return time;
        }

        public void setTime(String time) {
            this.time = time;
        }

		public CommuteInfo getCommuteInfo() {
			// TODO Auto-generated method stub
			return null;
		}

		public String getUsername() {
			// TODO Auto-generated method stub
			return null;
		}
    }
}


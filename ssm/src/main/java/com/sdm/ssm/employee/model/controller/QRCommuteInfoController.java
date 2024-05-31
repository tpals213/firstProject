package com.sdm.ssm.employee.model.controller;

import java.io.ByteArrayOutputStream;
import java.util.Hashtable;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

@RestController
public class QRCommuteInfoController {

	@RequestMapping(value = "QRController.do", method = RequestMethod.GET)
	public ResponseEntity<byte[]> getQRCode() {
		// 실제 출퇴근 기록을 위한 페이지 URL로 QR 코드 생성
		String text = "http://recordtimepage.p-e.kr/recordTime.do";
		
		 try { byte[] imageBytes = getQRCodeImage(text, 400, 400); HttpHeaders headers
		  = new HttpHeaders(); headers.setContentType(MediaType.IMAGE_PNG);
		  headers.setContentLength(imageBytes.length); return new
		 ResponseEntity<byte[]>(imageBytes, headers, HttpStatus.OK); } catch
		  (Exception e) { e.printStackTrace(); return new
		  ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR); } }
		  
		  private byte[] getQRCodeImage(String text, int width, int height) { try {
		  Hashtable<EncodeHintType, ErrorCorrectionLevel> hintMap = new Hashtable<>();
		  hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
		  QRCodeWriter writer = new QRCodeWriter(); BitMatrix bitMatrix =
		  writer.encode(text, BarcodeFormat.QR_CODE, width, height);
		  ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		  MatrixToImageWriter.writeToStream(bitMatrix, "png", outputStream); return
		  outputStream.toByteArray(); } catch (Exception e) { e.printStackTrace();
		  return null; }
		
	}

}
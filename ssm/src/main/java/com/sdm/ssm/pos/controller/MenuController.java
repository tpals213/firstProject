package com.sdm.ssm.pos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sdm.ssm.pos.model.vo.Menu;
import com.sdm.ssm.pos.model.service.MenuService;

@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @GetMapping("/listMenu.do")
    public String getAllMenus(Model model) {
        try {
            List<Menu> menuList = menuService.getAllMenus();
            model.addAttribute("menuList", menuList);
            return "menu/menuList";
        } catch (Exception e) {
            // 예외 발생 시 에러 페이지로 리디렉션
            return "redirect:/error";
        }
    }

    @PostMapping("/addMenu.do")
    public String addMenu(Menu menu) {
        try {
            menuService.addMenu(menu);
            return "redirect:/menu/listMenu.do";
        } catch (Exception e) {
            // 예외 발생 시 에러 페이지로 리디렉션
            return "redirect:/error";
        }
    }

    @PostMapping("/updateMenu.do")
    public String updateMenu(Menu menu) {
        try {
            menuService.updateMenu(menu);
            return "redirect:/menu/listMenu.do";
        } catch (Exception e) {
            // 예외 발생 시 에러 페이지로 리디렉션
            return "redirect:/error";
        }
    }

    @GetMapping("/deleteMenu.do")
    public String deleteMenu(int id) {
        try {
            menuService.deleteMenu(id);
            return "redirect:/menu/listMenu.do";
        } catch (Exception e) {
            // 예외 발생 시 에러 페이지로 리디렉션
            return "redirect:/error";
        }
    }

    // 추가적인 메뉴 관련 기능에 대한 메소드를 추가할 수 있습니다.
}

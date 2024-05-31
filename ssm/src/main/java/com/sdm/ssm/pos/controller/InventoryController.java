package com.sdm.ssm.pos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sdm.ssm.pos.model.service.InventoryService;
import com.sdm.ssm.pos.model.vo.Inventory;

@Controller
@RequestMapping("/inventory")
public class InventoryController {
	
    @Autowired
    private InventoryService inventoryService;

    @GetMapping("/listInventory.do")
    public String getAllInventory(Model model) {
        try {
            List<Inventory> inventoryList = inventoryService.getAllInventory();
            model.addAttribute("inventoryList", inventoryList);
            return "inventory/inventoryList";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "재고 목록을 불러오는 중 오류가 발생했습니다.");
            return "errorPage";
        }
    }

    @PostMapping("/updateInventory.do")
    public String updateInventory(Inventory inventory, RedirectAttributes redirectAttributes) {
        try {
            inventoryService.updateInventory(inventory);
            return "redirect:/inventory/listInventory.do";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "재고 정보 수정 중 오류가 발생했습니다.");
            return "redirect:/inventory/listInventory.do";
        }
    }

    @PostMapping("/addInventory.do")
    public String addInventory(Inventory inventory, RedirectAttributes redirectAttributes) {
        try {
            inventoryService.addInventory(inventory);
            return "redirect:/inventory/listInventory.do";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "새로운 재고 추가 중 오류가 발생했습니다.");
            return "redirect:/inventory/listInventory.do";
        }
    }

    @GetMapping("/deleteInventory.do")
    public String deleteInventory(int id, RedirectAttributes redirectAttributes) {
        try {
            inventoryService.deleteInventory(id);
            return "redirect:/inventory/listInventory.do";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "재고 삭제 중 오류가 발생했습니다.");
            return "redirect:/inventory/listInventory.do";
        }
    }
}

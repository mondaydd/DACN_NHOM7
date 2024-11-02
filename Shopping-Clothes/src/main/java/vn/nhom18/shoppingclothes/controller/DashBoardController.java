package vn.nhom18.shoppingclothes.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DashBoardController {
    @GetMapping("/admin")
    public String handleDashboard() {
        System.out.println("Accessed /admin");
        return "admin/dashboard/show";
    }

}

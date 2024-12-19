package vn.nhom18.shoppingclothes.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.nhom18.shoppingclothes.domain.User;
import vn.nhom18.shoppingclothes.service.UploadService;
import vn.nhom18.shoppingclothes.service.UserService;

@Controller
public class AccountManageController {

    @Autowired
    private UserService userService;
    @Autowired
    private UploadService uploadService;

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @GetMapping("/user/account-management")
    public String getAccountManagementPage(HttpServletRequest request, Model model) {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login"; 
        }

      
        String name = (String) session.getAttribute("name");
        String avatar = (String) session.getAttribute("avatar");
        String email = (String) session.getAttribute("email");
        String address = (String) session.getAttribute("address"); 
        String phone = (String) session.getAttribute("phone"); 
        long userId = (long) session.getAttribute("id");

       
        model.addAttribute("name", name);
        model.addAttribute("avatar", avatar);
        model.addAttribute("email", email);
        model.addAttribute("address", address); 
        model.addAttribute("phone", phone); 
        model.addAttribute("userId", userId);

        return "user/account-management"; 
    }

    @RequestMapping("/user/edit-account")
    public String showEditAccountPage(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login"; 
        }

        
        String name = (String) session.getAttribute("name");
        String avatar = (String) session.getAttribute("avatar");
        String email = (String) session.getAttribute("email");
        String address = (String) session.getAttribute("address");
        String phone = (String) session.getAttribute("phone");
        long userId = (long) session.getAttribute("id");

        
        model.addAttribute("name", name);
        model.addAttribute("avatar", avatar);
        model.addAttribute("email", email);
        model.addAttribute("address", address);
        model.addAttribute("phone", phone);
        model.addAttribute("userId", userId);

        return "user/edit-account"; 
    }

    @PostMapping("/user/update-account")
    public String updateAccount(@RequestParam("userId") long userId,
            @RequestParam("name") String name,
            @RequestParam("address") String address,
            @RequestParam("phone") String phone,
            @RequestParam(value = "avatar", required = false) MultipartFile avatarFile,
            @RequestParam(value = "oldPassword", required = false) String oldPassword,
            @RequestParam(value = "newPassword", required = false) String newPassword,
            HttpServletRequest request) {

        
        User user = userService.getUserById(userId);

       
        if (user != null) {
           
            user.setName(name);
            user.setAddress(address);
            user.setPhone(phone);

           
            if (newPassword != null && !newPassword.isEmpty() && oldPassword != null && !oldPassword.isEmpty()) {
                if (passwordEncoder.matches(oldPassword, user.getPassword())) {
                    user.setPassword(passwordEncoder.encode(newPassword)); 
                } else {
                    
                    return "redirect:/user/edit-account?error=true";
                }
            }

          
            if (avatarFile != null && !avatarFile.isEmpty()) {
                String avatarPath = uploadService.handleSaveUploadFile(avatarFile, "avatar");
                user.setAvatar(avatarPath);
            }

         
            userService.updateUser(user);
        }

        HttpSession session = request.getSession();
        session.setAttribute("name", name);
        session.setAttribute("address", address);
        session.setAttribute("phone", phone);

   
        return "redirect:/user/account-management";
    }

}

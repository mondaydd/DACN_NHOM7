package vn.nhom18.shoppingclothes.controller.admin;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.nhom18.shoppingclothes.domain.Message;
import vn.nhom18.shoppingclothes.domain.MessageHistory;
import vn.nhom18.shoppingclothes.domain.Order;

import vn.nhom18.shoppingclothes.domain.Product;
import vn.nhom18.shoppingclothes.domain.User;
import vn.nhom18.shoppingclothes.domain.dto.OrderDetailDTO;
import vn.nhom18.shoppingclothes.repository.MessageHistoryRepository;
import vn.nhom18.shoppingclothes.repository.UserRepository;
import vn.nhom18.shoppingclothes.service.DashBoardService;
import vn.nhom18.shoppingclothes.service.MessageService;
import vn.nhom18.shoppingclothes.service.ProductService;

@Controller
public class DashBoardController {
    private final DashBoardService dashBoardService;
    private final ProductService productService;
    private final UserRepository userRepository;
    private final MessageService messageService;
    private final MessageHistoryRepository messageHistoryRepository;

    public DashBoardController(DashBoardService dashBoardService, ProductService productService,
            UserRepository userRepository, MessageService messageService, MessageHistoryRepository messageHistoryRepository) {
        this.dashBoardService = dashBoardService;
        this.productService = productService;
        this.userRepository = userRepository;
        this.messageService = messageService;
        this.messageHistoryRepository = messageHistoryRepository;
    }

    private String getDayOfWeekLabel(int dayOfWeek) {
        switch (dayOfWeek) {
            case 0:
                return "Thứ Hai";
            case 1:
                return "Thứ Ba";
            case 2:
                return "Thứ Tư";
            case 3:
                return "Thứ Năm";
            case 4:
                return "Thứ Sáu";
            case 5:
                return "Thứ Bảy";
            case 6:
                return "Chủ Nhật";
            default:
                return "";
        }
    }

    private void getTotal(Model model, String date) {
        long userByDate = 0;
        double totalPrice = 0;
        int totalQuantity = 0;
        switch (date) {
            case "1":
                userByDate = this.dashBoardService.HandleCountUserByDay();
                totalPrice = this.dashBoardService.HandleTotalPriceByDay();
                totalQuantity = this.dashBoardService.HandleTotalQuantityByDay();
                model.addAttribute("userByDay", userByDate);
                model.addAttribute("priceByDay", totalPrice / 1000000);
                model.addAttribute("quantityByDay", totalQuantity);
                model.addAttribute("Date", "Ngày");
                break;
            case "2":
                userByDate = this.dashBoardService.HandleCountUserByMonth();
                totalPrice = this.dashBoardService.HandleTotalPriceByMonth();
                totalQuantity = this.dashBoardService.HandleTotalQuantityByMonth();
                model.addAttribute("userByDay", userByDate);
                model.addAttribute("Date", "Tháng");
                model.addAttribute("priceByDay", totalPrice / 1000000);
                model.addAttribute("quantityByDay", totalQuantity);
                break;
            case "3":
                userByDate = this.dashBoardService.HandleCountUserByYear();
                totalPrice = this.dashBoardService.HandleTotalPriceByYear();
                totalQuantity = this.dashBoardService.HandleTotalQuantityByYear();
                model.addAttribute("userByDay", userByDate);
                model.addAttribute("Date", "Năm");
                model.addAttribute("priceByDay", totalPrice / 1000000);
                model.addAttribute("quantityByDay", totalQuantity);
                break;
            case "4":
                userByDate = this.dashBoardService.HandleCountUserByWeek();
                totalPrice = this.dashBoardService.HandleTotalPriceByWeek();
                totalQuantity = this.dashBoardService.HandleTotalQuantityByWeek();
                model.addAttribute("userByDay", userByDate);
                model.addAttribute("Date", "Tuần");
                model.addAttribute("priceByDay", totalPrice / 1000000);
                model.addAttribute("quantityByDay", totalQuantity);
                break;
            default:
                break;
        }
    }

    private void populateDataForWeek(Model model, String date) throws JsonProcessingException {
        int[] userCountByDay = null;
        double[] totalPrice = null;
        String[] xAxisLabels = null;
        int[] totalQuantity = null;
        switch (date) {
            case "4":
                userCountByDay = new int[7];
                totalPrice = new double[7];
                totalQuantity = new int[7];
                xAxisLabels = new String[7];
                for (int i = 0; i < 7; i++) {
                    userCountByDay[i] = dashBoardService.HandleCountUserByDayOfWeek(i);
                    totalPrice[i] = this.dashBoardService.HandleTotalPriceByDayOfWeek(i) / 1000000;
                    totalQuantity[i] = this.dashBoardService.HandleTotalQuantityByDayOfWeek(i);
                    xAxisLabels[i] = getDayOfWeekLabel(i);
                }
                model.addAttribute("Date", "Tuần");
                break;
            case "1":
                userCountByDay = new int[31];
                xAxisLabels = new String[31];
                totalPrice = new double[31];
                totalQuantity = new int[31];

                for (int i = 1; i <= 31; i++) {
                    userCountByDay[i - 1] = dashBoardService.HandleCountUserByDayOfMonth(i);
                    totalPrice[i - 1] = this.dashBoardService.HandleTotalPriceByDayOfMonth(i) / 1000000;
                    totalQuantity[i - 1] = this.dashBoardService.HandleTotalQuantityByDayOfMonth(i);
                    xAxisLabels[i - 1] = i + "";
                }
                model.addAttribute("Date", "Ngày");
                break;
            case "2":
                userCountByDay = new int[12];
                xAxisLabels = new String[12];
                totalQuantity = new int[12];
                totalPrice = new double[12];
                for (int i = 1; i <= 12; i++) {
                    userCountByDay[i - 1] = dashBoardService.HandleCountUserByMonthOfYear(i);
                    totalPrice[i - 1] = this.dashBoardService.HandleTotalPriceByMonthOfYear(i) / 1000000;
                    totalQuantity[i - 1] = this.dashBoardService.HandleTotalQuantityByDayMonthOfYear(i);
                    xAxisLabels[i - 1] = "Tháng " + i;
                }
                model.addAttribute("Date", "Tháng");
                break;
            case "3":
                userCountByDay = new int[10];
                xAxisLabels = new String[10];
                totalQuantity = new int[10];
                totalPrice = new double[10];
                int index = 0;
                for (int i = 2024; i < 2034; i++) {
                    userCountByDay[index] = dashBoardService.HandleCountUserBy10Year(i);
                    totalPrice[index] = this.dashBoardService.HandleTotalPriceBy10Year(i) / 1000000;
                    totalQuantity[index] = this.dashBoardService.HandleTotalQuantityBy10Year(i);
                    xAxisLabels[index] = "Năm " + i;
                    index++;
                }
                model.addAttribute("Date", "Năm");
                break;
            default:
                break;
        }

        // Chuyển các mảng này thành JSON để truyền vào View
        ObjectMapper objectMapper = new ObjectMapper();
        model.addAttribute("userCountByDayJson", objectMapper.writeValueAsString(userCountByDay));
        model.addAttribute("totalPrice", objectMapper.writeValueAsString(totalPrice));
        model.addAttribute("totalQuantity", objectMapper.writeValueAsString(totalQuantity));
        model.addAttribute("xAxisLabelsJson", objectMapper.writeValueAsString(xAxisLabels));
    }

    private void top5CurrentOrder(Model model, String date) {

        List<Order> currentOrder = null;

        switch (date) {
            case "1":
                currentOrder = this.dashBoardService.HandleCurrentOrderByDay();
                model.addAttribute("currentOrder", currentOrder);
                model.addAttribute("Date", "Ngày");
                break;
            case "2":
                currentOrder = this.dashBoardService.HandleCurrentOrderByMonth();
                model.addAttribute("currentOrder", currentOrder);
                model.addAttribute("Date", "Tháng");
                break;
            case "3":
                currentOrder = this.dashBoardService.HandleCurrentOrderByYear();
                model.addAttribute("currentOrder", currentOrder);
                model.addAttribute("Date", "Năm");
                break;
            case "4":
                currentOrder = this.dashBoardService.HandleCurrentOrderByWeek();
                model.addAttribute("currentOrder", currentOrder);
                model.addAttribute("Date", "Tuần");
                break;
            default:
                break;
        }
    }

    private void bestSaleProduct(Model model, String date) {
        List<Object[]> results = null;
        List<OrderDetailDTO> orderDetailDots = new ArrayList<>();
        switch (date) {
            case "1":
                results = this.dashBoardService.HandleBestSaleByDay();
                model.addAttribute("Date", "Ngày");
                break;
            case "2":
                results = this.dashBoardService.HandleBestSaleByMonth();
                model.addAttribute("Date", "Tháng");
                break;
            case "3":
                results = this.dashBoardService.HandleBestSaleByYear();
                model.addAttribute("Date", "Năm");
                break;
            case "4":
                results = this.dashBoardService.HandleBestSaleByWeek();
                model.addAttribute("Date", "Tuần");
                break;
            default:
                break;
        }

        for (Object[] row : results) {
            int productId = ((Number) row[0]).intValue();
            Optional<Product> pro = this.productService.getProductByProductDetailsId(productId);
            String name = pro.get().getName();
            double price = ((Number) row[1]).doubleValue();
            Double totalRevenue = ((Number) row[2]).doubleValue();
            int totalQuantity = ((Number) row[3]).intValue();
            orderDetailDots.add(new OrderDetailDTO(productId, name, totalRevenue, totalQuantity, price));
        }
        model.addAttribute("bestSale", orderDetailDots);
    }

    @GetMapping("/admin")
    public String handleDashboard(Model model,
            @RequestParam(value = "date", defaultValue = "1") String date, HttpServletRequest request)
            throws JsonProcessingException {

        getTotal(model, date);
        populateDataForWeek(model, date);
        top5CurrentOrder(model, date);
        bestSaleProduct(model, date);
        model.addAttribute("activePage", "home");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }
        long adminId = (long) session.getAttribute("id");
        long totalMessages = messageService.countMessagesForUser(adminId);
        List<MessageHistory> recentMessages = messageService.getRecentMessagesForUser(adminId);
        model.addAttribute("totalMessages", totalMessages);
        model.addAttribute("recentMessages", recentMessages);
        return "admin/dashboard/show";
    }

    @GetMapping("/admin/contact/show")
    public String showContactPage() {
        return "admin/contact/show";
    }

    @PostMapping("/admin/contact/submit")
    public String handleContactSubmit(@RequestParam String name, @RequestParam String email,
            @RequestParam String message, Model model) {

        model.addAttribute("message", "Cảm ơn bạn đã liên hệ! Chúng tôi sẽ phản hồi trong thời gian sớm nhất.");
        return "admin/contact/show";
    }

    @GetMapping("/admin/dashboard/messages")
    public String showMessagesPage(Model model, HttpServletRequest request) {
        // Lấy ID admin từ session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        long adminId = (long) session.getAttribute("id");

        // Lấy tin nhắn mới nhất của mỗi người gửi
        List<MessageHistory> recentMessages = messageService.getRecentMessagesForAdmin(adminId);

        // Truyền tin nhắn vào model
        model.addAttribute("recentMessages", recentMessages);

        return "admin/dashboard/messages"; // Trang hiển thị tin nhắn gần đây
    }

    // @GetMapping("/admin/dashboard/messages/{userId}")
    // public String showMessagesForUser(@PathVariable Long userId, Model model,
    // HttpServletRequest request) {
    // // Lấy ID admin từ session
    // HttpSession session = request.getSession(false);
    // if (session == null || session.getAttribute("id") == null) {
    // return "redirect:/login";
    // }

    // long adminId = (long) session.getAttribute("id");

    // // Lấy tất cả các tin nhắn của user gửi đến admin
    // List<MessageHistory> userMessages =
    // messageService.getAllMessagesFromUser(userId, adminId);

    // model.addAttribute("userMessages", userMessages);

    // return "admin/dashboard/messageDetails"; // Trang hiển thị tất cả tin nhắn
    // của user
    // }

    @GetMapping("/admin/dashboard/messages/{userId}")
    public String showMessagesForUser(@PathVariable Long userId, Model model, HttpServletRequest request) {
        // Lấy ID admin từ session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        long adminId = (long) session.getAttribute("id");

        // Lấy tất cả message liên quan đến admin và user
        List<MessageHistory> messages = messageHistoryRepository.findMessagesBetweenUserAndAdmin(userId, adminId);

        // Lấy thông tin user
        User user = userRepository.findById(userId).orElse(null);

        model.addAttribute("userMessages", messages);
        model.addAttribute("user", user);
        model.addAttribute("adminId", adminId);

        return "admin/dashboard/messageDetails"; // Trang hiển thị tất cả tin nhắn
    }

    // Phản hồi tin nhắn (có thể mở rộng theo yêu cầu)
    @PostMapping("/admin/dashboard/messages/{userId}/reply")
    public String replyToMessage(@PathVariable Long userId, @RequestParam String content, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        long adminId = (long) session.getAttribute("id");
        messageService.replyToMessage(userId, adminId, content);

        return "redirect:/admin/dashboard/messages/" + userId;
    }

}

package vn.nhom18.shoppingclothes.controller.user;

import java.util.List;

import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.nhom18.shoppingclothes.domain.Order;
import vn.nhom18.shoppingclothes.domain.OrderDetail;
import vn.nhom18.shoppingclothes.service.OrderService;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Page;

@Controller
public class OrderHistoryController {

    private final OrderService orderService;

    public OrderHistoryController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/user/order-history")
    public String getOrderHistory(HttpServletRequest request, Model model,
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "5") int size) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        long userId = (long) session.getAttribute("id");
        Pageable pageable = PageRequest.of(page, size);
        Page<Order> orderPage = orderService.getOrdersByUserId(userId, pageable);

        model.addAttribute("orders", orderPage.getContent());
        model.addAttribute("currentPage", orderPage.getNumber());
        model.addAttribute("totalPages", orderPage.getTotalPages());
        model.addAttribute("totalItems", orderPage.getTotalElements());
        return "user/order-history";
    }

    @GetMapping("/user/order-history/{orderId}")
    public String getOrderDetail(@PathVariable("orderId") long orderId, HttpServletRequest request, Model model) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        long userId = (long) session.getAttribute("id");

        Order order = orderService.getOrderById(orderId, userId);
        if (order == null) {
            return "redirect:/user/order-history";
        }

        List<OrderDetail> orderDetails = orderService.getOrderDetailsByOrderId(orderId);
        model.addAttribute("order", order);
        model.addAttribute("orderDetails", orderDetails);
        return "user/order-detail";
    }

    @PostMapping("/user/order-history/delete/{orderId}")
    public String deleteOrder(@PathVariable("orderId") long orderId) {
        orderService.cancelOrder(orderId);
        return "redirect:/user/order-history"; 
    }
}

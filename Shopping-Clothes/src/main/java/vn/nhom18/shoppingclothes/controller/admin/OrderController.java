package vn.nhom18.shoppingclothes.controller.admin;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.nhom18.shoppingclothes.domain.Order;
import vn.nhom18.shoppingclothes.service.OrderService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class OrderController {
    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getUserPage(
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "5") int size,
            @RequestParam(value = "search", required = false) String search,
            Model model) {

        String status = null;
        if (search != null && !search.isEmpty()) {
            // Kiểm tra nếu từ khóa tìm kiếm có chứa trạng thái
            if (search.contains("Đang xử lý") || search.contains("Đang giao") || search.contains("Đã giao")
                    || search.contains("Đã hủy")) {
                // Tách trạng thái ra
                if (search.contains("Đang xử lý")) {
                    status = "Đang xử lý";
                } else if (search.contains("Đang giao")) {
                    status = "Đang giao";
                } else if (search.contains("Đã giao")) {
                    status = "Đã giao";
                } else if (search.contains("Đã hủy")) {
                    status = "Đã hủy";
                }
                // Tách phần từ khóa tìm kiếm
                search = search.replace(status, "").trim();
            }
        }

        // Tìm kiếm theo trạng thái và từ khóa
        Page<Order> orderPage = this.orderService.searchOrders(search, status, page, size);
        model.addAttribute("activePage", "order");
        model.addAttribute("orders", orderPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", orderPage.getTotalPages());
        model.addAttribute("search", search); // lưu từ khóa tìm kiếm
        model.addAttribute("status", status); // lưu trạng thái tìm kiếm
        return "admin/order/show";
    }

    @GetMapping("/admin/order/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable long id) {
        Optional<Order> currentOrder = this.orderService.fetchOrderById(id);
        model.addAttribute("orderId", currentOrder.get());
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String handleUpdateOrder(@ModelAttribute("orderId") Order order) {
        this.orderService.updateOrder(order);
        return "redirect:/admin/order";
    }

    @GetMapping("/admin/order/delete/{id}")
    public String getDeleteOrderPage(Model model, @PathVariable long id, RedirectAttributes redirectAttributes) {

        Optional<Order> orderOpOp = orderService.fetchOrderById(id);
        Order order = orderOpOp.get();

        if (!"Đã giao".equals(order.getStatus()) && !"Đã hủy".equals(order.getStatus())) {
            redirectAttributes.addFlashAttribute("error", "Đơn hàng chưa hoàn thành. Không thể xóa!");
            return "redirect:/admin/order";
        }

        model.addAttribute("id", id);
        model.addAttribute("orderId", new Order());
        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete")
    public String postDeleteOrder(@ModelAttribute("orderId") Order order) {
        this.orderService.deleteOrderById(order.getId());
        return "redirect:/admin/order";
    }

    @GetMapping("/admin/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id) {
        Order order = this.orderService.fetchOrderById(id).get();
        model.addAttribute("id", id);
        model.addAttribute("orderDetails", order.getOrderDetails());

        return "admin/order/detail";
    }
}

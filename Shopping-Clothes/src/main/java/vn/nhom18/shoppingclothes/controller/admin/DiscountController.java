package vn.nhom18.shoppingclothes.controller.admin;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.nhom18.shoppingclothes.domain.Discount;
import vn.nhom18.shoppingclothes.service.DiscountService;

@Controller
@RequestMapping("/admin/discount")
public class DiscountController {
    private final DiscountService discountService;

    public DiscountController(DiscountService discountService) {
        this.discountService = discountService;
    }

    @GetMapping("")
    public String redirectToManage() {
        return "redirect:/admin/discount/manage";
    }

    @GetMapping("/manage")
    public String manageDiscounts(
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "5") int size,
            Model model) {
        Page<Discount> discountPage = discountService.getDiscounts(page, size);
        model.addAttribute("discounts", discountPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", discountPage.getTotalPages());
        model.addAttribute("activePage", "discount");
        return "admin/discount/manage";
    }

    @GetMapping("/create")
    public String createDiscountForm(Model model) {
        model.addAttribute("discount", new Discount());
        return "admin/discount/create";
    }

    @PostMapping("/create")
    public String createDiscount(@ModelAttribute Discount discount, Model model) {
        // Kiểm tra xem mã giảm giá đã tồn tại trong cơ sở dữ liệu chưa
        if (discountService.existsByCode(discount.getCode())) {
            model.addAttribute("errorMessage", "Mã giảm giá đã tồn tại! Vui lòng chọn mã khác.");
            return "admin/discount/create"; // Trở lại trang tạo mã giảm giá
        }

        // Nếu mã giảm giá không trùng, lưu vào cơ sở dữ liệu
        discountService.save(discount);
        model.addAttribute("successMessage", "Tạo mã giảm giá thành công!");
        return "admin/discount/create"; // Quay lại trang tạo mã giảm giá
    }

    @GetMapping("/edit/{id}")
    public String editDiscountForm(@PathVariable Long id, Model model) {
        Discount discount = discountService.findById(id);
        if (discount != null) {
            model.addAttribute("discount", discount);
            return "admin/discount/edit";
        }
        return "redirect:/admin/discount/manage";
    }

    @PostMapping("/edit")
    public String editDiscount(@ModelAttribute Discount discount, Model model) {
        // Kiểm tra và tìm mã giảm giá cũ trong cơ sở dữ liệu
        Discount existingDiscount = discountService.findById(discount.getId());

        if (existingDiscount != null) {
            // Nếu có sự thay đổi về mã giảm giá, kiểm tra tính hợp lệ
            if (!existingDiscount.getCode().equals(discount.getCode())) {
                if (discountService.existsByCode(discount.getCode())) {
                    model.addAttribute("errorMessage", "Mã giảm giá đã tồn tại! Vui lòng chọn mã khác.");
                    return "admin/discount/edit"; // Quay lại trang chỉnh sửa nếu mã trùng
                }
            }

            // Cập nhật thông tin mã giảm giá
            discountService.save(discount);
            model.addAttribute("successMessage", "Cập nhật mã giảm giá thành công!");
        } else {
            model.addAttribute("errorMessage", "Không tìm thấy mã giảm giá!");
            return "admin/discount/manage"; // Quay lại trang quản lý nếu không tìm thấy mã giảm giá
        }

        return "redirect:/admin/discount/manage"; // Quay lại trang danh sách
    }

    @GetMapping("/delete/{id}")
    public String deleteDiscount(@PathVariable Long id) {
        discountService.deleteById(id);
        return "redirect:/admin/discount/manage"; // Chuyển hướng đến trang danh sách mã giảm giá
    }
}

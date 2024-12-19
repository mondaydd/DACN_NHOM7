package vn.nhom18.shoppingclothes.controller.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import vn.nhom18.shoppingclothes.domain.Category;
import vn.nhom18.shoppingclothes.domain.Product;
import vn.nhom18.shoppingclothes.service.CategoryService;
import vn.nhom18.shoppingclothes.service.ProductService;

@Controller
@RequestMapping("/categories")
public class CategoryUserController {

    private final CategoryService categoryService;
    private final ProductService productService;

    @Autowired
    public CategoryUserController(CategoryService categoryService, ProductService productService) {
        this.categoryService = categoryService;
        this.productService = productService;
    }

    // Lấy tất cả danh mục và hiển thị trang categories.jsp
    @GetMapping
    public String getAllCategories(Model model) {
        List<Category> categories = categoryService.getAllCategories();
        model.addAttribute("categories", categories);
        model.addAttribute("activePage", "category");
        return "user/categories"; // Trả về trang categories.jsp
    }

    @GetMapping("/{categoryId}/products")
    public String getProductsByCategory(@PathVariable long categoryId, Model model,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Product> productPage = productService.getProductsByCategoryWithPagination(categoryId, pageable);
        Category category = categoryService.findById(categoryId); // Lấy category để hiển thị tên danh mục

        // Lấy danh sách tất cả các danh mục để hiển thị trong sidebar
        List<Category> categories = categoryService.getAllCategories();

        // Truyền vào model
        model.addAttribute("categories", categories);
        model.addAttribute("category", category);
        model.addAttribute("products", productPage.getContent());
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("currentPage", page);

        return "user/categories"; // Trả về trang categories.jsp để hiển thị danh sách sản phẩm
    }

    @RequestMapping("/categories/{id}/homepage")
    public String showCategoryHomepage(@PathVariable Long id, Model model) {
        // Giả sử bạn muốn hiển thị danh sách sản phẩm trong category với id
        Category category = categoryService.findById(id);
        if (category != null) {
            model.addAttribute("category", category);
            return "user/category-homepage"; // Trả về trang jsp của bạn
        } else {
            return "redirect:/"; // Nếu không tìm thấy category, chuyển hướng về trang chủ
        }
    }

}

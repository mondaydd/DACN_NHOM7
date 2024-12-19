package vn.nhom18.shoppingclothes.controller.admin;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import vn.nhom18.shoppingclothes.domain.Category;
import vn.nhom18.shoppingclothes.service.CategoryService;

@Controller
public class CategoryController {
    private final CategoryService categoryService;

    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping("/admin/category")
    public String getCategoryPage(
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "5") int size,
            @RequestParam(value = "search", defaultValue = "") String search,
            Model model) {

        // Lọc danh mục theo từ khóa tìm kiếm
        Page<Category> categoryPage;
        if (search.isEmpty()) {
            categoryPage = categoryService.getCategories(page, size); // Không có tìm kiếm
        } else {
            categoryPage = categoryService.searchCategories(search, page, size); // Có tìm kiếm
        }
        model.addAttribute("activePage", "category");
        model.addAttribute("categories", categoryPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", categoryPage.getTotalPages());
        model.addAttribute("search", search); // Truyền giá trị tìm kiếm về giao diện
        return "admin/category/show";
    }

    // Phương thức xóa danh mục
    @GetMapping("/admin/category/delete/{id}")
    public String deleteCategory(@PathVariable("id") long id, Model model) {
        // Kiểm tra nếu danh mục tồn tại
        Category category = categoryService.findById(id);

        // Kiểm tra xem danh mục có sản phẩm không
        if (category.getProducts().isEmpty()) {
            // Nếu không có sản phẩm, xóa danh mục
            categoryService.deleteById(id);
            return "redirect:/admin/category"; // Chuyển hướng về danh sách danh mục sau khi xóa
        } else {
            // Nếu có sản phẩm, thông báo lỗi
            model.addAttribute("error",
                    "Danh mục này có " + category.getProducts().size() + " sản phẩm và không thể xóa.");

            // Tải lại danh sách danh mục
            List<Category> categories = categoryService.getAllCategories();
            model.addAttribute("categories", categories);

            return "admin/category/show"; // Quay lại trang danh mục với thông báo lỗi
        }
    }

    // Phương thức hiển thị form sửa
    @GetMapping("/admin/category/update/{id}")
    public String editCategory(@PathVariable("id") long id, Model model) {
        // Lấy thông tin danh mục theo ID và hiển thị trong form
        Category category = categoryService.findById(id);
        model.addAttribute("category", category);
        return "admin/category/update"; // Trả về view
    }

    // Phương thức xử lý khi người dùng gửi form sửa
    @PostMapping("/admin/category/update/{id}")
    public String updateCategory(@PathVariable("id") long id, Category category) {
        // Lấy danh mục từ cơ sở dữ liệu theo ID
        Category existingCategory = categoryService.findById(id);

        // Cập nhật thông tin danh mục
        existingCategory.setName(category.getName());
        existingCategory.setDescription(category.getDescription());

        // Lưu lại thay đổi
        categoryService.save(existingCategory);

        return "redirect:/admin/category"; // Chuyển hướng về danh sách danh mục sau khi sửa
    }

    @GetMapping("/admin/category/create")
    public String showCreateForm(Model model) {
        // Trả về trang hiển thị biểu mẫu
        return "admin/category/create"; // Đảm bảo tên này khớp với tên JSP của bạn
    }

    @PostMapping("/admin/category/create")
    public String createCategory(@RequestParam String name, @RequestParam String description, Model model) {
        // Kiểm tra nếu trường tên danh mục trống
        if (name == null || name.trim().isEmpty()) {
            model.addAttribute("nameError", "Tên danh mục không được để trống!");
            return "admin/category/create"; // Quay lại trang tạo danh mục với thông báo lỗi
        }

        // Kiểm tra nếu danh mục đã tồn tại
        if (categoryService.existsByName(name)) {
            model.addAttribute("error", "Tên danh mục đã tồn tại. Vui lòng chọn tên khác.");
            return "admin/category/create";
        }

        // Nếu tên danh mục hợp lệ, tạo danh mục mới
        Category category = new Category();
        category.setName(name);
        category.setDescription(description);
        categoryService.save(category);

        return "redirect:/admin/category"; // Chuyển hướng về danh sách danh mục sau khi thêm thành công
    }

}

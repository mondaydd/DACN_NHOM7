package vn.nhom18.shoppingclothes.controller.admin;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;

import vn.nhom18.shoppingclothes.domain.Product;
import vn.nhom18.shoppingclothes.domain.ProductDetail;
import vn.nhom18.shoppingclothes.service.ProductService;
import vn.nhom18.shoppingclothes.service.UploadService;

@Controller
public class ProductController {

    private final UploadService uploadService;
    private final ProductService productService;

    public ProductController(UploadService uploadService, ProductService productService) {
        this.uploadService = uploadService;
        this.productService = productService;
    }

    @GetMapping("/admin/product")
    public String getProductPage(
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "5") int size,
            @RequestParam(value = "search", required = false) String search,  // Thêm tham số tìm kiếm
            Model model) {
        
        Page<Product> productPage;
        
        if (search != null && !search.isEmpty()) {
            productPage = this.productService.searchProducts(search, page, size);  // Tìm sản phẩm theo từ khóa
            model.addAttribute("search", search);  // Đưa từ khóa tìm kiếm vào model để giữ lại trong ô tìm kiếm
        } else {
            productPage = this.productService.fetchProducts(page, size);
        }

        model.addAttribute("products", productPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("activePage", "product");
        return "admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String createProductForm(Model model) {
        // Lấy danh sách các danh mục để hiển thị trong dropdown
        model.addAttribute("categories", productService.getAllCategories());
        model.addAttribute("sizes", productService.getAllSizes()); // Lấy danh sách các size
        model.addAttribute("colors", productService.getAllColors()); // Lấy danh sách các màu sắc
        model.addAttribute("product", new Product());
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String createProduct(
            @Valid @ModelAttribute("product") Product product,
            @RequestParam("imageFile") MultipartFile imageFile,
            BindingResult result,
            Model model) {

        // Kiểm tra nếu có lỗi trong binding
        if (result.hasErrors()) {
            model.addAttribute("categories", productService.getAllCategories());
            // Lấy thông báo lỗi cho từng trường
            if (result.hasFieldErrors("name")) {
                model.addAttribute("nameError", "Tên sản phẩm không được để trống.");
            }
            if (result.hasFieldErrors("price")) {
                model.addAttribute("priceError", "Giá sản phẩm phải lớn hơn 0.");
            }

            return "admin/product/create"; // Trả lại trang tạo nếu có lỗi
        }

        // Xử lý hình ảnh nếu có
        if (!imageFile.isEmpty()) {
            String fileName = uploadService.handleSaveUploadFile(imageFile, "products");
            product.setImage(fileName);
        }

        // Lưu sản phẩm vào cơ sở dữ liệu
        productService.createProduct(product);

        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/detail/{id}")
    public String viewProductDetail(@PathVariable("id") long id,
            @RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "size", defaultValue = "5") int size,
            Model model) {
        Product product = productService.getProductById(id);
        Pageable pageable = PageRequest.of(page, size);
        Page<ProductDetail> productDetailsPage = productService.getProductDetailsByProductId(id, pageable);

        model.addAttribute("product", product);
        model.addAttribute("productDetailsPage", productDetailsPage);
        return "admin/product/detail";
    }

    @GetMapping("/admin/product/update/{id}")
    public String updateProductForm(@PathVariable("id") long id, Model model) {
        // Lấy thông tin sản phẩm
        Product product = productService.getProductById(id);

        // Chỉ truyền dữ liệu cần thiết cho Product
        model.addAttribute("product", product);
        model.addAttribute("categories", productService.getAllCategories());
        return "admin/product/update"; // Trả về form cập nhật sản phẩm
    }

    // Phương thức xử lý cập nhật sản phẩm
    // Phương thức xử lý cập nhật sản phẩm
    @PostMapping("/admin/product/update/{id}")
    public String updateProduct(
            @PathVariable("id") long id,
            @Valid @ModelAttribute("product") Product product,
            @RequestParam("imageFile") MultipartFile imageFile,
            BindingResult result,
            Model model) {

        // Kiểm tra lỗi binding
        if (result.hasErrors()) {
            model.addAttribute("categories", productService.getAllCategories());
            return "admin/product/update"; // Trả về form sửa sản phẩm nếu có lỗi
        }

        // Xử lý hình ảnh nếu có
        if (!imageFile.isEmpty()) {
            String fileName = uploadService.handleSaveUploadFile(imageFile, "products");
            product.setImage(fileName);
        } else {
            // Nếu không có ảnh mới, giữ ảnh cũ (không thay đổi giá trị của image)
            Product existingProduct = productService.getProductById(id);
            product.setImage(existingProduct.getImage()); // Giữ lại ảnh cũ của sản phẩm
        }

        // Cập nhật sản phẩm
        productService.updateProduct(id, product);

        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String deleteProduct(@PathVariable("id") long id, Model model) {
        // Xóa sản phẩm bằng id
        productService.deleteProduct(id);

        // Sau khi xóa, chuyển hướng về trang danh sách sản phẩm
        return "redirect:/admin/product";
    }
}

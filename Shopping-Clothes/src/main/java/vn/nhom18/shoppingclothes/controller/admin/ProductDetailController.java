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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;
import vn.nhom18.shoppingclothes.domain.ProductDetail;
import vn.nhom18.shoppingclothes.service.ProductService;
import vn.nhom18.shoppingclothes.service.UploadService;

@Controller
public class ProductDetailController {

    private final ProductService productService;
    private final UploadService uploadService;

    public ProductDetailController(ProductService productService, UploadService uploadService) {
        this.productService = productService;
        this.uploadService = uploadService;
    }

    @GetMapping("/admin/productDetail")
    public String listProductDetails(@RequestParam(value = "page", defaultValue = "0") int page,
            @RequestParam(value = "search", required = false) String search,
            Model model) {
        Pageable pageable = PageRequest.of(page, 5); // Số lượng sản phẩm mỗi trang là 5

        Page<ProductDetail> productDetails;
        if (search != null && !search.isEmpty()) {
            productDetails = productService.searchProductDetails(search, pageable);
        } else {
            productDetails = productService.getAllProductDetails(pageable);
        }
        model.addAttribute("activePage", "product-detail");
        model.addAttribute("productDetails", productDetails);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productDetails.getTotalPages());
        model.addAttribute("search", search); // Truyền từ khóa tìm kiếm về view để giữ lại khi form được gửi
        return "admin/productDetail/detail"; // Giao diện hiển thị danh sách
    }

    @GetMapping("/admin/productDetail/create")
    public String createProductDetailForm(@RequestParam(value = "product", required = false) Long productId,
            Model model) {
        model.addAttribute("productDetail", new ProductDetail());
        model.addAttribute("products", productService.fetchProducts());
        model.addAttribute("sizes", productService.getAllSizes());
        model.addAttribute("colors", productService.getAllColors());

        return "admin/productDetail/create";
    }

    @PostMapping("/admin/productDetail/create")
    public String createProductDetail(@Valid @ModelAttribute("productDetail") ProductDetail productDetail,
            @RequestParam("imageFile") MultipartFile imageFile,
            BindingResult result, RedirectAttributes redirectAttributes, Model model) {

        if (result.hasErrors()) {
            model.addAttribute("products", productService.fetchProducts());
            model.addAttribute("sizes", productService.getAllSizes());
            model.addAttribute("colors", productService.getAllColors());
            return "admin/productDetail/create";
        }

        // Xử lý lưu ảnh
        if (!imageFile.isEmpty()) {
            String fileName = uploadService.handleSaveUploadFile(imageFile, "productDetails");
            productDetail.setImageDetail(fileName);
        }

        productService.addProductDetail(productDetail);
        redirectAttributes.addFlashAttribute("success", "Chi tiết sản phẩm được thêm thành công!");
        return "redirect:/admin/productDetail";
    }

    @GetMapping("/admin/productDetail/edit/{id}")
    public String editProductDetailForm(@PathVariable("id") long id, Model model) {
        ProductDetail productDetail = productService.getProductDetailById(id);
        model.addAttribute("productDetail", productDetail);
        model.addAttribute("products", productService.fetchProducts());
        model.addAttribute("sizes", productService.getAllSizes());
        model.addAttribute("colors", productService.getAllColors());
        return "admin/productDetail/edit"; // Giao diện chỉnh sửa
    }

    @PostMapping("/admin/productDetail/edit/{id}")
    public String updateProductDetail(
            @PathVariable("id") long id,
            @Valid @ModelAttribute("productDetail") ProductDetail productDetail,
            @RequestParam("imageFile") MultipartFile imageFile,
            BindingResult result,
            Model model) {

        // Lấy thông tin ProductDetail hiện tại từ database
        ProductDetail existingDetail = productService.getProductDetailById(id);

        // Thiết lập giá trị product từ bản ghi hiện tại
        productDetail.setProduct(existingDetail.getProduct());

        if (result.hasErrors()) {
            model.addAttribute("products", productService.fetchProducts());
            model.addAttribute("sizes", productService.getAllSizes());
            model.addAttribute("colors", productService.getAllColors());
            return "admin/productDetail/edit";
        }

        // Xử lý upload hình ảnh mới
        if (!imageFile.isEmpty()) {
            String fileName = uploadService.handleSaveUploadFile(imageFile, "productDetails");
            productDetail.setImageDetail(fileName);
        } else {
            productDetail.setImageDetail(existingDetail.getImageDetail()); // Giữ nguyên ảnh cũ nếu không tải lên
        }

        productService.updateProductDetail(id, productDetail);

        return "redirect:/admin/productDetail"; // Sau khi cập nhật thành công, chuyển hướng về /admin/productDetail
    }

    @GetMapping("/admin/productDetail/delete/{id}")
    public String deleteProductDetail(@PathVariable("id") long id) {
        productService.deleteProductDetail(id);
        return "redirect:/admin/productDetail"; // Sau khi xóa, chuyển hướng về /admin/productDetail
    }
}

package vn.nhom18.shoppingclothes.controller.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import vn.nhom18.shoppingclothes.domain.Product;
import vn.nhom18.shoppingclothes.repository.ProductRepository;
import vn.nhom18.shoppingclothes.service.ProductService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

@Controller
public class ProductUserController {

    private final ProductService productService;
    private final ProductRepository productRepository;

    @Autowired
    public ProductUserController(ProductService productService, ProductRepository productRepository) {
        this.productService = productService;
        this.productRepository = productRepository;
    }

    @GetMapping("/products/{id}")
    public String showProductDetail(@PathVariable Long id, Model model) {

        Product product = productService.findById(id);

        if (product != null) {
            model.addAttribute("product", product);
            return "user/product-detail";
        } else {

            return "redirect:/";
        }
    }



    @GetMapping("/products")
    public String showProducts(@RequestParam(required = false) Double minPrice,
            @RequestParam(required = false) Double maxPrice,
            @RequestParam(required = false) String priceSort,
            @RequestParam(required = false) String keyword,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "12") int size,
            Model model) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Product> productPage;

        if (keyword != null && !keyword.isEmpty()) {
            productPage = productService.getProductsByKeyword(keyword, pageable);
        } else if (minPrice != null && maxPrice != null) {
            productPage = productService.getProductsByPriceRange(minPrice, maxPrice, priceSort, pageable);
        } else {
            if ("asc".equalsIgnoreCase(priceSort)) {
                pageable = PageRequest.of(page, size, Sort.by("price").ascending());
            } else if ("desc".equalsIgnoreCase(priceSort)) {
                pageable = PageRequest.of(page, size, Sort.by("price").descending());
            }
            productPage = productService.getProducts(pageable);
        }
        model.addAttribute("activePage", "product");
        model.addAttribute("products", productPage.getContent());
        model.addAttribute("currentPage", productPage.getNumber());
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("keyword", keyword); // Truyền lại từ khóa để giữ giá trị trong form
        return "user/products";
    }

}

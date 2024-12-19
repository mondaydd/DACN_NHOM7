package vn.nhom18.shoppingclothes.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.nhom18.shoppingclothes.domain.Category;
import vn.nhom18.shoppingclothes.domain.Color;
import vn.nhom18.shoppingclothes.domain.Product;
import vn.nhom18.shoppingclothes.domain.ProductDetail;
import vn.nhom18.shoppingclothes.domain.Size;
import vn.nhom18.shoppingclothes.repository.CategoryRepository;
import vn.nhom18.shoppingclothes.repository.ColorRepository;
import vn.nhom18.shoppingclothes.repository.ProductDetailRepository;
import vn.nhom18.shoppingclothes.repository.ProductRepository;
import vn.nhom18.shoppingclothes.repository.SizeRepository;
import org.springframework.data.domain.Sort;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository; // Thêm repository của danh mục
    private final ColorRepository colorRepository;
    private final SizeRepository sizeRepository;
    private final ProductDetailRepository productDetailRepository;

    public ProductService(ProductRepository productRepository, CategoryRepository categoryRepository,
            ColorRepository colorRepository, SizeRepository sizeRepository,
            ProductDetailRepository productDetailRepository) {
        this.productRepository = productRepository;
        this.categoryRepository = categoryRepository;
        this.colorRepository = colorRepository;
        this.sizeRepository = sizeRepository;
        this.productDetailRepository = productDetailRepository;
    }

    public Product createProduct(Product pr) {
        return this.productRepository.save(pr);
    }

    public List<Product> fetchProducts() {
        return this.productRepository.findAll();
    }

    public Page<Product> fetchProducts(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return productRepository.findAll(pageable);
    }

    public Optional<Product> fetchProductById(long id) {
        return this.productRepository.findById(id);
    }

    public void deleteProduct(long id) {
        this.productRepository.deleteById(id);
    }

    public Optional<Product> getProduct(int id) {
        return this.productRepository.findById(id);
    }

    public Optional<Product> getProductByProductDetailsId(int id) {
        return this.productRepository.findByProductDetailsId(id);
    }

    // Phương thức lấy tất cả danh mục
    public List<Category> getAllCategories() {
        return categoryRepository.findAll();
    }

    public Product getProductById(long id) {
        return productRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy sản phẩm với ID: " + id));
    }

    // Phương thức lấy danh sách sản phẩm theo danh mục
    public Page<Product> getProductsByCategoryWithPagination(long categoryId, Pageable pageable) {
        return productRepository.findByCategory_Id(categoryId, pageable); // Phân trang sản phẩm theo categoryId
    }

    // Phương thức lấy danh mục theo id
    public Category getCategoryById(long categoryId) {
        return categoryRepository.findById(categoryId)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy danh mục với ID: " + categoryId));
    }

    // Phương thức lấy danh sách sản phẩm theo categoryId
    public List<Product> getProductsByCategory(long categoryId) {
        return productRepository.findByCategory_Id(categoryId); // Tìm sản phẩm theo categoryId
    }

    // Find product by ID
    public Product findById(Long id) {
        return productRepository.findById(id).orElse(null); // Retrieve product by ID or return null
    }

    public List<Product> getProductsByPriceRange(Double minPrice, Double maxPrice, String priceSort) {
        if (priceSort == null) {
            return productRepository.findByPriceBetween(minPrice, maxPrice);
        } else if ("asc".equals(priceSort)) {
            return productRepository.findByPriceBetweenOrderByPriceAsc(minPrice, maxPrice);
        } else {
            return productRepository.findByPriceBetweenOrderByPriceDesc(minPrice, maxPrice);
        }
    }

    public List<Product> getAllProductsSortedByPrice(String priceSort) {
        if ("asc".equals(priceSort)) {
            return productRepository.findAllByOrderByPriceAsc();
        } else if ("desc".equals(priceSort)) {
            return productRepository.findAllByOrderByPriceDesc();
        } else {
            return productRepository.findAll();
        }
    }

    public List<Size> getAllSizes() {
        return sizeRepository.findAll(); // Lấy tất cả các size
    }

    public List<Color> getAllColors() {
        return colorRepository.findAll(); // Lấy tất cả các màu sắc
    }

    public Size getSizeById(long sizeId) {
        return sizeRepository.findById(sizeId).orElseThrow(() -> new RuntimeException("Size không tồn tại"));
    }

    public Color getColorById(long colorId) {
        return colorRepository.findById(colorId).orElseThrow(() -> new RuntimeException("Màu sắc không tồn tại"));
    }

    public void addProductDetail(ProductDetail productDetail) {
        productDetailRepository.save(productDetail); // Lưu thông tin chi tiết sản phẩm
    }

    public List<ProductDetail> getProductDetailsByProductId(long productId) {
        return productDetailRepository.findByProductId(productId); // Lấy chi tiết sản phẩm từ repository
    }

    public Page<ProductDetail> getProductDetailsByProductId(long productId, Pageable pageable) {
        return productDetailRepository.findByProductId(productId, pageable);
    }

    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }

    public Product updateProduct(Long id, Product product) {
        // Tìm sản phẩm trong cơ sở dữ liệu
        Product existingProduct = productRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Product not found with id: " + id));

        // Cập nhật thông tin sản phẩm
        existingProduct.setName(product.getName());
        existingProduct.setPrice(product.getPrice());
        existingProduct.setShortDesc(product.getShortDesc());
        existingProduct.setDetailDesc(product.getDetailDesc());
        existingProduct.setCategory(product.getCategory());
        existingProduct.setImage(product.getImage());

        // Lưu sản phẩm đã được cập nhật
        return productRepository.save(existingProduct);
    }

    public void clearProductDetails(Product product) {
        // Xóa các ProductDetail cũ
        product.getProductDetails().clear();
    }

    public Page<ProductDetail> getAllProductDetails(Pageable pageable) {
        return productDetailRepository.findAll(pageable);
    }

    public ProductDetail getProductDetailById(long id) {
        return productDetailRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy chi tiết sản phẩm với ID: " + id));
    }

    public void updateProductDetail(long id, ProductDetail productDetail) {
        ProductDetail existingDetail = productDetailRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy chi tiết sản phẩm với ID: " + id));

        existingDetail.setSize(productDetail.getSize());
        existingDetail.setColor(productDetail.getColor());
        existingDetail.setQuantity(productDetail.getQuantity());
        existingDetail.setImageDetail(productDetail.getImageDetail());
        productDetailRepository.save(existingDetail);
    }

    public void deleteProductDetail(long id) {
        if (!productDetailRepository.existsById(id)) {
            throw new IllegalArgumentException("Không tìm thấy chi tiết sản phẩm với ID: " + id);
        }
        productDetailRepository.deleteById(id);
    }

    // Phân trang sản phẩm
    public Page<Product> getProducts(Pageable pageable) {
        return productRepository.findAll(pageable);
    }

    // Lấy sản phẩm theo khoảng giá với sắp xếp
    public Page<Product> getProductsByPriceRange(double minPrice, double maxPrice, String sortOrder,
            Pageable pageable) {
        if ("asc".equalsIgnoreCase(sortOrder)) {
            pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("price").ascending());
        } else if ("desc".equalsIgnoreCase(sortOrder)) {
            pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), Sort.by("price").descending());
        }
        return productRepository.findByPriceBetween(minPrice, maxPrice, pageable);
    }

    public Page<Product> getProductsByKeyword(String keyword, Pageable pageable) {
        return productRepository.findByNameContainingIgnoreCase(keyword, pageable);
    }

    public Page<Product> searchProducts(String search, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return productRepository.findByNameContainingIgnoreCase(search, pageable);
    }

    public Page<ProductDetail> searchProductDetails(String search, Pageable pageable) {
        return productDetailRepository.findByProductNameContainingOrSizeNameContainingOrColorNameContaining(search, search, search, pageable);
    }
}

package vn.nhom18.shoppingclothes.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import vn.nhom18.shoppingclothes.domain.ProductDetail;

public interface ProductDetailRepository extends JpaRepository<ProductDetail, Long> {
    // Lấy danh sách ProductDetail theo productId
    List<ProductDetail> findByProductId(long productId);

    Optional<ProductDetail> findByProductIdAndColorIdAndSizeId(long productId, long colorId, long sizeId);

    Page<ProductDetail> findByProductId(long productId, Pageable pageable);

    Page<ProductDetail> findByProductNameContainingOrSizeNameContainingOrColorNameContaining(
        String productName, String sizeName, String colorName, Pageable pageable);
}

package vn.nhom18.shoppingclothes.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.nhom18.shoppingclothes.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    // Phương thức đếm số lượng sản phẩm thuộc danh mục
    long countByCategoryId(long categoryId);

    // lọc sản phẩm theo giá
    List<Product> findByPriceBetween(Double minPrice, Double maxPrice);

    List<Product> findByCategory_Id(long categoryId);

    Page<Product> findByCategory_Id(Long categoryId, Pageable pageable);

    List<Product> findByPriceBetweenOrderByPriceAsc(Double minPrice, Double maxPrice);

    List<Product> findByPriceBetweenOrderByPriceDesc(Double minPrice, Double maxPrice);

    List<Product> findAllByOrderByPriceAsc();

    List<Product> findAllByOrderByPriceDesc();

    Optional<Product> findById(long id);

    Optional<Product> findByProductDetailsId(long id);

    Page<Product> findAll(Pageable pageable);

    Page<Product> findByPriceBetween(double minPrice, double maxPrice, Pageable pageable);

    Page<Product> findAllByOrderByCreateDateDesc(Pageable pageable);

    Page<Product> findByNameContainingIgnoreCase(String keyword, Pageable pageable);

}

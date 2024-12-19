package vn.nhom18.shoppingclothes.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.nhom18.shoppingclothes.domain.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {

    boolean existsByName(String name); // Phương thức kiểm tra danh mục đã tồn tại

    Page<Category> findByNameContainingOrDescriptionContaining(String name, String description, Pageable pageable);

}

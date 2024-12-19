package vn.nhom18.shoppingclothes.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.nhom18.shoppingclothes.domain.Discount;

@Repository
public interface DiscountRepository extends JpaRepository<Discount, Long> {

    Discount findBycode(String code);

    boolean existsByCode(String code);

    List<Discount> findByStartDateBeforeAndEndDateAfter(LocalDateTime startDate, LocalDateTime endDate);
}

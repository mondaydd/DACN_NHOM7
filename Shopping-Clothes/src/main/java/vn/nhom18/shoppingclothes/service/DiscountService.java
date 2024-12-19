package vn.nhom18.shoppingclothes.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.nhom18.shoppingclothes.domain.Discount;
import vn.nhom18.shoppingclothes.repository.DiscountRepository;

@Service
public class DiscountService {

    private final DiscountRepository discountRepository;

    @Autowired
    public DiscountService(DiscountRepository discountRepository) {
        this.discountRepository = discountRepository;
    }

    // Lấy tất cả mã giảm giá
    public List<Discount> getAllDiscounts() {
        return discountRepository.findAll();
    }

    public Page<Discount> getDiscounts(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return discountRepository.findAll(pageable);
    }

    // Lưu mã giảm giá mới hoặc cập nhật mã giảm giá đã có
    public Discount save(Discount discount) {
        return discountRepository.save(discount);
    }

    // Tìm mã giảm giá theo ID
    public Discount findById(Long id) {
        return discountRepository.findById(id).orElse(null);
    }

    // Tìm mã giảm giá theo mã
    public Discount findByCode(String code) {
        return discountRepository.findBycode(code); // Giả sử bạn đã định nghĩa phương thức này trong repository
    }

    // Xóa mã giảm giá theo ID
    public void deleteById(Long id) {
        discountRepository.deleteById(id);
    }

    public boolean existsByCode(String code) {
        return discountRepository.existsByCode(code); // Kiểm tra trong cơ sở dữ liệu
    }

    public List<Discount> getActiveDiscounts() {
        LocalDateTime now = LocalDateTime.now();
        return discountRepository.findByStartDateBeforeAndEndDateAfter(now, now);
    }

}

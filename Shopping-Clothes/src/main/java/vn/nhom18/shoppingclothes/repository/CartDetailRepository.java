package vn.nhom18.shoppingclothes.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.nhom18.shoppingclothes.domain.Cart;
import vn.nhom18.shoppingclothes.domain.CartDetail;
import vn.nhom18.shoppingclothes.domain.ProductDetail;

public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    CartDetail findByCartAndProductDetail(Cart cart, ProductDetail productDetail);
}

package vn.nhom18.shoppingclothes.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.nhom18.shoppingclothes.domain.Cart;
import vn.nhom18.shoppingclothes.domain.CartDetail;
import vn.nhom18.shoppingclothes.domain.Order;
import vn.nhom18.shoppingclothes.domain.OrderDetail;
import vn.nhom18.shoppingclothes.domain.Product;
import vn.nhom18.shoppingclothes.domain.ProductDetail;
import vn.nhom18.shoppingclothes.domain.User;
import vn.nhom18.shoppingclothes.repository.CartDetailRepository;
import vn.nhom18.shoppingclothes.repository.CartRepository;
import vn.nhom18.shoppingclothes.repository.OrderDetailRepository;
import vn.nhom18.shoppingclothes.repository.OrderRepository;
import vn.nhom18.shoppingclothes.repository.ProductDetailRepository;
import vn.nhom18.shoppingclothes.repository.ProductRepository;

@Service
public class CartService {
    private final UserService userService;
    private final CartRepository cartRepository;
    private final ProductRepository productRepository;
    private final ProductDetailRepository productDetailRepository;
    private final CartDetailRepository cartDetailRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public CartService(UserService userService, CartRepository cartRepository, ProductRepository productRepository,
            ProductDetailRepository productDetailRepository, CartDetailRepository cartDetailRepository,
            OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.userService = userService;
        this.cartRepository = cartRepository;
        this.productRepository = productRepository;
        this.productDetailRepository = productDetailRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity, long color,
            long size) {

        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            // check user đã có Cart chưa ? nếu chưa -> tạo mới
            Cart cart = this.cartRepository.findByUserId(user.getId());

            if (cart == null) {
                // tạo mới cart
                Cart otherCart = new Cart();
                otherCart.setUser(user);
                otherCart.setQuantity(0);
                cart = this.cartRepository.save(otherCart);
            }

            // save cart_detail
            // tìm product by id
            Optional<ProductDetail> productDetail = this.productDetailRepository.findByProductIdAndColorIdAndSizeId(
                    productId,
                    color,
                    size);

            ProductDetail proDetail = productDetail.get();
            // check sản phẩm đã từng được thêm vào giỏ hàng trước đây chưa ?
            CartDetail oldDetail = this.cartDetailRepository.findByCartAndProductDetail(cart, proDetail);
            Optional<Product> product = this.productRepository.findById(productId);
            if (oldDetail == null) {
                CartDetail cd = new CartDetail();
                cd.setCart(cart);
                cd.setProductDetail(proDetail);
                cd.setPrice(product.get().getPrice());
                cd.setQuantity(quantity);
                cd.setColor((proDetail.getColor().getName()));
                cd.setSize((proDetail.getSize().getName()));
                this.cartDetailRepository.save(cd);

                // update cart (sum);
                long s = cart.getQuantity() + 1;
                cart.setQuantity(s);
                this.cartRepository.save(cart);
                session.setAttribute("sum", s);
            } else {
                oldDetail.setQuantity(oldDetail.getQuantity() + quantity);
                this.cartDetailRepository.save(oldDetail);
            }

        }

    }

    public Cart fetchByUser(User user) {
        return this.cartRepository.findByUserId(user.getId());
    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        }
    }

    public void handlePlaceOrder(
            User user, HttpSession session,
            String receiverName, String receiverAddress, String receiverPhone, String paymentMethod, String uuid) {

        // Step 1: Get cart by user
        Cart cart = this.cartRepository.findByUserId(user.getId());
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();

            if (cartDetails != null) {

                // Create order
                Order order = new Order();
                order.setUser(user);
                order.setReceiverName(receiverName);
                order.setReceiverAddress(receiverAddress);
                order.setReceiverPhone(receiverPhone);
                order.setOrderDate(LocalDateTime.now());
                order.setStatus("Đang xử lý");
                order.setPaymentMethod(paymentMethod);
                order.setPaymentStatus("PAYMENT_UNPAID");

                order.setPaymentRef(paymentMethod.equals("COD") ? "UNKNOWN" : uuid);

                // Get final price from session (after applying discount)
                Double finalPrice = (Double) session.getAttribute("finalPrice");

                // Use finalPrice if available, otherwise calculate total price from cart
                if (finalPrice != null) {
                    order.setTotalPrice(finalPrice); // Set final price after discount
                } else {
                    // If no discount was applied, calculate the total price from cart
                    double sum = 0;
                    for (CartDetail cd : cartDetails) {
                        sum += cd.getPrice() * cd.getQuantity();
                    }
                    order.setTotalPrice(sum);
                }

                order = this.orderRepository.save(order);

                // Create orderDetail for each product in the cart
                for (CartDetail cd : cartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProductDetail(cd.getProductDetail());
                    orderDetail.setPrice(cd.getPrice());
                    orderDetail.setQuantity(cd.getQuantity());
                    orderDetail.setColor(cd.getColor());
                    orderDetail.setSize(cd.getSize());
                    this.orderDetailRepository.save(orderDetail);

                    ProductDetail productDetail = cd.getProductDetail();
                    if (productDetail.getQuantity() >= cd.getQuantity()) {
                        productDetail.setQuantity(productDetail.getQuantity() - cd.getQuantity());
                        this.productDetailRepository.save(productDetail);
                    } else {
                        throw new IllegalStateException("Số lượng sản phẩm trong kho không đủ.");
                    }
                }

                // Step 2: Delete cart_detail and cart
                for (CartDetail cd : cartDetails) {
                    this.cartDetailRepository.deleteById(cd.getId());
                }

                this.cartRepository.deleteById(cart.getId());

                // Step 3: Update session, reset cart total
                session.setAttribute("sum", 0);
            }
        }
    }

    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();

            Cart currentCart = cartDetail.getCart();
            // delete cart-detail
            this.cartDetailRepository.deleteById(cartDetailId);

            // update cart
            if (currentCart.getQuantity() > 1) {
                // update current cart
                long s = currentCart.getQuantity() - 1;
                currentCart.setQuantity(s);
                session.setAttribute("sum", s);
                this.cartRepository.save(currentCart);
            } else {
                // delete cart (sum = 1)
                this.cartRepository.deleteById(currentCart.getId());
                session.setAttribute("sum", 0);
            }
        }
    }

    public void updatePaymentStatus(String paymentRef, String paymentStatus) {
        Optional<Order> orderOptional = this.orderRepository.findByPaymentRef(paymentRef);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            order.setPaymentStatus(paymentStatus);
            this.orderRepository.save(order);
        }
    }
}
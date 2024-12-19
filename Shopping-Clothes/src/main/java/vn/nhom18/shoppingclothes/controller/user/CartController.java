package vn.nhom18.shoppingclothes.controller.user;

import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.nhom18.shoppingclothes.service.CartService;
import vn.nhom18.shoppingclothes.service.DiscountService;
import vn.nhom18.shoppingclothes.service.VNPayService;
import vn.nhom18.shoppingclothes.domain.User;
import vn.nhom18.shoppingclothes.domain.Cart;
import vn.nhom18.shoppingclothes.domain.CartDetail;
import vn.nhom18.shoppingclothes.domain.Discount;

@Controller
public class CartController {
    private final CartService cartService;
    private final DiscountService discountService;
    private final VNPayService vNPayService;

    public CartController(CartService cartService, DiscountService discountService, VNPayService vNPayService) {
        this.cartService = cartService;
        this.discountService = discountService;
        this.vNPayService = vNPayService;

    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        User currentUser = new User();
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = this.cartService.fetchByUser(currentUser);
        List<CartDetail> cartDetail = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        double totalDetail = 0;
        for (CartDetail cd : cartDetail) {
            totalDetail += cd.getPrice() * cd.getQuantity();
        }
        model.addAttribute("cartDetails", cartDetail);
        model.addAttribute("totalPrice", totalDetail);
        model.addAttribute("cart", cart);
        model.addAttribute("activePage", "cart");
        return "user/cart";
    }

    @PostMapping("/add-to-cart")
    public String addToCart(
            @RequestParam("id") Long productId,
            @RequestParam("size") Long sizeId,
            @RequestParam("color") Long colorId,
            @RequestParam("quantity") Long quantity1,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");

        try {
            this.cartService.handleAddProductToCart(email, productId, session, quantity1, colorId, sizeId);

            redirectAttributes.addFlashAttribute("message", "Đã thêm sản phẩm vào giỏ hàng thành công!");
            redirectAttributes.addFlashAttribute("alertType", "success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Không thể thêm sản phẩm vào giỏ hàng. Vui lòng thử lại!");
            redirectAttributes.addFlashAttribute("alertType", "error");
        }

        return "redirect:/";
    }

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        User currentUser = new User();
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = this.cartService.fetchByUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<>() : cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        Double finalPrice = (Double) session.getAttribute("finalPrice");
        if (finalPrice == null) {
            finalPrice = totalPrice;
        }

        List<Discount> discounts = discountService.getActiveDiscounts();

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("finalPrice", finalPrice);
        model.addAttribute("discounts", discounts);

        return "user/checkout";
    }

    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        this.cartService.handleUpdateCartBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone,
            @RequestParam("paymentMethod") String paymentMethod,
            @RequestParam("totalPrice") String totalPrice, RedirectAttributes redirectAttributes)
            throws UnsupportedEncodingException {
        User currentUser = new User();
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);
        final String uuid = UUID.randomUUID().toString().replace("-", "");
        this.cartService.handlePlaceOrder(currentUser, session, receiverName, receiverAddress, receiverPhone,
                paymentMethod, uuid);
        if (!paymentMethod.equals("COD")) {

            String ip = this.vNPayService.getIpAddress(request);
            String vnpUrl = this.vNPayService.generateVNPayURL(Double.parseDouble(totalPrice), uuid, ip);

            return "redirect:" + vnpUrl;
        }
        redirectAttributes.addFlashAttribute("message", "Cảm ơn bạn đã mua hàng!");
        redirectAttributes.addFlashAttribute("alertType", "thank");
        return "redirect:/";
    }

    @GetMapping("/thank")
    public String thankForPage(RedirectAttributes redirectAttributes,
            @RequestParam("vnp_ResponseCode") Optional<String> vnpayResponseCode,
            @RequestParam("vnp_TxnRef") Optional<String> paymentRef) {

        if (vnpayResponseCode.isPresent() && paymentRef.isPresent()) {
            String paymentStatus = vnpayResponseCode.get().equals("00") ? "PAYMENT_SUCCEED" : "PAYMENT_FAILED";
            this.cartService.updatePaymentStatus(paymentRef.get(), paymentStatus);
        }
        redirectAttributes.addFlashAttribute("message", "Cảm ơn bạn đã mua hàng!");
        redirectAttributes.addFlashAttribute("alertType", "thank");
        return "redirect:/";
    }

    @PostMapping("/apply-discount")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> applyDiscount(@RequestParam("discountCode") String discountCode,
            HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        Map<String, Object> response = new HashMap<>();

        if (session == null || session.getAttribute("id") == null) {
            response.put("error", "Bạn cần đăng nhập để áp dụng mã giảm giá!");
            return ResponseEntity.badRequest().body(response);
        }

        User currentUser = new User();
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = cartService.fetchByUser(currentUser);
        if (cart == null || cart.getCartDetails().isEmpty()) {
            response.put("error", "Giỏ hàng của bạn đang trống!");
            return ResponseEntity.badRequest().body(response);
        }

        Discount discount = discountService.findByCode(discountCode);
        if (discount == null || discount.getEndDate().isBefore(LocalDateTime.now())) {
            response.put("error", "Mã giảm giá không hợp lệ hoặc đã hết hạn!");
            return ResponseEntity.badRequest().body(response);
        }

        if (discount.getQuantity() <= 0) {
            response.put("error", "Mã giảm giá đã hết!");
            return ResponseEntity.badRequest().body(response);
        }

        double totalPrice = 0;
        for (CartDetail cd : cart.getCartDetails()) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        double discountAmount = Math.min(totalPrice * discount.getDiscountPercent() / 100, discount.getMaxDiscount());
        double finalPrice = totalPrice - discountAmount;

        discount.setQuantity(discount.getQuantity() - 1);
        discountService.save(discount);

        session.setAttribute("discountCode", discountCode);
        session.setAttribute("discountAmount", discountAmount);
        session.setAttribute("finalPrice", finalPrice);

        response.put("discountAmount", discountAmount);
        response.put("finalPrice", finalPrice);
        response.put("message", "Mã giảm giá đã được áp dụng thành công!");

        return ResponseEntity.ok(response);
    }

    @PostMapping("/remove-discount")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> removeDiscount(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        Map<String, Object> response = new HashMap<>();

        if (session == null || session.getAttribute("id") == null) {
            response.put("error", "Bạn cần đăng nhập để hủy mã giảm giá!");
            return ResponseEntity.badRequest().body(response);
        }

        Double totalPrice = (Double) session.getAttribute("totalPrice");

        if (totalPrice == null) {
            User currentUser = new User();
            long id = (long) session.getAttribute("id");
            currentUser.setId(id);

            Cart cart = cartService.fetchByUser(currentUser);
            totalPrice = 0.0;
            for (CartDetail cd : cart.getCartDetails()) {
                totalPrice += cd.getPrice() * cd.getQuantity();
            }
        }

        session.removeAttribute("discountCode");
        session.removeAttribute("discountAmount");
        session.removeAttribute("finalPrice");

        response.put("message", "Mã giảm giá đã được hủy!");
        response.put("finalPrice", totalPrice);

        return ResponseEntity.ok(response);
    }

    @PostMapping("/cart/delete-cart-product/{id}")
    public String deleteProductToCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long cartDetailId = id;
        this.cartService.handleRemoveCartDetail(cartDetailId, session);
        return "redirect:/cart";
    }

    @PostMapping("/reset-discount")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> resetDiscount(HttpSession session) {
        session.removeAttribute("discountAmount");
        session.setAttribute("finalPrice", session.getAttribute("totalPrice"));

        Map<String, Object> response = new HashMap<>();
        response.put("totalPrice", session.getAttribute("totalPrice"));
        return ResponseEntity.ok(response);
    }

}

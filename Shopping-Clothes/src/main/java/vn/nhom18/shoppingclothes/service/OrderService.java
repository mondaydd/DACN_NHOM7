package vn.nhom18.shoppingclothes.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.nhom18.shoppingclothes.domain.Order;
import vn.nhom18.shoppingclothes.domain.OrderDetail;
import vn.nhom18.shoppingclothes.repository.OrderDetailRepository;
import vn.nhom18.shoppingclothes.repository.OrderRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    // Lấy danh sách đơn hàng của người dùng (có phân trang)
    public Page<Order> getOrdersByUserId(long userId, Pageable pageable) {
        return orderRepository.findByUserId(userId, pageable);
    }

    // Lấy thông tin chi tiết của một đơn hàng theo orderId
    public Order getOrderById(long orderId, long userId) {
        // Retrieve order by orderId and userId to ensure that the user can only view
        // their own orders
        return orderRepository.findByIdAndUserId(orderId, userId);
    }

    // Lấy chi tiết đơn hàng (order details) theo orderId
    public List<OrderDetail> getOrderDetailsByOrderId(long orderId) {
        // Retrieve all order details by orderId
        return orderDetailRepository.findByOrderId(orderId);
    }

    public Page<Order> getOrdersByPage(int page, int size) {
        Pageable pageable = PageRequest.of(page, size);
        return this.orderRepository.findAll(pageable);
    }

    public Optional<Order> fetchOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    public void updateOrder(Order order) {
        Optional<Order> orderOptional = this.fetchOrderById(order.getId());
        if (orderOptional.isPresent()) {
            Order currentOrder = orderOptional.get();
            currentOrder.setStatus(order.getStatus());
            this.orderRepository.save(currentOrder);
        }
    }

    public void deleteOrderById(long id) {
        // delete order detail
        Optional<Order> orderOptional = this.fetchOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            List<OrderDetail> orderDetails = order.getOrderDetails();
            for (OrderDetail orderDetail : orderDetails) {
                this.orderDetailRepository.deleteById(orderDetail.getId());
            }
        }

        this.orderRepository.deleteById(id);

    }

    public void cancelOrder(long orderId) {
        Order order = orderRepository.findById(orderId).orElseThrow(() -> new RuntimeException("Order not found"));
        if ("Đang xử lý".equals(order.getStatus())) {
            order.setStatus("Đã hủy");
            orderRepository.save(order);
        } else {
            throw new RuntimeException("Không thể hủy đơn hàng");
        }
    }

    public Page<Order> searchOrders(String search, String status, int page, int size) {
        Pageable pageable = PageRequest.of(page, size);

        if (search != null && !search.isEmpty() && status != null && !status.isEmpty()) {
            // Tìm kiếm theo cả trạng thái và từ khóa
            return orderRepository
                    .findByReceiverNameContainingIgnoreCaseOrReceiverPhoneContainingIgnoreCaseOrDiscountDescriptionContainingIgnoreCaseAndStatusContainingIgnoreCase(
                            search, search, search, status, pageable);
        } else if (search != null && !search.isEmpty()) {
            // Tìm kiếm theo từ khóa
            return orderRepository
                    .findByReceiverNameContainingIgnoreCaseOrReceiverPhoneContainingIgnoreCaseOrDiscountDescriptionContainingIgnoreCase(
                            search, search, search, pageable);
        } else if (status != null && !status.isEmpty()) {
            // Tìm kiếm theo trạng thái
            return orderRepository.findByStatusContainingIgnoreCase(status, pageable);
        } else {
            // Trả về tất cả đơn hàng nếu không có tìm kiếm
            return orderRepository.findAll(pageable);
        }
    }

}

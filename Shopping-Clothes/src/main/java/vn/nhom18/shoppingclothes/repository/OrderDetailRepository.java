package vn.nhom18.shoppingclothes.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import vn.nhom18.shoppingclothes.domain.OrderDetail;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
    // lấy số lượng bán theo ngày
    @Query(value = "SELECT COALESCE(SUM(quantity), 0) FROM shopping.orders inner join    shopping.order_details ON shopping.orders.id = shopping.order_details.order_id WHERE DATE(order_date) = CURRENT_DATE", nativeQuery = true)
    int getTotalQuantityByToday();

    // lấy số lượng bán theo tháng
    @Query(value = "SELECT COALESCE(SUM(quantity), 0) FROM shopping.orders inner join shopping.order_details ON shopping.orders.id = shopping.order_details.order_id WHERE MONTH(order_date) = MONTH(CURRENT_DATE) AND YEAR(order_date) = YEAR(CURRENT_DATE)", nativeQuery = true)
    int getTotalQuantityByMonth();

    // lấy số lượng bán theo năm
    @Query(value = "SELECT COALESCE(SUM(quantity), 0) FROM shopping.orders inner join shopping.order_details ON shopping.orders.id = shopping.order_details.order_id WHERE YEAR(order_date) = YEAR(CURRENT_DATE)", nativeQuery = true)
    int getTotalQuantityByYear();

    // lấy số lượng bán theo tuần
    @Query(value = "SELECT COALESCE(SUM(quantity), 0) FROM shopping.orders inner join shopping.order_details ON shopping.orders.id = shopping.order_details.order_id WHERE WEEKDAY(order_date) = WEEKDAY(CURRENT_DATE)  AND  MONTH(order_date) = MONTH(CURRENT_DATE) AND YEAR(order_date) = YEAR(CURRENT_DATE)", nativeQuery = true)
    int getTotalQuantityByWeak();

    // lấy số lượng bán các ngày trong tuần
    @Query(value = "SELECT COALESCE(SUM(quantity), 0) FROM shopping.orders inner join shopping.order_details ON shopping.orders.id = shopping.order_details.order_id WHERE WEEKDAY(order_date) = :weekday AND MONTH(order_date) = MONTH(CURRENT_DATE) AND YEAR(order_date) = YEAR(CURRENT_DATE)", nativeQuery = true)
    int totalQuantityByDayOfWeek(int weekday);

    // lấy số lượng bán các ngày trong tháng
    @Query(value = "SELECT COALESCE(SUM(quantity), 0) FROM shopping.orders inner join shopping.order_details ON shopping.orders.id = shopping.order_details.order_id WHERE DAY(order_date) = :day AND MONTH(order_date) = MONTH(CURRENT_DATE) AND YEAR(order_date) = YEAR(CURRENT_DATE)", nativeQuery = true)
    int totalQuantityByDayOfMonth(int day);

    // lấy số lượng bán các tháng trong năm
    @Query(value = "SELECT COALESCE(SUM(quantity), 0) FROM shopping.orders inner join shopping.order_details ON shopping.orders.id = shopping.order_details.order_id WHERE MONTH(order_date) = :month AND YEAR(order_date) = YEAR(CURRENT_DATE)", nativeQuery = true)
    int totalQuantityByMonthOfYear(int month);

    // lấy số lượng bán các năm
    @Query(value = "SELECT COALESCE(SUM(quantity), 0) FROM shopping.orders inner join shopping.order_details ON shopping.orders.id = shopping.order_details.order_id WHERE  YEAR(order_date) = :year", nativeQuery = true)
    int totalQuantityBy10Year(int year);

    // lấy sản phẩm bán chạy theo ngày
    @Query(value = "SELECT od.product_detail_id, od.price, SUM(od.price * od.quantity) AS total_revenue, SUM(od.quantity) AS total_quantity FROM shopping.orders o INNER JOIN shopping.order_details od ON o.id = od.order_id WHERE DATE(o.order_date) = CURRENT_DATE GROUP BY od.product_detail_id, od.price ORDER BY total_quantity DESC LIMIT 5", nativeQuery = true)
    List<Object[]> bestSaleByDay();

    // lấy sản phẩm bán chạy theo tuần
    @Query(value = "SELECT od.product_detail_id, od.price, SUM(od.price * od.quantity) AS total_revenue, SUM(od.quantity) AS total_quantity FROM shopping.orders o INNER JOIN shopping.order_details od ON o.id = od.order_id WHERE WEEKDAY(o.order_date) = WEEKDAY(CURRENT_DATE) AND MONTH(o.order_date) = MONTH(CURRENT_DATE) AND YEAR(o.order_date) = YEAR(CURRENT_DATE) GROUP BY od.product_detail_id, od.price ORDER BY total_quantity DESC LIMIT 5", nativeQuery = true)
    List<Object[]> bestSaleByWeek();

    // lấy sản phẩm bán chạy theo tháng
    @Query(value = "SELECT od.product_detail_id, od.price, SUM(od.price * od.quantity) AS total_revenue, SUM(od.quantity) AS total_quantity FROM shopping.orders o INNER JOIN shopping.order_details od ON o.id = od.order_id WHERE MONTH(o.order_date) = MONTH(CURRENT_DATE) AND YEAR(o.order_date) = YEAR(CURRENT_DATE) GROUP BY od.product_detail_id, od.price ORDER BY total_quantity DESC LIMIT 5", nativeQuery = true)
    List<Object[]> bestSaleByMonth();

    // lấy sản phẩm bán chạy theo năm
    @Query(value = "SELECT od.product_detail_id, od.price, SUM(od.price * od.quantity) AS total_revenue, SUM(od.quantity) AS total_quantity FROM shopping.orders o INNER JOIN shopping.order_details od ON o.id = od.order_id WHERE YEAR(o.order_date) = YEAR(CURRENT_DATE) GROUP BY od.product_detail_id, od.price ORDER BY total_quantity DESC LIMIT 5", nativeQuery = true)
    List<Object[]> bestSaleByYear();



      // Tìm chi tiết đơn hàng theo orderId
      List<OrderDetail> findByOrderId(long orderId);
}

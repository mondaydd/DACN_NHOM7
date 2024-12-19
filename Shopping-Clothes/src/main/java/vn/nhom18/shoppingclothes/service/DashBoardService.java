package vn.nhom18.shoppingclothes.service;

import java.util.List;

import org.springframework.stereotype.Service;
import vn.nhom18.shoppingclothes.domain.Order;
import vn.nhom18.shoppingclothes.domain.dto.OrderDetailDTO;
import vn.nhom18.shoppingclothes.repository.OrderDetailRepository;
import vn.nhom18.shoppingclothes.repository.OrderRepository;
import vn.nhom18.shoppingclothes.repository.UserRepository;

@Service
public class DashBoardService {
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public DashBoardService(UserRepository userRepository, OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.userRepository = userRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    // Lấy người dùng theo ngày
    public long HandleCountUserByDay() {
        return userRepository.countUsersByToday();
    }

    // Lấy người dùng theo tháng
    public long HandleCountUserByMonth() {
        return userRepository.countUsersByCurrentMonth();
    }

    // Lấy người dùng theo năm
    public long HandleCountUserByYear() {
        return userRepository.countUsersByCurrentYear();
    }

    // Lấy người dùng theo năm
    public long HandleCountUserByWeek() {
        return userRepository.countUsersByCurrentWeek();
    }

    // Đếm số lượng người dùng theo các ngày trong tuần
    public int HandleCountUserByDayOfWeek(int date) {
        return this.userRepository.countUsersByDayOfWeek(date);
    }

    // Đếm số lượng người dùng theo các ngày trong tháng
    public int HandleCountUserByDayOfMonth(int day) {
        return this.userRepository.countUsersByDayOfMonth(day);
    }

    // Đếm số lượng người dùng theo các tháng trong năm
    public int HandleCountUserByMonthOfYear(int month) {
        return this.userRepository.countUsersByMonthOfYear(month);
    }

    // Đếm số lượng người dùng theo 10 năm
    public int HandleCountUserBy10Year(int year) {
        return this.userRepository.countUsersBy10Year(year);
    }

    // Lấy tổng doanh thu theo ngày
    public double HandleTotalPriceByDay() {
        return this.orderRepository.getTotalPriceByToday();
    }

    // Lấy tổng doanh thu theo Tháng
    public double HandleTotalPriceByMonth() {
        return this.orderRepository.getTotalPriceByMonth();
    }

    // Lấy tổng doanh thu theo năm
    public double HandleTotalPriceByYear() {
        return this.orderRepository.getTotalPriceByYear();
    }

    // Lấy tổng doanh thu theo tuần
    public double HandleTotalPriceByWeek() {
        return this.orderRepository.getTotalPriceByWeek();
    }

    // Tổng doanh thu theo các ngày trong tuần
    public double HandleTotalPriceByDayOfWeek(int date) {
        return this.orderRepository.totalPriceByDayOfWeek(date);
    }

    // Tổng doanh thu theo các ngày trong tháng
    public double HandleTotalPriceByDayOfMonth(int day) {
        return this.orderRepository.totalPriceByDayOfMonth(day);
    }

    // Tổng doanh thu theo các tháng trong năm
    public double HandleTotalPriceByMonthOfYear(int month) {
        return this.orderRepository.totalPriceByMonthOfYear(month);
    }

    // Tổng doanh thu theo 10 năm
    public double HandleTotalPriceBy10Year(int year) {
        return this.orderRepository.totalPriceBy10Year(year);
    }

    // Lấy tổng số lượng theo ngày
    public int HandleTotalQuantityByDay() {
        return this.orderDetailRepository.getTotalQuantityByToday();
    }

    // Lấy tổng số lượng theo tháng
    public int HandleTotalQuantityByMonth() {
        return this.orderDetailRepository.getTotalQuantityByMonth();
    }

    // Lấy tổng số lượng theo năm
    public int HandleTotalQuantityByYear() {
        return this.orderDetailRepository.getTotalQuantityByYear();
    }

    // Lấy tổng số lượng theo tuần
    public int HandleTotalQuantityByWeek() {
        return this.orderDetailRepository.getTotalQuantityByWeak();
    }

    // Tổng số lượng theo các ngày trong tuần
    public int HandleTotalQuantityByDayOfWeek(int day) {
        return this.orderDetailRepository.totalQuantityByDayOfWeek(day);
    }

    // Tổng số lượng theo các ngày trong tháng
    public int HandleTotalQuantityByDayOfMonth(int day) {
        return this.orderDetailRepository.totalQuantityByDayOfMonth(day);
    }

    // Tổng số lượng theo các tháng trong năm
    public int HandleTotalQuantityByDayMonthOfYear(int day) {
        return this.orderDetailRepository.totalQuantityByMonthOfYear(day);
    }

    public int HandleTotalQuantityBy10Year(int year) {
        return this.orderDetailRepository.totalQuantityBy10Year(year);
    }

    // lấy 5 đơn hàng gần nhất theo ngày
    public List<Order> HandleCurrentOrderByDay() {
        return this.orderRepository.getCurrentOrderByDay();
    }

    // lấy 5 đơn hàng gần nhất theo tuần
    public List<Order> HandleCurrentOrderByWeek() {
        return this.orderRepository.getCurrentOrderByWeek();
    }

    // lấy 5 đơn hàng gần nhất theo tháng
    public List<Order> HandleCurrentOrderByMonth() {
        return this.orderRepository.getCurrentOrderByMonth();
    }

    // lấy 5 đơn hàng gần nhất theo năm
    public List<Order> HandleCurrentOrderByYear() {
        return this.orderRepository.getCurrentOrderByYear();
    }

    // lấy 5 sản phẩm bán chạy theo tháng
    public List<Object[]> HandleBestSaleByDay() {
        return this.orderDetailRepository.bestSaleByDay();
    }

    // lấy 5 sản phẩm bán chạy theo tháng
    public List<Object[]> HandleBestSaleByWeek() {
        return this.orderDetailRepository.bestSaleByWeek();
    }

    // lấy 5 sản phẩm bán chạy theo tháng
    public List<Object[]> HandleBestSaleByMonth() {
        return this.orderDetailRepository.bestSaleByMonth();
    }

    // lấy 5 sản phẩm bán chạy theo tháng
    public List<Object[]> HandleBestSaleByYear() {
        return this.orderDetailRepository.bestSaleByYear();
    }
}

package vn.nhom18.shoppingclothes.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import vn.nhom18.shoppingclothes.domain.User;
import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    User findByRole_Name(String roleName);

    User findById(long id);

    void deleteById(long id);

    User findByEmail(String email);

    List<User> findOneByEmail(String email);

    List<User> findAll();

    Page<User> findAll(Pageable pageable);

    boolean existsByEmail(String email);

    @Query("SELECT u FROM User u WHERE LOWER(u.email) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
            "OR LOWER(u.name) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    Page<User> findByKeyword(@Param("keyword") String keyword, Pageable pageable);

    // lấy số lượng người dùng theo ngày
    @Query(value = "SELECT COUNT(*) FROM users WHERE DATE(create_date) = CURRENT_DATE", nativeQuery = true)
    long countUsersByToday();

    // lấy số lượng người dùng theo tháng
    @Query(value = "SELECT COUNT(*) FROM users WHERE MONTH(create_date) = MONTH(CURRENT_DATE) AND YEAR(create_date) = YEAR(CURRENT_DATE)", nativeQuery = true)
    long countUsersByCurrentMonth();

    // lấy số lượng người dùng theo tuần
    @Query(value = "SELECT COUNT(*) FROM users WHERE WEEKDAY(create_date) = WEEKDAY(CURRENT_DATE) AND MONTH(create_date) = MONTH(CURRENT_DATE) AND YEAR(create_date) = YEAR(CURRENT_DATE)", nativeQuery = true)
    long countUsersByCurrentWeek();

    // lấy số lượng người dùng theo năm
    @Query(value = "SELECT COUNT(*) FROM users WHERE YEAR(create_date) = YEAR(CURRENT_DATE)", nativeQuery = true)
    long countUsersByCurrentYear();

    // lấy số lượng người theo các ngày trong tuần
    @Query("SELECT COUNT(u) FROM User u WHERE WEEKDAY(u.createDate) = :dayOfWeek AND MONTH(u.createDate) = MONTH(CURRENT_DATE) AND YEAR(u.createDate) = YEAR(CURRENT_DATE)")
    int countUsersByDayOfWeek(int dayOfWeek);

    // lấy số lượng người theo các ngày trong tháng
    @Query("SELECT COUNT(u) FROM User u WHERE DAY(u.createDate) = :day AND MONTH(u.createDate) = MONTH(CURRENT_DATE) AND YEAR(u.createDate) = YEAR(CURRENT_DATE)")
    int countUsersByDayOfMonth(@Param("day") int day);

    // lấy số lượng người dùng theo các tháng trong năm
    @Query("SELECT COUNT(u) FROM User u WHERE MONTH(u.createDate) = :month AND YEAR(u.createDate) = YEAR(CURRENT_DATE)")
    int countUsersByMonthOfYear(@Param("month") int month);

    // lấy số lượng người dùng theo năm
    @Query("SELECT COUNT(u) FROM User u WHERE YEAR(u.createDate) = :year")
    int countUsersBy10Year(@Param("year") int year);


    List<User> findAllByRole_Name(String roleName);
}

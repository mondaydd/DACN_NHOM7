package vn.nhom18.shoppingclothes.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.nhom18.shoppingclothes.domain.User;
import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    User findById(long id);
}

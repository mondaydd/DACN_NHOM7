package vn.nhom18.shoppingclothes.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.nhom18.shoppingclothes.domain.Role;

public interface RoleRepository extends JpaRepository<Role, Long> {
    Role findByName(String name);
}

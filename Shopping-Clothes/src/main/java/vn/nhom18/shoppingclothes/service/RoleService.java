package vn.nhom18.shoppingclothes.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.nhom18.shoppingclothes.domain.Role;
import vn.nhom18.shoppingclothes.repository.RoleRepository;

@Service
public class RoleService {
    @Autowired
    private RoleRepository roleRepository;

    // Phương thức để lấy tất cả vai trò
    public List<Role> getAllRoles() {
        return roleRepository.findAll();
    }
}

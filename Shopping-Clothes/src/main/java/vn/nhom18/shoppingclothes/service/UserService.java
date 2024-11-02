package vn.nhom18.shoppingclothes.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.nhom18.shoppingclothes.domain.Role;
import vn.nhom18.shoppingclothes.domain.User;
import vn.nhom18.shoppingclothes.repository.RoleRepository;
import vn.nhom18.shoppingclothes.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;

    public UserService(UserRepository userRepository, RoleRepository roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    public List<User> handlegetAllUser() {
        return this.userRepository.findAll();
    }

    public void handleSaveUser(User user) {
        this.userRepository.save(user);
    }

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    public User getUserById(long id) {
        return this.userRepository.findById(id);
    }

    public void handleDeleteUser(long id) {
        this.userRepository.deleteById(id);
    }

}

package vn.nhom18.shoppingclothes.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.nhom18.shoppingclothes.domain.Color;

@Repository
public interface ColorRepository extends JpaRepository<Color, Long> {

}

package vn.nhom18.shoppingclothes;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
// @SpringBootApplication(exclude = org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration.class)
public class ShoppingClothesApplication {
	public static void main(String[] args) {
		SpringApplication.run(ShoppingClothesApplication.class, args);
	}

}

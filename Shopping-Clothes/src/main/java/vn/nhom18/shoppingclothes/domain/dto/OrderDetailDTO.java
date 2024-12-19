package vn.nhom18.shoppingclothes.domain.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class OrderDetailDTO {
    private int productId;
    private String proName;
    private double sumPrice;
    private int sumQuantity;
    private double price;
}

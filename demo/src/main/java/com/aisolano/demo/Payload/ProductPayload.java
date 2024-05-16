package com.aisolano.demo.Payload;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.math.BigDecimal;

@Data
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = false)
public class ProductPayload {
    private String productName;
    private BigDecimal productPrice;
    private String productImage;
    private String productSku;
    private String category;
    private Long id;
}

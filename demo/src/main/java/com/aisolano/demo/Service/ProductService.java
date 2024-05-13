package com.aisolano.demo.Service;

import com.aisolano.demo.Entity.Product;
import com.aisolano.demo.Payload.ProductPayload;
import com.aisolano.demo.Repository.ProductRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;

    @Transactional
    public Product createProduct(ProductPayload productPayload) {
        Product product = Product.builder()
                .productName(productPayload.getProductName())
                .productPrice(productPayload.getProductPrice())
                .category(productPayload.getCategory())
                .imageURL(productPayload.getProductImage())
                .build();
        if (!productPayload.getProductSku().isEmpty()) {
            product.setSku(productPayload.getProductSku());
        } else if  (productRepository.findTopByOrderByIdDesc().isPresent()){
            product.setSku(productRepository.findTopByOrderByIdDesc().get().getSku());
        } else {
            product.setSku("001");
        }
        return productRepository.save(product);
    }

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public Product getProductById(Long id) {
        return productRepository.getReferenceById(id);
    }

    public Product getProductBySku(String sku) {
        return productRepository.findBySku(sku).get();
    }

    public Optional<Product> updateProduct(ProductPayload productPayload) {
        Product product = null;
        if (productPayload.getId() > 0) {
            product = productRepository.getReferenceById(productPayload.getId());
        } else if (!productPayload.getProductSku().isEmpty()) {
            product = productRepository.findBySku(productPayload.getProductSku()).get();
        }
        if (product != null) {
            if (!productPayload.getProductImage().isEmpty()) {
                product.setImageURL(productPayload.getProductImage());
            }
            if (!productPayload.getProductName().isEmpty()) {
                product.setProductName(productPayload.getProductName());
            }
            if (productPayload.getProductPrice().compareTo(BigDecimal.ZERO) > 0) {
                product.setProductPrice(productPayload.getProductPrice());
            }
            productRepository.save(product);
        }
        return Optional.ofNullable(product);
    }

    public void deleteProduct(Long id){
        Product product = productRepository.getReferenceById(id);
        productRepository.delete(product);
    }
}

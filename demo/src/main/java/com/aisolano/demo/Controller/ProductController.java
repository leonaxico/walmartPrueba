package com.aisolano.demo.Controller;


import com.aisolano.demo.Entity.Product;
import com.aisolano.demo.Payload.ProductPayload;
import com.aisolano.demo.RoleName;
import com.aisolano.demo.Service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api")
@Secured({RoleName.ROLE_USER, RoleName.ROLE_ADMIN})
public class ProductController {
    @Autowired
    private ProductService productService;

    @GetMapping("/products")
    public List<Product> getAllProducts(){
        return productService.getAllProducts();
    }

    @GetMapping("/products/{id}")

    public Product getProductById(
            @PathVariable Long id){
        return productService.getProductById(id);
    }

    @PostMapping("/newProduct")
    public Product newProduct(
            @Valid @RequestBody ProductPayload productPayload){
        return productService.createProduct(productPayload);
    }

    @PostMapping("/updateProduct/{id}")
    public Product updateProduct(
            @Valid @RequestBody ProductPayload productPayload,
            @PathVariable Long id){
        productPayload.setId(id);
        return productService.updateProduct(productPayload).get();
    }

    @DeleteMapping ("/delete/{id}")
    public void deleteProduct(
            @PathVariable Long id){
        productService.deleteProduct(id);
    }
}

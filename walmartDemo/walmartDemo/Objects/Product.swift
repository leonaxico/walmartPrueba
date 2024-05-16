//
//  Product.swift
//  walmartDemo
//
//  Created by Axel Iván Solano González on 13/05/24.
//

import Foundation

struct Product: Codable {
    let id: Int?
    let productName: String
    let productPrice: Double
    let imageURL: String?
    let sku: String
    let category: String
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.productName = try values.decode(String.self, forKey: .productName)
        self.productPrice = try values.decode(Double.self, forKey: .productPrice)
        self.imageURL = try values.decode(String.self, forKey: .imageURL)
        self.sku = try values.decode(String.self, forKey: .sku)
        self.category = try values.decode(String.self, forKey: .category)
    }
    
    init(id: Int?, productName: String, productPrice: Double, imageURL: String?, sku: String, category: String){
        self.id = id
        self.productName = productName
        self.productPrice = productPrice
        self.imageURL = imageURL
        self.sku = sku
        self.category = category
    }
    
    func toMap() -> [String:Any] {
        var map:[String:Any] = [
            "productName": productName,
            "productPrice": productPrice,
            "productSku": sku,
            "category": category,
        ]
        if let imageURL = imageURL {
            map.updateValue(imageURL, forKey: "productImage")
        }
        if let id = id {
            map.updateValue(id, forKey: "id")
        }
        return map
    }
}

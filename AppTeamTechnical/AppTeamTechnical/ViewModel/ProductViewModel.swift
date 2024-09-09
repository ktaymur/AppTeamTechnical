//
//  ProductViewModel.swift
//  AppTeamTechnical
//
//  Created by Kate Murray on 9/7/24.
//

import Foundation

struct ProductViewModel {
    
    func getProducts(completion: @escaping ([Product]?) -> Void){
        let url = "https://dummyjson.com/products"
        
        guard let realURL = URL(string: url) else {
            print("Invalid URl")
            return
        }
        
        URLSession.shared.dataTask(with: realURL) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let products = try decoder.decode(Products.self, from: data)
                // Print the list of products
                print(products.products)
                completion(products.products)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
    
    func searchProducts(searchText: String, completion: @escaping ([Product]?) -> Void){
        let url = "https://dummyjson.com/products/search?q=\(searchText)"
        
        guard let realURL = URL(string: url) else {
            print("Invalid URl")
            return
        }
        
        URLSession.shared.dataTask(with: realURL) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let products = try decoder.decode(Products.self, from: data)
                // Print the list of products
                print(products.products)
                completion(products.products)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

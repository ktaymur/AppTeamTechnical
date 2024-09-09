//
//  ContentView.swift
//  AppTeamTechnical
//
//  Created by Kate Murray on 9/7/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cart: Products = Products(products: [])
    @State private var liked: Products = Products(products: [])
    
    var body: some View {
        TabView {
            NavigationView{
                SearchView(cart: $cart, liked: $liked)
            }
                .tabItem {
                    Text("Products")
                    Image(systemName: "carrot.fill")
                }
            NavigationView{
                MyItemsView(liked: $liked, cart: $cart)
            }
                .tabItem {
                    Text("My Items")
                    Image(systemName: "heart.fill")
                }
            NavigationView{
                CartView(cartProducts: $cart)
            }
                .tabItem {
                    Text("Cart")
                    Image(systemName: "cart.fill")
                }
                .badge(cart.products.count)
        }
    }
}

#Preview {
    ContentView()
}

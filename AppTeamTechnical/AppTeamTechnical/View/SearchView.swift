//
//  SearchView.swift
//  AppTeamTechnical
//
//  Created by Kate Murray on 9/7/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var products: Products = Products(products: [])
    @State private var vm = ProductViewModel()
    @State private var search = false
    @Binding var cart: Products
    @Binding var liked: Products
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .foregroundColor(.primary)
                    .frame(width: 21, height: 22)
                    .padding(9)
                    .padding([.leading], 3)
                TextField("What are you looking for?", text: $searchText)
                    .foregroundColor(.primary)
                    .frame(width: 300, alignment:.leading)
                    .textFieldStyle(PlainTextFieldStyle())
                    .onSubmit {
                        vm.searchProducts(searchText: searchText) { products in
                            if let products = products {
                                self.products = Products(products: products)
                            } else {
                                print("Failed to fetch products.")
                            }
                        }
                        search = true
                    }
                    .onChange(of: searchText, {
                        if searchText == ""{
                            search = false
                        }
                    })
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color(.tertiarySystemBackground))
            .cornerRadius(100)
            .padding(.bottom, 16)
            
            divider
            
            ScrollView {
                if search {
                    HStack {
                        if products.products.count != 1{
                            Text("\(products.products.count) results for")
                                .padding(.top, 16)
                            Text("\"\(searchText)\"")
                                .fontWeight(.bold)
                                .padding(.top, 16)
                        } else {
                            Text("\(products.products.count) result for")
                                .padding(.top, 16)
                            Text("\"\(searchText)\"")
                                .fontWeight(.bold)
                                .padding(.top, 16)
                        }
                        Spacer()
                    }
                    .padding([.leading, .trailing], 16)
                }
                
                ForEach(products.products){ product in
                    HStack{
                        NavigationLink(destination: ProductView(product: product, cart: $cart, liked: $liked)){
                            if let thumbnail = product.thumbnail{
                                WebImage(url: URL(string: thumbnail))
                                    .resizable()
                                    .frame(width: 140, height: 140)
                            }
                        }
                        VStack{
                            NavigationLink(destination: ProductView(product: product, cart: $cart, liked: $liked)){
                                HStack{
                                    Text(product.title ?? "No Name")
                                        .padding([.top], 2)
                                        .font(.system(size: 17))
                                    Spacer()
                                }
                                .frame(maxHeight: 22)
                            }
                            HStack{
                                Text("$\(product.price?.formatted(.number) ?? "Unknown")")
                                    .font(.system(size: 20))
                                    .fontWeight(.bold)
                                    .padding([.top], 0.5)
                                Spacer()
                            }
                            if let category = product.category{
                                HStack{
                                    HStack{
                                        Text(category)
                                            .font(.system(size: 13))
                                    }
                                    .padding([.bottom, .top], 2)
                                    .padding([.leading, .trailing], 4)
                                    .background(Color(.tertiarySystemBackground))
                                    .cornerRadius(4)
                                    Spacer()
                                }
                                .padding([.bottom], 3)
                            }
                            HStack{
                                CapsuleButton(product: product, cart: $cart)
                                LikeButton(product: product, liked: $liked)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding([.top, .bottom], 12)
                        .padding(.leading, 16)
                    }
                }
            }
            .navigationBarHidden(true)
            .padding([.leading, .trailing], 16)
            .onAppear(perform: { 
                if self.products.products.isEmpty{
                    vm.getProducts { products in
                        if let products = products {
                            self.products = Products(products: products)
                        } else {
                            print("Failed to fetch products.")
                        }
                    }
                }
            })
        }
    }
    
    @ViewBuilder
    private var divider: some View {
        Rectangle()
            .fill(Color.secondary.opacity(0.3))
            .frame(height: 1)
    }
}

// subview for each add to cart button -- allows for individual state variables regarding when each is clicked
struct CapsuleButton: View {
    var product: Product
    @Binding var cart: Products
    @State private var color: Color = .blue
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(color)
                .frame(width: 173, height: 36)
            
            Text("Add to Cart")
                .foregroundStyle(.white)
                .font(.system(size: 17))
        }
        .onTapGesture {
            color = Color.blue.opacity(0.7)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                color = .blue
                cart.products.append(product)
            }
        }
    }
}

//subview for each like button
struct LikeButton: View {
    var product: Product
    @Binding var liked: Products
    @State private var color: Color = Color(.tertiarySystemBackground)
    
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 36, height: 36)
                .foregroundStyle(color)
            if (liked.products.contains(product)) {
            Image(systemName: "heart.fill")
                    .foregroundStyle(.primary)
                    .frame(height: 22)
            } else {
                Image(systemName: "heart")
                    .foregroundStyle(.primary)
                    .frame(height: 22)
            }
            Spacer()
        }
        .onTapGesture {
            color = Color(.tertiarySystemBackground).opacity(0.7)
//            if heartFill == "heart" {
//                heartFill = "heart.fill"
//            } else {
//                heartFill = "heart"
//            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                color = Color(.tertiarySystemBackground)
                if !liked.products.contains(product){
                    liked.products.append(product)
                } else {
                    if let index = liked.products.firstIndex(of: product){
                        liked.products.remove(at: index)
                    }
                }
            }
        }
    }
}

//#Preview {
//    SearchView(cart: Products(products: []))
//}

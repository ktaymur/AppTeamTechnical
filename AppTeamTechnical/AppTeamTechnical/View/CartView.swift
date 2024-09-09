//
//  CartView.swift
//  AppTeamTechnical
//
//  Created by Kate Murray on 9/7/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @Binding var cartProducts: Products
    @State private var selectedOption: String = "Pick Up"
    
    var body: some View {
        VStack{
            HStack{
                BasicDropdownMenu(selectedOption: $selectedOption)
                if selectedOption == "Pick Up"{
                    Text("from")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 16))
                } else {
                    Text("to")
                        .foregroundStyle(.secondary)
                        .font(.system(size: 16))
                }
                Text("Charlotte")
                    .underline()
                    .fontWeight(.bold)
                    .font(.system(size: 16))
                Spacer()
            }
            .padding(.top, 6)
            ScrollView{
                VStack{
                    ForEach(cartProducts.products){ product in
                        HStack{
                            if let thumbnail = product.thumbnail{
                                WebImage(url: URL(string: thumbnail))
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .padding([.trailing], 8)
                            }
                            Text(product.title ?? "No product name")
                                .font(.system(size: 17))
                            Spacer()
                            if let price = product.price{
                                Text("$\(price.formatted(.number))")
                                    .fontWeight(.bold)
                                    .font(.title2)
                                    .fontDesign(.rounded)
                            } else {
                                Text("No listed price")
                                    .fontWeight(.bold)
                            }
                        }
                        .padding([.top, .bottom], 12)
                    }
                    Spacer()
                }
            }
            Spacer()
            ZStack{
                Capsule()
                    .fill(.blue)
                    .frame(width: 361, height: 36)
                Text("Checkout")
                    .foregroundStyle(.white)
            }
            .padding(.bottom, 23)
        }
        .navigationTitle("Cart")
        .padding([.leading, .trailing], 17)
    }
}

// subview for dropdown menu
struct BasicDropdownMenu: View {
    @Binding var selectedOption: String
    
    var body: some View {
        Menu {
            Button("Pick Up", action: { selectedOption = "Pick Up" })
            Button("Delivery", action: { selectedOption = "Delivery" })
        } label: {
            HStack{
                Text(selectedOption)
                    .font(.system(size: 17))
                Image(systemName: "chevron.down")
            }
            .foregroundStyle(.foreground)
            .fontWeight(.bold)
        }
    }
}

//#Preview {
//    CartView(cartProducts: Products(products: [Product(id: 1, title: "Couch", description: "This is a couch! It is super nice, you should buy it.", category: "furniture", price: 19.99, discountPercentage: 7.0, rating: 4.9, stock: 23, tags: ["Couch"], brand: "Anthropologie", sku: nil, weight: 4, dimensions: Dimensions(width: 4, height: 4, depth: 10), warrantyInformation: nil, shippingInformation: nil, availabilityStatus: nil, reviews: [Review(rating: 4.7, comment: "Loved it", date: "2024-05-23T08:56:21.618Z", reviewerName: "Katherine", reviewerEmail: "me@gmail.com"), Review(rating: 4.9, comment: "Love", date: "2024-05-23T08:56:21.618Z", reviewerName: "Matt", reviewerEmail: "mattge@gmail.com"), Review(rating: 3.5, comment: "hate the texture", date: "2024-05-23T08:56:21.618Z", reviewerName: "Karen Mom", reviewerEmail: "karen@gmail.com")], returnPolicy: nil, minimumOrderQuantity: 2, metadata: nil, thumbnail: nil, images: nil), Product(id: 1, title: "Couch", description: "This is a couch! It is super nice, you should buy it.", category: "furniture", price: 19.99, discountPercentage: 7.0, rating: 4.9, stock: 23, tags: ["Couch"], brand: "Anthropologie", sku: nil, weight: 4, dimensions: Dimensions(width: 4, height: 4, depth: 10), warrantyInformation: nil, shippingInformation: nil, availabilityStatus: nil, reviews: [Review(rating: 4.7, comment: "Loved it", date: "2024-05-23T08:56:21.618Z", reviewerName: "Katherine", reviewerEmail: "me@gmail.com"), Review(rating: 4.9, comment: "Love", date: "2024-05-23T08:56:21.618Z", reviewerName: "Matt", reviewerEmail: "mattge@gmail.com"), Review(rating: 3.5, comment: "hate the texture", date: "2024-05-23T08:56:21.618Z", reviewerName: "Karen Mom", reviewerEmail: "karen@gmail.com")], returnPolicy: nil, minimumOrderQuantity: 2, metadata: nil, thumbnail: nil, images: nil)]))
//}

//
//  MyItemsView.swift
//  AppTeamTechnical
//
//  Created by Kate Murray on 9/7/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyItemsView: View {
    @Binding var liked: Products
    @Binding var cart: Products
    @State private var clickAddToCart = false
    
    var body: some View {
            VStack{
                ScrollView {
                    ForEach(liked.products){product in
                        HStack {
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
            .navigationTitle("My Items")
        }
    }
}

//#Preview {
//    MyItemsView()
//}

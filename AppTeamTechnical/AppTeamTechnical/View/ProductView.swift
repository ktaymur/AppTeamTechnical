//
//  ProductView.swift
//  AppTeamTechnical
//
//  Created by Kate Murray on 9/7/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductView: View {
    var product: Product
    let inputFormatter: DateFormatter = {
        let formatted = DateFormatter()
        formatted.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatted.timeZone = TimeZone(secondsFromGMT: 0)
        return formatted
    }()
    
    let dateFormatter: DateFormatter = {
        let formatted = DateFormatter()
        formatted.dateFormat = "MMMM d, yyyy"
        return formatted
    }()
    
    @State private var clickAddToCart = false
    @Binding var cart: Products
    @Binding var liked: Products
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    if let rating = product.rating{
                        StarRatingView(rating: rating)
                        let formatted = String(format: "%.1f", rating)
                        Text(formatted)
                            .foregroundStyle(Color.starYellow)
                        Text("(\(product.reviews?.count ?? 0))")
                            .foregroundStyle(.secondary)
                    }else {
                        Text("No rating")
                    }
                    Spacer()
                }
                .padding([.top, .bottom], 16)
                if let thumbnail = product.thumbnail{
                    WebImage(url: URL(string: thumbnail))
                        .resizable()
                        .frame(width: 350, height: 350)
                }
                HStack{
                    if let price = product.price{
                        Text("$\(price.formatted(.number))")
                            .fontWeight(.bold)
                            .font(.system(size: 28))
                            .fontDesign(.rounded)
                    } else {
                        Text("No listed price")
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
                .padding(.bottom, 12)
                
                HStack{
                    Text("\(product.availabilityStatus ?? "Out of Stock")")
                        .foregroundStyle(product.availabilityStatus == "In Stock" || product.availabilityStatus == "Low Stock" ? .green : .red )
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .font(.system(size: 16))
                    Text("at")
                        .fontDesign(.rounded)
                        .font(.system(size: 16))
                    Text("Charlotte")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                        .underline()
                        .fontDesign(.rounded)
                    Spacer()
                }
                
                HStack{
                    ZStack{
                        Capsule()
                            .fill(clickAddToCart ? Color.blue.opacity(0.7) : Color.blue)
                            .frame(width: 317, height: 36)
                        Text("Add to Cart")
                            .foregroundStyle(.white)
                    }
                    .onTapGesture {
                        clickAddToCart = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            clickAddToCart = false
                            cart.products.append(product)
                        }
                    }
                    ZStack{
                        Circle()
                            .frame(width: 36, height: 36)
                            .foregroundStyle(Color(.secondarySystemBackground))
                        if liked.products.contains(product){
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.primary)
                                .frame(height: 22)
                        } else {
                            Image(systemName: "heart")
                                .foregroundStyle(.primary)
                                .frame(height: 22)
                        }
                    }
                    .padding([.top, .bottom], 20)
                    .onTapGesture {
                        if !liked.products.contains(product){
                            liked.products.append(product)
                        } else {
                            if let index = liked.products.firstIndex(of: product){
                                liked.products.remove(at: index)
                            }
                        }
                    }
                }
                
                VStack{
                    HStack{
                        Text("Description")
                            .font(.title2)
                            .padding(.bottom, 8)
                        Spacer()
                    }
                    HStack{
                        Text(product.description ?? "No description available")
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 20)
                        Spacer()
                    }
                }
                
                VStack{
                    HStack{
                        Text("Reviews")
                            .font(.title2)
                            .padding(.bottom, 5)
                        Spacer()
                        HStack{
                            Image(systemName: "arrow.up.arrow.down")
                                .foregroundStyle(.primary)
                                .font(.footnote)
                            Text("Sort")
                                .foregroundStyle(.primary)
                                .font(.footnote)
                        }
                        .padding(5)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    }
                    if let reviews = product.reviews {
                        ForEach(reviews){ review in
                            VStack{
                                HStack{
                                    Text(review.reviewerName ?? "No Name")
                                        .foregroundStyle(.primary)
                                        .fontWeight(.bold)
                                    Spacer()
                                    if let date = review.date{
                                        if let formatted = inputFormatter.date(from: date){
                                            let finalDate = dateFormatter.string(from: formatted)
                                            Text(finalDate.description)
                                                .foregroundStyle(.secondary)
                                        }
                                    } else {
                                        Text("No known date")
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                HStack{
                                    StarRatingView(rating: review.rating ?? 0.0)
                                    Spacer()
                                }
                                HStack{
                                    Text(review.comment ?? "")
                                        .foregroundStyle(.secondary)
                                    Spacer()
                                }
                            }
                            .padding([.top, .bottom], 16)
                        }
                    } else {
                        Text("No reviews yet")
                    }
                }
            }
            .padding([.leading, .trailing], 36)
            
            .toolbar{
                ToolbarItem(placement: .principal, content: {
                    Text(product.title ?? "Unnamed Product")
                        .fontWeight(.bold)
                })
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//subview for stars rating -- used online sources
struct StarRatingView: View {
    let rating: Double
    let maxRating: Int = 5
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<maxRating) { index in
                starType(for: index)
                    .foregroundStyle(Color.starYellow)
                    .frame(width: 15, height: 15)
            }
        }
    }
    
    private func starType(for index: Int) -> Image {
        if Double(index) < rating {
            if Double(index) + 1.0 > rating {
                return Image(systemName: "star.leadinghalf.filled")
            } else {
                return Image(systemName: "star.fill")
            }
        } else {
            return Image(systemName: "star")
        }
    }
}


extension Color {
    static var starYellow: Color {
        Color(.sRGB, red: 255 / 255, green: 159 / 255, blue: 10 / 255)
    }
}

//#Preview {
//    ProductView(product: Product(id: 1, title: "Couch", description: "This is a couch! It is super nice, you should buy it.", category: "furniture", price: 19.99, discountPercentage: 7.0, rating: 4.9, stock: 23, tags: ["Couch"], brand: "Anthropologie", sku: nil, weight: 4, dimensions: Dimensions(width: 4, height: 4, depth: 10), warrantyInformation: nil, shippingInformation: nil, availabilityStatus: nil, reviews: [Review(rating: 4.7, comment: "Loved it", date: "2024-05-23T08:56:21.618Z", reviewerName: "Katherine", reviewerEmail: "me@gmail.com"), Review(rating: 4.9, comment: "Love", date: "2024-05-23T08:56:21.618Z", reviewerName: "Matt", reviewerEmail: "mattge@gmail.com"), Review(rating: 3.5, comment: "hate the texture", date: "2024-05-23T08:56:21.618Z", reviewerName: "Karen Mom", reviewerEmail: "karen@gmail.com")], returnPolicy: nil, minimumOrderQuantity: 2, metadata: nil, thumbnail: nil, images: nil))
//}

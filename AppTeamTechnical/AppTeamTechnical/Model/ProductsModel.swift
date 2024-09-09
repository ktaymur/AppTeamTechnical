//
//  ProductsModel.swift
//  AppTeamTechnical
//
//  Created by Kate Murray on 9/7/24.
//

struct Product: Identifiable, Codable, Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
    var id: Int
    var title: String?
    var description: String?
    var category: String?
    var price: Double?
    var discountPercentage: Double?
    var rating: Double?
    var stock: Int?
    var tags: [String]?
    var brand: String?
    var sku: String?
    var weight: Int?
    var dimensions: Dimensions?
    var warrantyInformation: String?
    var shippingInformation: String?
    var availabilityStatus: String?
    var reviews: [Review]?
    var returnPolicy: String?
    var minimumOrderQuantity: Int?
    var metadata: Metadata?
    var thumbnail: String?
    var images: [String]?
    //var liked: Bool = false
}

struct Dimensions: Codable {
    var width: Double?
    var height: Double?
    var depth: Double?
}

struct Review: Identifiable, Codable {
    var id: String {reviewerName ?? ""}
    var rating: Double?
    var comment: String?
    var date: String?
    var reviewerName: String?
    var reviewerEmail: String?
}

struct Metadata: Codable {
    var createdAt: String?
    var updatedAt: String?
    var barcode: String?
    var qrCode: String?
}

struct Products: Codable {
    var products: [Product]
}

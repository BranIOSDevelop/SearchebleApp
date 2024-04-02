//
//  SearchModel.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 01/04/24.
//

import Foundation

enum SearchModel{
    
    
    struct ResponseArticle: Codable{
        
        var pageType: String?
        
        var plpResults: PlpResults?
    }
    
    struct PlpResults: Codable{
        
        var records: [Records]?
    }
    
    struct Records: Codable{
        
        var productId: String?
        var skuRepositoryId: String?
        var productDisplayName: String?
        var productType: String?
        var productRatingCount: Double?
        var productAvgRating: Double?
        var promotionalGiftMessage: String?
        var listPrice: Double?
        var minimumListPrice: Double?
        var maximumListPrice: Double?
        var promoPrice: Double?
        var minimumPromoPrice: Double?
        var maximumPromoPrice: Double?
        var isHybrid: Bool?
        var isMarketPlace: Bool?
        var isImportationProduct: Bool?
        var brand: String?
        var ar: Bool?
        var seller: String?
        var category: String?
        var smImage: String?
        var lgImage: String?
        var xlImage: String?
        var variantsColor: [VariantsColor]?
    }
    
    struct VariantsColor: Codable{
        var colorName: String?
        var colorHex: String?
        var colorImageURL: String?
        var colorMainURL: String?
    }
    
    
}

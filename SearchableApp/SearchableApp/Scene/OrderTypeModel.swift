//
//  OrderTypeModel.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 02/04/24.
//

import Foundation

enum OrderTypeModel{
    
    struct Response: Codable {
        
        var id: String?
        var sortBy: String?
        var label: String?
        var isSelected: String?
    }
    
}

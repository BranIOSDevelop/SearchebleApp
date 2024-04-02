//
//  File.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 01/04/24.
//

import Foundation

struct StoryboardConstants{
    
    enum NameStoryboard: String{
        
        case Main = "Main"
    }
    
    enum BundleIdentifier: String {
        
        case BundleApp = "com.applications.SearchableApp"
    }
    
    enum ViewControllerID: String{
        
        case InicialView = "InicialViewController"
        case SearchView = "SearchViewController"
        case OrderTypeView =  "OrderTypeViewController"
    }
    
    enum CollectionViewCellID: String{
        case ArticleViewCell = "ArticleCollectionViewCell"
    }
    
    enum TableViewCellID: String{
        
        case OrderTypeViewCell = "OrderTypeTableViewCell"
    }
}

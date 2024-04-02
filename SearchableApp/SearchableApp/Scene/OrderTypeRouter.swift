//
//  OrderTypeRouter.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 02/04/24.
//

import Foundation

//MARK: Protocol
@objc protocol OrderTypeRoutingLogic {
    
    
    
}

protocol OrderTypeDataPassing {
    var dataStore: OrderTypeDataStore? { get set}
}

class OrderTypeRouter: NSObject,
                       OrderTypeDataPassing,
                       OrderTypeRoutingLogic {
    
    //MARK: Architecture var
    weak var viewController: OrderTypeViewController?
    var dataStore: OrderTypeDataStore?
    
    
    //MARK: Fuctions
    
    //MARK: Navigation
    
    //MARK: PassingData
}

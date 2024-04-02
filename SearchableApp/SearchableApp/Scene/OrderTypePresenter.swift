//
//  OrderTypePresenter.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 02/04/24.
//

import Foundation

protocol OrderTypePresentationLogic{
    
    func presenterDataPlist(response : [OrderTypeModel.Response])
    
}

class OrderTypePresenter: OrderTypePresentationLogic{
    
    var viewController: OrderTypeDisplayLogic?
    
    func presenterDataPlist(response: [OrderTypeModel.Response]) {
        
        self.viewController?.displayDataPlist(arrData: response)
    }
    
    
}

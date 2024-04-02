//
//  OrderTypeInteractor.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 02/04/24.
//

import Foundation

protocol OrderTypeBussinesLogic{
    
    func obtainDataPlist()
}

protocol OrderTypeDataStore{
    
}

class OrderTypeInteractor: OrderTypeBussinesLogic,
                           OrderTypeDataStore{
    
    var worker = OrderTypeWorker()
    var presenter: OrderTypePresentationLogic?
    
    func obtainDataPlist() {
        
        
        guard let arrData = self.worker.getInfoPlist() else{ return }
        
        
        self.presenter?.presenterDataPlist(response: arrData)
        
    }
}

//
//  SearchRouter.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 01/04/24.
//

import Foundation
import UIKit

//MARK: Protocol
@objc protocol SearchRoutingLogic {
    
    func routerToOrderType()
}

protocol SearchDataPassing {
    var dataStore: SearchDataStore? { get set}
}

class SearchRouter: NSObject,
                     SearchDataPassing,
                     SearchRoutingLogic {
    
    //MARK: Architecture var
    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore?
    
    
    //MARK: Fuctions
    func routerToOrderType() {
        
        let storyboard = UIStoryboard(name: StoryboardConstants.NameStoryboard.Main.rawValue,
                                      bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllerID.OrderTypeView.rawValue) as? OrderTypeViewController else {
            return
        }
        
        guard let vc = self.viewController else { return }
        
        destinationVC.modalTransitionStyle = .crossDissolve
        destinationVC.modalPresentationStyle = .overFullScreen
        
        destinationVC.oderTypeViewDelegate = self
        self.navigateToPresent(source: vc,
                               destination: destinationVC)
    }
    
    //MARK Navigations
    
    func navigateToPresent(source: UIViewController,
                           destination: UIViewController){
        
        source.present(destination,
                       animated: true)
    }
}

//MARK: Delegates
extension SearchRouter: OrderTypeViewDelegate{
    
    func selectedOrder(order: String) {
        
        self.viewController?.orderType = order
        self.viewController?.page = 1
        self.viewController?.sendService()
    }
  
}

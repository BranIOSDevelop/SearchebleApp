//
//  InicialRouter.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 01/04/24.
//

import Foundation
import UIKit

//MARK: Protocol
@objc protocol InicialRoutingLogic {
    
    func routerToSearchView()
    
}

protocol InicialDataPassing {
    var dataStore: InicialDataStore? { get set}
}

class InicialRouter: NSObject,
                     InicialDataPassing,
                     InicialRoutingLogic {
    
    //MARK: Architecture var
    weak var viewController: InicialViewController?
    var dataStore: InicialDataStore?
    
    
    //MARK: Fuctions
    
    func routerToSearchView() {
        //Use blundle nil because only storyboard
        let storyboard = UIStoryboard(name: StoryboardConstants.NameStoryboard.Main.rawValue,
                                      bundle: nil)
        
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: StoryboardConstants.ViewControllerID.SearchView.rawValue) as? SearchViewController else {
            return
        }
        
        guard let vc = self.viewController else { return }
        self.pushToNavigate(source: vc,
                            destination: destinationVC)
        
    }
    
    //MARK: Navigations
    
    func pushToNavigate(source: UIViewController, 
                        destination: UIViewController ){
        
        
        source.navigationController?.pushViewController(destination,
                                                        animated: true)
    
    }
    
    //MARK: Passing Data
    
}

//
//  SearchPresenter.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 01/04/24.
//

import Foundation

protocol SearchPresentationLogic{
    
    func presenterDataArticle(data: SearchModel.ResponseArticle? )
    func presenterError(error: Error?)
    
}

class SearchPresenter: SearchPresentationLogic{
    
    var viewController: SearchDisplayLogic?
    
    func presenterDataArticle(data: SearchModel.ResponseArticle?) {
        
        guard let dataResponse = data,
        let dataArticle = dataResponse.plpResults?.records else { return }
        
        guard dataArticle.count != 0 else {
            
            return
        }
        
        self.viewController?.displayDataArticle(arrDataArticle: dataArticle)
        
    }
    
    func presenterError(error: Error?) {
        
        
    }
    
    
}

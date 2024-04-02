//
//  SearchInteractor.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 01/04/24.
//

import Foundation

protocol SearchBussinesLogic{
    
    func getDataSearch(searchText: String?,
                       page: Int,
                       orderSearch: String?)
}

protocol SearchDataStore{
    
}

class SearchInteractor: SearchBussinesLogic,
                        SearchDataStore{
    
    var worker = SearchWorker()
    var presenter: SearchPresentationLogic?
    
    func getDataSearch(searchText: String?,
                       page: Int,
                       orderSearch: String?) {
        
        self.worker.getService(searchText: searchText,
                               page: page,
                               orderSearch: orderSearch) { result in
            
            self.presenter?.presenterDataArticle(data: result)
            
        } onFailure: { error in
            
            self.presenter?.presenterError(error: error)
        }
        
    }
}


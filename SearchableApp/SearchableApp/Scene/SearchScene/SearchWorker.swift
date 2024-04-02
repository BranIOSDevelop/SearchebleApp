//
//  SearchWorker.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 01/04/24.
//

import Foundation

class SearchWorker: NSObject{
    
    
    func getService(searchText: String?, 
                    page: Int,
                    orderSearch: String?, 
                    onSuccess success:@escaping((_ result: SearchModel.ResponseArticle?)-> Void),
                    onFailure failure:@escaping((_ error:Error?)->Void)){
        
        var urlString =  ""
        
        if let order = orderSearch {
            
            urlString = "https://shoppapp.liverpool.com.mx/appclienteservices/services/v7/plp/sf?page-number=\(page)&search-string=\(searchText ?? "")&sort-option=\(order)&force-plp=true&number-of-items-per-page=40&cleanProductName=false"
            
        }else {
            
            urlString = "https://shoppapp.liverpool.com.mx/appclienteservices/services/v7/plp/sf?page-number=\(page)&search-string=\(searchText ?? "")&force-plp=false&number-of-items-per-page=40&cleanProductName=false"
        }
        
        print(urlString)
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    
                    failure(error)
                    return
                }
                
                if let safeData = data {
                    
                    if let result = self.parseJSON(data: safeData) {
                        
                        success(result)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> SearchModel.ResponseArticle? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SearchModel.ResponseArticle.self,
                                                 from: data)
            print(decodedData)
            return decodedData
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}

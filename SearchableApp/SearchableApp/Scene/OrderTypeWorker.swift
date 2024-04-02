//
//  OrderTypeWorker.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 02/04/24.
//

import Foundation

class OrderTypeWorker{
    
    func getInfoPlist()  -> [OrderTypeModel.Response]?{
        
        let settingsURL__s = URL(fileURLWithPath:
                                    Utilities.getUrlInfoPlist (strInfoPlist:
                                                                SettingsConstants.namePlist.orderPlist.rawValue))
        
        do{
            let data__s = try Data(contentsOf: settingsURL__s)
            let decoder__s = PropertyListDecoder()
            
            typealias Settings = [OrderTypeModel.Response]
            let arrOrderType = try decoder__s.decode(Settings.self, from: data__s)
            
           return arrOrderType
            
        }catch{
            
            print(error)
            return nil
        }
    
    }
}

//
//  Utilities.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 02/04/24.
//

import Foundation

class Utilities{
    
    static func formatAmountAux(number: NSNumber,
                                digits:Int) -> String{
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = digits
        formatter.minimumFractionDigits = digits
        formatter.currencySymbol = ""
        formatter.currencyGroupingSeparator = ","
        return formatter.string(from: number)!
    }
    
    static func getUrlInfoPlist(strInfoPlist: String) -> String {
        let frameworkBundle = Bundle(identifier: StoryboardConstants.BundleIdentifier.BundleApp.rawValue)
        let framework = frameworkBundle?.path(forResource: strInfoPlist, ofType: "plist")
        
        let strUrl = framework
        return strUrl ?? ""
    }
}

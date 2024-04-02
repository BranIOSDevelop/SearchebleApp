//
//  InicialInteractor.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 01/04/24.
//

import Foundation

protocol InicialBussinesLogic{
    
}

protocol InicialDataStore{
    
}

class InicialInteractor: InicialBussinesLogic,
                         InicialDataStore{
    
    var worker = InicialWorker()
    var presenter: InicialPresentationLogic?
}

//
//  ViewController.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 01/04/24.
//

import UIKit

protocol InicialDisplayLogic :AnyObject{
    
}


class InicialViewController: UIViewController {
    
    //MARK: Oulets
    @IBOutlet weak var btnInto: UIButton!
    
    //MARK: Architecture vars
    var interactor: InicialBussinesLogic?
    var router: (NSObjectProtocol & InicialRoutingLogic & InicialDataPassing)?
    
    
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = InicialInteractor()
        let presenter = InicialPresenter()
        let router = InicialRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inicialViewConfig()
    }
    
    //MARK: Fuctions
    func inicialViewConfig(){
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.btnInto.layer.borderWidth = 1
        self.btnInto.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.btnInto.layer.cornerRadius = 10
        
        self.btnInto.addTarget(self,
                               action: #selector(goToNexView(sender:)),
                               for: .touchUpInside)
    }
    
    //MARK: Actions
    
    @objc func goToNexView(sender: UIButton){
        
        self.router?.routerToSearchView()
    }
}

//MARK: DisplayLogic

extension InicialViewController: InicialDisplayLogic{
    
}


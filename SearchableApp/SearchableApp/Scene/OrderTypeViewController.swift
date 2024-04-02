//
//  OrderTypeViewController.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 02/04/24.
//

import UIKit

protocol OrderTypeDisplayLogic :AnyObject{
    
    func displayDataPlist (arrData: [OrderTypeModel.Response])
    
}

protocol OrderTypeViewDelegate{
    
    func selectedOrder(order: String)
    
}

class OrderTypeViewController: UIViewController {
    
    //MARK: Oulets
    @IBOutlet weak var tbVOrder: UITableView!
    
    //MARK: Architecture vars
    var interactor: OrderTypeBussinesLogic?
    var router: (NSObjectProtocol & 
                 OrderTypeRoutingLogic &
                 OrderTypeDataPassing)?
    
    //MARK: Variables
    var arrData = [OrderTypeModel.Response]()
    var oderTypeViewDelegate: OrderTypeViewDelegate?
    
    
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
        let interactor = OrderTypeInteractor()
        let presenter = OrderTypePresenter()
        let router = OrderTypeRouter()
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

        self.orderTypeViewConfig()
    }
    
    //MARK: Fuctions
    func orderTypeViewConfig(){
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.tbVOrder.delegate = self
        self.tbVOrder.dataSource = self
        
        self.sendService()
    }
    
    func sendService(){
        
        self.interactor?.obtainDataPlist()
        
    }

}

//MARK: DisplayLogic
extension OrderTypeViewController: OrderTypeDisplayLogic{
    func displayDataPlist(arrData: [OrderTypeModel.Response]) {
        
        self.arrData = arrData
        self.tbVOrder.reloadData()
    }
}

//MARK: UiTableView Delegate & DataSource

extension OrderTypeViewController: UITableViewDelegate, 
                                    UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, 
                   numberOfRowsInSection section: Int) -> Int {
        return self.arrData.count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, 
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellData = tableView.dequeueReusableCell(withIdentifier: StoryboardConstants.TableViewCellID.OrderTypeViewCell.rawValue,
                                                     for: indexPath) as! OrderTypeTableViewCell
        cellData.settings = self.arrData[indexPath.row]
        
        return cellData
        
    }
    
    func tableView(_ tableView: UITableView, 
                   didSelectRowAt indexPath: IndexPath) {
        
        guard let delegate = self.oderTypeViewDelegate else { return }
        
        self.arrData[indexPath.row].isSelected = "true"
        tableView.reloadData()
        
        self.dismiss(animated: true){
            
            guard let order = self.arrData[indexPath.row].sortBy else { return }
            delegate.selectedOrder(order: order  )
        }
        
    }
    
    
}

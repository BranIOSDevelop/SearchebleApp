//
//  SearchViewController.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 01/04/24.
//

import UIKit

protocol SearchDisplayLogic :AnyObject{
    
    func displayDataArticle(arrDataArticle: [SearchModel.Records])
    
}


class SearchViewController: UIViewController {
    
    //MARK: Oulets
    
    @IBOutlet weak var scrSearchItem: UISearchBar!
    @IBOutlet weak var cvArticle: UICollectionView!
    
    //MARK: Variables
    var arrDataArticle = [SearchModel.Records]()
    var page = 1
    var orderType: String?
    
    //MARK: Architecture vars
    var interactor: SearchBussinesLogic?
    var router: (NSObjectProtocol &
                 SearchRoutingLogic &
                 SearchDataPassing)?
    
    
    
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
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
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
        
        self.inicialSearchViewConfig()
    }
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
        self.sendService()
    }
    
    //MARK: Functions
    func inicialSearchViewConfig(){
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.scrSearchItem.layer.borderWidth = 1
        self.scrSearchItem.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.scrSearchItem.delegate = self
        
        self.cvArticle.delegate = self
        self.cvArticle.dataSource = self
        
        let orderBarButtonItem = UIBarButtonItem(title: "Ordenar",
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(self.goToTypeOrder))
        orderBarButtonItem.tintColor = #colorLiteral(red: 0.8078431373, green: 0.1725490196, blue: 0.5843137255, alpha: 1)
        self.navigationItem.rightBarButtonItem  = orderBarButtonItem
    }
    
    
    //MARK: Actions
    
    @objc func goToTypeOrder(){
        
        self.router?.routerToOrderType()
    }
    
    func sendService (){
        
        self.interactor?.getDataSearch(searchText: self.scrSearchItem.text?.trimmingCharacters(in: .whitespaces),
                                       page: self.page,
                                       orderSearch: self.orderType)
    }
    
}

//MARK: DisplayLogic
extension SearchViewController: SearchDisplayLogic{
    
    func displayDataArticle(arrDataArticle: [SearchModel.Records]) {
        
        self.arrDataArticle = arrDataArticle
        
        DispatchQueue.main.async {
            self.cvArticle.reloadData()
        }
    }
    
}

//MARK: Delegate SearchBarDelegate
extension SearchViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar,
                   shouldChangeTextIn range: NSRange,
                   replacementText text: String) -> Bool {
        
        let alphaNumericRegEx = "^[A-Z0-9 \r\n]*$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", alphaNumericRegEx)
        return predicate.evaluate(with: text)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        
        guard text.count != 0 else { return }
        
        self.page = 1
        self.sendService()
    }
    
}

//MARK: Delegate & Datasource CollectionView
extension SearchViewController: UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return self.arrDataArticle.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellArticle = collectionView.dequeueReusableCell(withReuseIdentifier: StoryboardConstants.CollectionViewCellID.ArticleViewCell.rawValue,
                                                             for: indexPath) as! ArticleCollectionViewCell
        cellArticle.layer.cornerRadius = 10
        cellArticle.settingsData = self.arrDataArticle[indexPath.row]
        
        return cellArticle
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let size = collectionView.frame
        let tralling = (size.width - 300)/2
        return UIEdgeInsets(top: size.height * 0.049, left: tralling, bottom: size.height * 0.049, right:tralling )
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = collectionView.frame
        return CGSize(width: 300, height: size.height * 0.902)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView is UICollectionView else{
            return
        }
        let center = CGPoint(x: view.center.x - 54, y: view.center.y)
        let centerPint = view.convert(center, to: self.cvArticle)
        if let indexPath = self.cvArticle.indexPathForItem(at: centerPint){
            //Cell
            self.cvArticle.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            if indexPath.row == (self.arrDataArticle.count) - 1 {
                self.page += 1
                self.sendService()
                return
                
            }else if indexPath.row == 0 && self.page != 1{
                
                self.page -= 1
                self.sendService()
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            guard scrollView is UICollectionView else{
                return
            }
            let center = CGPoint(x: view.center.x - 54, y: view.center.y)
            let centerPint = view.convert(center, to: self.cvArticle)
            if let indexPath = self.cvArticle.indexPathForItem(at: centerPint){
                //Cell
                self.cvArticle.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
    }
    
    
}

//
//  ArticleCollectionViewCell.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 01/04/24.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imgVArticle: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblOldPrice: UILabel!
    @IBOutlet weak var lblPromoPrice: UILabel!
    
    @IBOutlet weak var stkVColors: UIStackView!
    
    
    var settingsData: SearchModel.Records? {
        didSet{
            
            guard let data = settingsData else { return }
            
            self.setImage(urlAPI: data.xlImage ?? "")
            self.lblDescription.text = data.productDisplayName
            
            self.lblOldPrice.isHidden = data.listPrice == data.promoPrice
            self.lblOldPrice.text =  Utilities.formatAmountAux(number: NSNumber(value: data.listPrice ?? 0),
                                                               digits: 2)
            self.lblPromoPrice.text = Utilities.formatAmountAux(number: NSNumber(value:data.promoPrice ?? 0 ),
                                                                digits: 2)
            
            
        }
    }
    
    
    
    func setImage(urlAPI: String){
        
        if let url = URL(string: urlAPI) {
            let task = URLSession.shared.dataTask(with: url,
                                                  completionHandler: { data, response, error in
                if let data = data {
                    
                    DispatchQueue.main.async {
                        
                        self.imgVArticle.image = UIImage(data: data)
                    }
                }
            })
            task.resume()
        }
    }
    
    
}

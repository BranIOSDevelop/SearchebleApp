//
//  OrderTypeTableViewCell.swift
//  SearchableApp
//
//  Created by Brandon Acosta Garcia on 02/04/24.
//

import UIKit

class OrderTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblOption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.btnCheck.isUserInteractionEnabled = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var settings: OrderTypeModel.Response? {
        
        didSet{
            
            guard let data = self.settings else { return }
            
            self.lblOption.text = data.label
            self.btnCheck.isSelected = data.isSelected == "true"
        }
    }

}

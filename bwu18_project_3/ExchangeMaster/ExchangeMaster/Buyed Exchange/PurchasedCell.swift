//
//  PurchasedCell.swift
//  ExchangeMaster
//
//  Created by bo wu on 12/3/20.
//  Copyright © 2020 bwu18. All rights reserved.
//

import UIKit

class PurchasedCell: UITableViewCell {

    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initial_background()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    func initial_background(){
      if UserDefaults.standard.bool(forKey: dLighyDarkMode){
          self.backgroundColor = UIColor.lightGray
      }else{
          self.backgroundColor = UIColor.darkGray
      }
    }
    
    func update(code: String, amount: String){
         initial_background()
        codeLabel.text = code
        amountLabel.text = amount
    }
}

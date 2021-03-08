//
//  infoVC.swift
//  ExchangeMaster
//
//  Created by bo wu on 12/5/20.
//  Copyright © 2020 bwu18. All rights reserved.
//

import UIKit

class infoVC: UIViewController {

    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initial_background()
        
        appNameLabel.text = NSLocalizedString("str_app_title", comment: "")
        versionLabel.text = Bundle.main.version
        buildLabel.text = Bundle.main.build
        copyrightLabel.text = NSLocalizedString("str_copyright", comment: "")
    }
    
    func initial_background(){
        if UserDefaults.standard.bool(forKey: dLighyDarkMode){
            self.view.backgroundColor = UIColor.lightGray
        }else{
            self.view.backgroundColor = UIColor.darkGray
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

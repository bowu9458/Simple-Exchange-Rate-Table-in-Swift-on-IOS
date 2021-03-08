//
//  SettingVC.swift
//  ExchangeMaster
//
//  Created by bo wu on 12/4/20.
//  Copyright © 2020 bwu18. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var lightGrayModeSwitch: UISwitch!
    @IBOutlet weak var purchaseDateSwitch: UISwitch!
    @IBOutlet weak var tipSwitch: UISwitch!
    
    
    @IBOutlet weak var modeStackView: UIStackView!
    @IBOutlet weak var modeStackX: NSLayoutConstraint!
    
    @IBOutlet weak var settingLabel: UILabel!
    
    @IBOutlet weak var tipStackX: NSLayoutConstraint!
    
    @IBOutlet weak var lightgraymodeLabel: UILabel!
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        settingLabel.text = NSLocalizedString("str_setting", comment: "")
        
        lightgraymodeLabel.text = NSLocalizedString("str_light_gray_mode", comment: "")
        purchaseDateLabel.text = NSLocalizedString("str_purchase_date", comment: "")
        tipLabel.text = NSLocalizedString("str_tip", comment: "")
        
         
        self.title = NSLocalizedString("str_setting", comment: "")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        settingLabel.text = NSLocalizedString("str_setting", comment: "")
        
        initial_background()
        
        lightGrayModeSwitch.isOn = defaults.bool(forKey: dLighyDarkMode)
        purchaseDateSwitch.isOn = defaults.bool(forKey: dShowPurchaseDate)
        tipSwitch.isOn = defaults.bool(forKey: dShowTip)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
            UIView.transition(
                with: self.settingLabel,
                duration: 0.8,
                options: [.transitionFlipFromRight],
                animations: {
                    self.settingLabel.text = NSLocalizedString("str_setting", comment: "")
            })
        })
        
        animations()
    }
    
    @IBAction func onVerticalSwipe(_ sender: UISwipeGestureRecognizer) {
        print("performed")
        switch sender.direction {
            case .up:
                print("performed")
                performSegue(withIdentifier: "showInfoSegue", sender: self)
            case .right:
                performSegue(withIdentifier: "showHistroy", sender: self)
            default: break
        }
    }
    
    func initial_background(){
        if UserDefaults.standard.bool(forKey: dLighyDarkMode){
            self.view.backgroundColor = UIColor.lightGray
        }else{
            self.view.backgroundColor = UIColor.darkGray
        }
    }
    
    func animations(){
        modeStackX.constant = -150
        
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        }, completion: {_ in
            self.modeStackX.constant = -22.5
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
        })
        
        tipStackX.constant = 100
        
        UIView.animate(withDuration: 0.7, animations: {
            self.view.layoutIfNeeded()
        }, completion: {_ in
            self.tipStackX.constant = -22.5
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
        })
    }
    

    @IBAction func onModeSwitch(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: dLighyDarkMode)
        
        if (sender.isOn){
            Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false, block: { _ in
                UIView.transition(
                    with: self.view,
                    duration: 1,
                    options: [.transitionCurlUp],
                    animations: {
                        self.view.backgroundColor = UIColor.lightGray
                })
            })
        }else{
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in
                UIView.transition(
                    with: self.view,
                    duration: 1,
                    options: [.transitionCurlDown],
                    animations: {
                        self.view.backgroundColor = UIColor.darkGray
                })
            })
        }
    }
    
    
    @IBAction func onPurchaseDate(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: dShowPurchaseDate)
    }
    
    
    @IBAction func onTipSwitch(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: dShowTip)
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

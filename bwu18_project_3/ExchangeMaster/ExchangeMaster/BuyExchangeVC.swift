//
//  BuyExchangeVC.swift
//  ExchangeMaster
//
//  Created by bo wu on 12/3/20.
//  Copyright © 2020 bwu18. All rights	
//

import UIKit

class BuyExchangeVC: UIViewController {

    var array_keys_sorted: [Dictionary<String, Double>.Keys.Element]?
    var exchangeInfo: ExchangeInfo?
    var purchaseExchange: PurchasedExchange?
    
    @IBOutlet weak var codePicker: UIPickerView!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var Purchase: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Purchase.text = NSLocalizedString("str_buy", comment: "")
        exchangeLabel.text = NSLocalizedString("str_code", comment: "")
        amountLabel.text = NSLocalizedString("str_amount", comment: "")
        
        submitButton.setTitle(NSLocalizedString("str_submit", comment: ""), for: UIControl.State.normal)
        cancelButton.setTitle(NSLocalizedString("str_cancel", comment: ""), for: UIControl.State.normal)
        
        //purchaseExchange = SceneDelegat
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        purchaseExchange = FileManager.default.getExchangeRates()
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction func cancelPurchase(_ sender: Any) {
        cancelAlert(title: NSLocalizedString("str_warning", comment: "") )
    }
    
    func cancelAlert(title: String){
        let alertMsg = NSLocalizedString("str_cancelMsg", comment: "")
        
        let alert = UIAlertController(title: title, message: alertMsg, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: NSLocalizedString("str_yes", comment: ""), style: .destructive, handler: {_ in self.presentingViewController?.dismiss(animated: true)})
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_no", comment: ""), style: .cancel, handler:nil)
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func submitPurchase(_ sender: Any) {
        let code = String(array_keys_sorted?[codePicker.selectedRow(inComponent: 0)] ?? "error")
        
        if let amount = Double(amountField.text!){
            print(amount)
            
            let now = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yy HH:mm:ss"
            let dateString = dateFormatter.string(from: now)
            
            purchaseExchange?.add(code: code, amount: String(amount), time: dateString)
            
            FileManager.default.saveExchangeRates(purchasedExchange: purchaseExchange!)
            
            presentingViewController?.dismiss(animated: true)
            
            NotificationCenter.default.post(name: Notifications.purchased, object: nil, userInfo: nil)
            
        }else{
            badInputAlert(title: NSLocalizedString("str_warning", comment: ""))
            print("Bad Amount field: \(amountField.text!)")
        }
    }
    
    func badInputAlert(title: String){
        let alertMsg = NSLocalizedString("str_badInput", comment: "")
        
        let alert = UIAlertController(title: title, message: alertMsg, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_yes", comment: ""), style: .cancel, handler:nil)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
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


extension BuyExchangeVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array_keys_sorted?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array_keys_sorted?[row]
    }
}

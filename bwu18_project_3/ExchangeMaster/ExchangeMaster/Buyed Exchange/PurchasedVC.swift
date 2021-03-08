//
//  PurchasedVC.swift
//  ExchangeMaster
//
//  Created by bo wu on 12/3/20.
//  Copyright © 2020 bwu18. All rights reserved.
//

import UIKit

class PurchasedVC: UITableViewController {

    var purchaseExchange: PurchasedExchange?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("str_history", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("load")
        initial_background()
        purchaseExchange = FileManager.default.getExchangeRates()
        tableView.reloadData()
    }
    
    func initial_background(){
       if UserDefaults.standard.bool(forKey: dLighyDarkMode){
           self.view.backgroundColor = UIColor.lightGray
       }else{
           self.view.backgroundColor = UIColor.darkGray
       }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if UserDefaults.standard.bool(forKey: dShowPurchaseDate){
            return purchaseExchange?.items.count ?? 0
        }else{
            return 1
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if UserDefaults.standard.bool(forKey: dShowPurchaseDate){
            return 1
        }else{
            return purchaseExchange?.items.count ?? 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if UserDefaults.standard.bool(forKey: dShowPurchaseDate){
            return purchaseExchange?.items[section].date ?? "error"
        }else{
            return ""
        }
        //return String(10-section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PurchasedCell", for: indexPath) as? PurchasedCell else{
            fatalError("Expected MediaCell")
        }
        let code: String
        let amount: String
        if UserDefaults.standard.bool(forKey: dShowPurchaseDate){
            code = purchaseExchange?.items[indexPath.section].code ?? "xxx"
            amount = purchaseExchange?.items[indexPath.section].amount ?? "0"
        }else{
            code = purchaseExchange?.items[indexPath.row].code ?? "xxx"
            amount = purchaseExchange?.items[indexPath.row].amount ?? "0"
        }
        
        
        cell.update(code: code, amount: amount)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ExchangeViewController.swift
//  ExchangeMaster
//
//  Created by bo wu on 12/3/20.
//  Copyright © 2020 bwu18. All rights reserved.
//

import UIKit

class ExchangeViewController: UITableViewController {

    let exchangeHelper = ExchangeHelper()
    var exchangeInfo: ExchangeInfo?
    var dateString: String?
    
    var array_keys_sorted: [Dictionary<String, Double>.Keys.Element]?
    
    
    
    @IBOutlet weak var BuyButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BuyButton.title = NSLocalizedString("str_buy", comment: "")
        //self.title = NSLocalizedString("str_program_title", comment: "")
        self.title = NSLocalizedString("str_rate", comment: "")
        
        loadRequest()
        
        initial_background()
        
        showtip()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initial_background()
        tableView.reloadData()
    }
    
    func initial_background(){
        if UserDefaults.standard.bool(forKey: dLighyDarkMode){
            self.view.backgroundColor = UIColor.lightGray
        }else{
            self.view.backgroundColor = UIColor.darkGray
        }
    }
    
    func showtip(){
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { _ in
            if UserDefaults.standard.bool(forKey: dShowTip) {
                let alert = UIAlertController(title: "Tip",
                                              message: "This is an application that help you keep track of your exchange purchase.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
            }
        }
        
        NotificationCenter.default.addObserver(forName: Notifications.purchased, object: nil, queue: nil) { _ in
            if UserDefaults.standard.bool(forKey: dShowTip) {
                let alert = UIAlertController(title: "Tip",
                                              message: "Go to History view and check your purchase.",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
            }
        }
    }
    

    func loadRequest() {
        self.exchangeHelper.fetchRates() { result in
            switch result {
                case let .Success(exchange):
                    OperationQueue.main.addOperation() {
                        self.exchangeInfo = exchange
                        
                        
                        if let rates = self.exchangeInfo?.rates {
                            for (code,price) in rates{
                                print("Code \(code) is \(price)")
                            }
                            print("number of rows \(self.exchangeInfo?.rates?.count ?? 0)")
                        }
                        
                        let now = Date()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM-dd-yy HH:mm:ss"
                        self.dateString = dateFormatter.string(from: now)
                        
                        
                        let array_keys_unsorted = Array((self.exchangeInfo?.rates?.keys)! )
                        
                        self.array_keys_sorted = array_keys_unsorted.sorted()
                        
                        self.tableView.reloadData()
                    }
                case let .Failure(error):
                    self.exchangeInfo = ExchangeInfo()
                    self.array_keys_sorted = nil
                    print("Error: \(error)")
            }
        }
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (exchangeInfo?.rates?.count ?? 0)
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return dateString
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExchangeRateCell", for: indexPath) as? ExchangeViewCell else{
            fatalError("Expected MediaCell")}

        OperationQueue.main.addOperation() {
            let code = self.array_keys_sorted?[indexPath.row] ?? "error";
            let value = self.exchangeInfo?.rates?[self.array_keys_sorted?[indexPath.row] ?? "-1"];
                    
            cell.update(current_index: String(indexPath.row+1), current_code: code, current_value: String(value!))
        }
                
        return cell
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BuyViewSegue" {
            if let vc = segue.destination as? BuyExchangeVC {
                print("buy called")
                vc.array_keys_sorted = array_keys_sorted
                vc.exchangeInfo = exchangeInfo
            }
        }
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

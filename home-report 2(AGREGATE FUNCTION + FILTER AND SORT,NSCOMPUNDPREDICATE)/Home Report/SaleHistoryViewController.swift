//
//  SaleHistoryViewController.swift
//  Home Report
//
//  Created by Andi Setiyadi on 6/8/18.
//  Copyright © 2018 devhubs. All rights reserved.
//

import UIKit
import CoreData

class SaleHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Property
    private lazy var soldHistory = [SaleHistory]()
    var home: Home?
    weak var managedObjectContext: NSManagedObjectContext! {
        didSet {
            saleHistory = SaleHistory(context: managedObjectContext)
        }
    }
    
    private var saleHistory: SaleHistory?
    // MARK - Outlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .red, tintColor: .brown, title: "Home", preferredLargeTitle: false)
        loadSoldHistory()
        if let homeImage = home?.image as Data? {
            let image = UIImage(data: homeImage )
            imageView.image = image
            imageView.layer.borderWidth = 1.0
            imageView.layer.cornerRadius = 4.0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Tableview datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soldHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! SaleHistoryTableViewCell
        
        let saleHistory = soldHistory[indexPath.row]
        cell.configureCell(saleHistory: saleHistory)
        
        return cell
    }
    
    private func loadSoldHistory() {
        guard let home = home,let  saleHistory = saleHistory  else {return}
        soldHistory = saleHistory.soldHistory(for: home, moc: managedObjectContext)
        tableView.reloadData()
    }
}

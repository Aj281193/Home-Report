//
//  FilterTableViewController.swift
//  Home Report
//
//  Created by Andi Setiyadi on 6/8/18.
//  Copyright © 2018 devhubs. All rights reserved.
//

import UIKit

protocol FilterTableViewControllerDelegate: class {
    func updateHomeList(filterby: NSPredicate?, sortby: NSSortDescriptor?)
}

class FilterTableViewController: UITableViewController {

    // MARK: Outlets
    
    // SORT BY
    @IBOutlet weak var sortByLocationCell: UITableViewCell!
    @IBOutlet weak var sortByPriceLowHighCell: UITableViewCell!
    @IBOutlet weak var sortByPriceHighLowCell: UITableViewCell!
    
    // FILTER by home type
    @IBOutlet weak var filterByCondoCell: UITableViewCell!
    @IBOutlet weak var filterBySingleFamilyCell: UITableViewCell!
    
    
    // MARK: Properties
    private var sortDescriptor: NSSortDescriptor?
    private var searchPredicate: NSPredicate?
    weak var delegate: FilterTableViewControllerDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .red, tintColor: .brown, title: "Home", preferredLargeTitle: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCell = tableView.cellForRow(at: indexPath) {
            switch selectedCell {
            case sortByLocationCell:
                setSortDescriptor(sortBy: "city", isAscending: true)
            case sortByPriceLowHighCell:
                setSortDescriptor(sortBy: "price", isAscending: true)
            case sortByPriceHighLowCell:
                setSortDescriptor(sortBy: "price", isAscending: false)
            case filterByCondoCell,filterBySingleFamilyCell:
                setFilterSearchPredicate(filterBy: (selectedCell.textLabel?.text)!)
            default:
                break
            }
            selectedCell.accessoryType = .checkmark
            if let del = self.delegate {
               del.updateHomeList(filterby: searchPredicate, sortby: sortDescriptor)
            }
        }
    }
    
    private func setSortDescriptor(sortBy: String,isAscending: Bool) {
        sortDescriptor = NSSortDescriptor(key: sortBy, ascending: isAscending)
    }
    private func setFilterSearchPredicate(filterBy: String) {
        searchPredicate = NSPredicate(format: "homeType = '\(filterBy)'")
    }
}

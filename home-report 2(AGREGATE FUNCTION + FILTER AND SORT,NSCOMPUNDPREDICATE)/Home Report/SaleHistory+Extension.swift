//
//  SaleHistory+Extension.swift
//  Home Report
//
//  Created by Ashish Jaiswal on 20/07/22.
//  Copyright © 2022 devhubs. All rights reserved.
//

import Foundation
import CoreData

extension SaleHistory {
    func soldHistory(for home: Home, moc: NSManagedObjectContext) -> [SaleHistory] {
        let soldHistoryRequest: NSFetchRequest<SaleHistory> = SaleHistory.fetchRequest()
        soldHistoryRequest.predicate = NSPredicate(format: "home = %@", home)
        do {
            let soldHis = try moc.fetch(soldHistoryRequest)
            return soldHis
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}

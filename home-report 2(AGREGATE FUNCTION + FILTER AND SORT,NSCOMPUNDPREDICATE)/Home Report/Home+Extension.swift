//
//  Home+Extension.swift
//  Home Report
//
//  Created by Ashish Jaiswal on 20/07/22.
//  Copyright © 2022 devhubs. All rights reserved.
//

import Foundation
import CoreData

extension Home {
    func getHomeByStatus(sForSale: Bool, filterBy filter: NSPredicate?, sortBy sort: [NSSortDescriptor], moc: NSManagedObjectContext) -> [Home] {
        let request: NSFetchRequest<Home> = Home.fetchRequest()
        var predicates = [NSPredicate]()
        
        let statusPredicates = NSPredicate(format: "isForSale = %@", NSNumber(value: isForSale))
        predicates.append(statusPredicates)
        
        if let additionationPredicate = filter {
            predicates.append(additionationPredicate)
        }
        
        let predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
        request.predicate = predicate
        request.sortDescriptors = sort.isEmpty ? nil : sort
        do {
            let homes = try moc.fetch(request)
            return homes
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}

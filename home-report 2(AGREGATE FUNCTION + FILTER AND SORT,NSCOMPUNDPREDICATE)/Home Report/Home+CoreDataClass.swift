//
//  Home+CoreDataClass.swift
//  Home Report
//
//  Created by Andi Setiyadi on 6/8/18.
//  Copyright © 2018 devhubs. All rights reserved.
//
//

import Foundation
import CoreData


public class Home: NSManagedObject {
    
    private let isForSalePredicate = NSPredicate(format: "isForSale = false")
    private let request: NSFetchRequest<Home> = Home.fetchRequest()
    
    //Sum
    func totalSoldValue(moc: NSManagedObjectContext) -> Double {
        request.predicate = isForSalePredicate
        request.resultType = .dictionaryResultType
        
        let sumExpressionDescription = NSExpressionDescription()
        sumExpressionDescription.name = "totalSales"
        sumExpressionDescription.expression = NSExpression(forFunction: "sum:", arguments: [NSExpression(forKeyPath: "price")])
        sumExpressionDescription.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [sumExpressionDescription]
        if let result = try? moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as? [NSDictionary],let totalSales = result?.first?["totalSales"] as? Double {
            
            return totalSales
        }
        return 0
    }
    
    func totalSoldCondo(moc: NSManagedObjectContext) -> Int {
        let typePredicate = NSPredicate(format: "homeType = '\(HomeType.Condo.rawValue)'")
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [isForSalePredicate,typePredicate])
        
        request.resultType = .countResultType
        request.predicate = predicate
        
        if let result = try? moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as? [Int], let count = result?.first {
            return count
        }
        return 0
    }
    
    func totalSoldSingleFamilyHome(moc: NSManagedObjectContext) -> Int {
        let typePredicate = NSPredicate(format: "homeType = '\(HomeType.SingleFamily.rawValue)'")
        let predicate = NSCompoundPredicate(type: .and, subpredicates:[isForSalePredicate,typePredicate])
        request.predicate = predicate
        
        if let count = try? moc.count(for: request), count != NSNotFound {
            return count
        }
        return 0
    }
    
    func soldPrice(priceType: String,moc:NSManagedObjectContext) -> Double {
        request.predicate = isForSalePredicate
        request.resultType = .dictionaryResultType
        let sumExpressionDescription = NSExpressionDescription()
        sumExpressionDescription.name = priceType
        sumExpressionDescription.expression = NSExpression(forFunction: "\(priceType):", arguments: [NSExpression(forKeyPath: "price")]) // min max
        sumExpressionDescription.expressionResultType = .doubleAttributeType
        request.propertiesToFetch = [sumExpressionDescription]
        
        if let results = try? moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as? [NSDictionary],let homePrice = results?.first?[priceType] as? Double {
            return homePrice
        }
       return 0
    }
    
    func avergaePrice(for homeType: HomeType,moc: NSManagedObjectContext) -> Double {
        let typePredicate = NSPredicate(format: "homeType = %@",homeType.rawValue)
        let predicate = NSCompoundPredicate(type: .and, subpredicates: [isForSalePredicate,typePredicate])
        request.predicate = predicate
        let sumExpressionDescription = NSExpressionDescription()
        sumExpressionDescription.name = homeType.rawValue
        sumExpressionDescription.expression = NSExpression(forFunction: "average:", arguments: [NSExpression(forKeyPath: "price")]) // min max
        sumExpressionDescription.expressionResultType = .doubleAttributeType
        request.propertiesToFetch = [sumExpressionDescription]
        
        if let results = try? moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as? [NSDictionary],let homePrice = results?.first?[homeType.rawValue] as? Double {
            return homePrice
        }
       return 0
    }
}

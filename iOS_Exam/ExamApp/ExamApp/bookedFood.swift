//
//  bookedFood.swift
//  ExamApp
//
//  Created by OparinOleg on 02.06.2020.
//  Copyright © 2020 OparinOleg. All rights reserved.
//

import CoreData
import Foundation
import UIKit

class bookedFoodCore: NSManagedObject{
    static func get() -> NSFetchRequest<NSManagedObject>{
        let request = NSFetchRequest<NSManagedObject>(entityName: "BookedFood")
        return request
    }
    
    static func save(_ foodName: String, _ cost: String, _ description: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "BookedFood", in: managedContext)
        let user = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        user.setValue(foodName, forKey: "foodName")
        user.setValue(cost, forKey: "cost")
        user.setValue(description, forKey: "descrip")
        do{
            try managedContext.save()
        }catch let err as NSError{
            print("Failed to save Food", err)
        }
    }
}


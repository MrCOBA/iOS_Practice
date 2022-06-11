//
//  ViewController.swift
//  Commits App
//
//  Created by Oparin Oleg on 26.11.2020.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        container = NSPersistentContainer(name: "Commits_App")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        
        let commit = Commit()
        commit.message = "Woo"
        commit.url = "http://www.example.com"
    }
    
    func saveContext() {
        
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
            
        }
    }

}


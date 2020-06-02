//
//  bookedFoodViewController.swift
//  ExamApp
//
//  Created by OparinOleg on 02.06.2020.
//  Copyright © 2020 OparinOleg. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class bookedFoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var bookedFood: [NSManagedObject] = []
    var dataSource: [foodElem] = []
    
    @IBOutlet weak var foodView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodView.separatorStyle = .none
        foodView.delegate = self
        foodView.dataSource = self
        loadInfo()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = self.dataSource[indexPath.row]
        let fCell = foodView.dequeueReusableCell(withIdentifier: "FoodCell") as! foodCell
        
        fCell.nameLabel.text = "Name of Food: \(food.name)"
        fCell.costLabel.text = "Cost: \(food.cost)"
        return fCell
    }
    
    func loadInfo(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = foodCore.get()
        do{
            bookedFood = try managedContext.fetch(fetchRequest)
        }catch let err as NSError{
            print("Failed to fetch user", err)
        }
        
        dataSource = []
        for elem in bookedFood{
            let foodName = elem.value(forKey: "foodName") as! String
            let cost = elem.value(forKey: "cost") as! String
            let description = elem.value(forKey: "descrip") as! String
            dataSource.append(foodElem(name: foodName, cost: cost, description: description))
        }
        self.foodView.reloadData()
    }
}

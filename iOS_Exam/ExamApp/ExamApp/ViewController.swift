//
//  ViewController.swift
//  ExamApp
//
//  Created by OparinOleg on 01.06.2020.
//  Copyright © 2020 OparinOleg. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var foodView: UITableView!
    
    var food: [NSManagedObject] = []
    var dataSource: [foodElem] = []
    var bookedFood: [foodElem] = []
    var selectedItem: foodElem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodView.separatorStyle = .none
        self.navigationItem.setHidesBackButton(true, animated: true);
        foodView.delegate = self
        foodView.dataSource = self
        loadInfo()
    }
    
    @IBAction func editBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "editFoodTable", sender: nil)
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
        
        let viewAction = UITableViewRowAction(style: .default, title: "View") {
            _, indexPath in
            self.selectedItem = self.dataSource[indexPath.row]
            self.performSegue(withIdentifier: "viewInfo", sender: nil)
        }
        
        viewAction.backgroundColor = .systemGray
        
        let bookAction = UITableViewRowAction(style: .default, title: "Book") {
            _, indexPath in
            self.bookFood(food: self.dataSource[indexPath.row])
        }
        
        bookAction.backgroundColor = .systemGreen
        
        return [viewAction, bookAction]
    }
    
    func bookFood(food: foodElem){
        bookedFoodCore.save(food.name, food.cost, food.description)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewInfo"{
            let destination = segue.destination as? foodInfoViewController
            destination!.name = self.selectedItem.name
            destination!.cost = self.selectedItem.cost
            destination!.descrip = self.selectedItem.description
        }
    }
    
    func loadInfo(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = foodCore.get()
        do{
            food = try managedContext.fetch(fetchRequest)
        }catch let err as NSError{
            print("Failed to fetch user", err)
        }
        dataSource = []
        for elem in food{
            let foodName = elem.value(forKey: "foodName") as! String
            let cost = elem.value(forKey: "cost") as! String
            let description = elem.value(forKey: "descrip") as! String
            dataSource.append(foodElem(name: foodName, cost: cost, description: description))
        }
        self.foodView.reloadData()
    }
}


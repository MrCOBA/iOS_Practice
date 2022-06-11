//
//  Commit+CoreDataProperties.swift
//  Commits App
//
//  Created by Oparin Oleg on 26.11.2020.
//
//

import Foundation
import CoreData


extension Commit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Commit> {
        return NSFetchRequest<Commit>(entityName: "Commit")
    }

    @NSManaged public var date: Date?
    @NSManaged public var message: String?
    @NSManaged public var sha: String?
    @NSManaged public var url: String?

}

extension Commit : Identifiable {

}

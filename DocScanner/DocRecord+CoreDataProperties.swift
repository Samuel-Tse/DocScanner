//
//  DocRecord+CoreDataProperties.swift
//  
//
//  Created by Samuel Tse on 28/4/19.
//
//

import Foundation
import CoreData


extension DocRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DocRecord> {
        return NSFetchRequest<DocRecord>(entityName: "DocRecord")
    }

    @NSManaged public var photo: NSData?
    @NSManaged public var name: String?
    @NSManaged public var created: String?

}

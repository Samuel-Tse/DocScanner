//
//  DocService.swift
//  DocScanner
//
//  Created by Samuel Tse on 27/4/19.
//  Copyright © 2019 Samuel Tse. All rights reserved.
//

import Foundation
import CoreData

typealias DocHandler = (Bool, [DocRecord]) -> ()

class DocService {
    
    private var managedObjectContext: NSManagedObjectContext
    private var docs = [DocRecord]()
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    // MARK: - Public
    
    // READ
    func getAllDocs() -> [DocRecord]? {
        let sortByDT = NSSortDescriptor(key: "created", ascending: false)
        let sortDescriptors = [sortByDT]
        
        let request: NSFetchRequest<DocRecord> = DocRecord.fetchRequest()
        request.sortDescriptors = sortDescriptors
        
        do {
            docs = try managedObjectContext.fetch(request)
            return docs
        }
        catch let error as NSError {
            print("Error fetching students: \(error.localizedDescription)")
        }
        
        return nil
    }
    
    
    // CREATE
    func addDoc(name: String, dt: String, image: Data, completion: DocHandler) {
        let doc = DocRecord(context: managedObjectContext)
        doc.name = name
        doc.created = dt
        doc.photo = image as NSData
        docs.append(doc)
        completion(true, docs)
        save()
    }
    
    // DELETE
    func delete(doc: DocRecord) {
        docs = docs.filter({ $0 != doc })
        managedObjectContext.delete(doc)
        save()
    }
    
    private func save() {
        do {
            try managedObjectContext.save()
        }
        catch let error as NSError {
            print("Save failed: \(error.localizedDescription)")
        }
    }
}



































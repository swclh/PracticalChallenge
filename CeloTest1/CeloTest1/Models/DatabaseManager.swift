//
//  DatabaseManager.swift
//  CeloTest1
//
//  Created by Shafee Rehman on 29/05/22.
//

import Foundation
import UIKit
import CoreData

class DatabaseManager
{
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static let shared = DatabaseManager()
    
    func add<T:NSManagedObject>(objectType: T.Type) -> T?{
        guard let entityName = T.entity().name else {return nil}
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            return nil
        }
        
        let object = NSManagedObject(entity: entity, insertInto: context)
        
        return object as? T
    }
    
    func load<T:NSManagedObject>(objectType: T.Type, predicates:[NSPredicate], rows:Int = 10, SortKey:String) -> [T] {
        
        let request = T.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        request.sortDescriptors = [NSSortDescriptor(key: SortKey,ascending: true)]
        request.fetchLimit = rows
        request.fetchOffset = 10
        
        do {
            let result = try context.fetch(request)
            return result as! [T]
        }
        catch{
            print(error)
        }
        
        return []
    }
    
    func delete<T : NSManagedObject>(object: T)
    {
        context.delete(object)
        save()
    }
    
    func save()
    {
        do{
            try context.save()
        }
        catch{
            print(error)
        }
    }
    
    func DeleteAll<T:NSManagedObject>(objectType : T.Type)
    {
        guard let entityName = T.entity().name else {return}
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print (error)
        }
    }
    
}

//
//  CoreDataManager.swift
//  bariumApp
//
//  Created by Kerem Safa Dirican on 3.12.2022.
//

import UIKit
import CoreData


final class CoreDataManager {
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func saveNote(season:Int, episode:Int, noteTitle:String, noteDetail:String) -> Note? {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        note.setValue(season, forKey: "season")
        note.setValue(episode, forKey: "episode")
        note.setValue(noteTitle, forKey: "noteTitle")
        note.setValue(noteDetail, forKey: "noteDetail")
        
        do {
            try managedContext.save()
            return note as? Note
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func getNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes as! [Note]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    func deleteNote(note: Note) {
        managedContext.delete(note)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func editNote(obj: Note, season:Int, episode:Int, noteTitle:String, noteDetail:String) {
        let note = managedContext.object(with: obj.objectID)
        note.setValue(season, forKey: "season")
        note.setValue(episode, forKey: "episode")
        note.setValue(noteTitle, forKey: "noteTitle")
        note.setValue(noteDetail, forKey: "noteDetail")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}

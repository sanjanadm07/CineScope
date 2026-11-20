//
//  PersistenceController.swift
//  CineScope
//
//  Created by Medhavi Magar on 19/11/26.
//

import Foundation
import CoreData
final class PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    private init() {
        container = NSPersistentContainer(name: "CineScopeModel")
        container.loadPersistentStores { desciption , error in
            if let error = error {
                fatalError("Failed to load Core data: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

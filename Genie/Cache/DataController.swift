//
//  DataController.swift
//  Genie
//
//  Created by Nathalie Cesarino on 06/05/23.
//

import Foundation
import CoreData

class DataController {

    // =========================================================
    // MARK: - Properties
    // =========================================================

    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // =========================================================
    // MARK: - Lifecycle
    // =========================================================

    init(model: String) {
        persistentContainer = NSPersistentContainer(name: model)
    }

    // =========================================================
    // MARK: - Methods
    // =========================================================

    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            completion?()
        }
    }
}

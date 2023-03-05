//
//  Persistence.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0 ..< 10 {}
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Lo_Li")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    // 保存
    public func saveData(onComplete: @escaping () -> (), onError: @escaping () -> ()) {
        let context = container.viewContext
        // 根据约束合并重复项
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        // 保存前检查是否有更改
        if context.hasChanges {
            do {
                try context.save()
                onComplete()
            } catch let error as NSError {
                onError()
                // Push an error message to the user
                pushPop("保存数据失败。", style: .danger)
                // Print the error message to the console
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
}

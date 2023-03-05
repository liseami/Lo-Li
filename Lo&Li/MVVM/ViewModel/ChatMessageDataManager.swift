//
//  EventDataManager.swift
//  LifeLoop
//
//  Created by 赵翔宇 on 2023/2/9.
//

import CoreData
import SwiftUI

class ChatMessageDataManager: NSObject, ObservableObject {
    static let shared = ChatMessageDataManager()
    @Published var messages: [ChatMessage] = []
    let viewContext = PersistenceController.shared.container.viewContext

    let fetchedResultsController: NSFetchedResultsController<ChatMessage>
    override init() {
        let fetchRequest: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ChatMessage.createat, ascending: false)]
        let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultsController = resultsController
        super.init()
        resultsController.delegate = self
        self.loadData()
    }

    func loadData() {
        do {
            try self.fetchedResultsController.performFetch()
            self.messages = self.fetchedResultsController.fetchedObjects ?? []
        } catch {
            self.messages = []
        }
    }

    func refresh() {
        self.messages.removeAll()
        self.loadData()
    }
}

extension ChatMessageDataManager: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.refresh()
    }
}

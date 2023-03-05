//
//  EventDataManager.swift
//  LifeLoop
//
//  Created by 赵翔宇 on 2023/2/9.
//

import CoreData
import SwiftUI

class ChatConversationDataManager: NSObject, ObservableObject {
    static let shared = ChatConversationDataManager()
    @Published var conversations: [ChatConversation] = []
    let viewContext = PersistenceController.shared.container.viewContext

    let fetchedResultsController: NSFetchedResultsController<ChatConversation>
    override init() {
        let fetchRequest: NSFetchRequest<ChatConversation> = ChatConversation.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ChatConversation.createat, ascending: false)]
        let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultsController = resultsController
        super.init()
        resultsController.delegate = self
        self.loadData()
    }

    func loadData() {
        do {
            try self.fetchedResultsController.performFetch()
            self.conversations = self.fetchedResultsController.fetchedObjects ?? []
        } catch {
            self.conversations = []
        }
    }

    func refresh() {
        self.conversations.removeAll()
        self.loadData()
    }
}

extension ChatConversationDataManager: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.refresh()
    }
}

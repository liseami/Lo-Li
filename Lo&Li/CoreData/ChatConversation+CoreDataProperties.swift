//
//  ChatConversation+CoreDataProperties.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//
//

import CoreData
import Foundation

public extension ChatConversation {
    @nonobjc class func fetchRequest() -> NSFetchRequest<ChatConversation> {
        return NSFetchRequest<ChatConversation>(entityName: "ChatConversation")
    }

    @NSManaged var id: String
    @NSManaged var title: String
    @NSManaged var createat: Date
    @NSManaged var lasttimetouse: Date
    @NSManaged var messages: Set<ChatMessage>?
}

// MARK: Generated accessors for messages

public extension ChatConversation {
    @objc(addMessagesObject:)
    @NSManaged func addToMessages(_ value: ChatMessage)

    @objc(removeMessagesObject:)
    @NSManaged func removeFromMessages(_ value: ChatMessage)

    @objc(addMessages:)
    @NSManaged func addToMessages(_ values: NSSet)

    @objc(removeMessages:)
    @NSManaged func removeFromMessages(_ values: NSSet)
}

extension ChatConversation: Identifiable {
    //     AddNew
    func addNew() {
        id = UUID().uuidString
        title = "新的对话"
        createat = Date.now
        lasttimetouse = Date.now
        coreDataSave {} onError: {}
    }

    // CreatNew
    func creatNew() -> ChatConversation {
        id = UUID().uuidString
        title = "新的对话"
        createat = Date.now
        lasttimetouse = Date.now
        return self
    }
}

//
//  ChatConversation+CoreDataProperties.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//
//

import Foundation
import CoreData


extension ChatConversation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatConversation> {
        return NSFetchRequest<ChatConversation>(entityName: "ChatConversation")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var createat: Date
    @NSManaged public var lasttimetouse: Date
    @NSManaged public var messages: NSSet?

}

// MARK: Generated accessors for messages
extension ChatConversation {

    @objc(addMessagesObject:)
    @NSManaged public func addToMessages(_ value: ChatMessage)

    @objc(removeMessagesObject:)
    @NSManaged public func removeFromMessages(_ value: ChatMessage)

    @objc(addMessages:)
    @NSManaged public func addToMessages(_ values: NSSet)

    @objc(removeMessages:)
    @NSManaged public func removeFromMessages(_ values: NSSet)

}

extension ChatConversation : Identifiable {

}

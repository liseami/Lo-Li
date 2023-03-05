//
//  ChatMessage+CoreDataProperties.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//
//

import Foundation
import CoreData


extension ChatMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatMessage> {
        return NSFetchRequest<ChatMessage>(entityName: "ChatMessage")
    }

    @NSManaged public var createat: Date
    @NSManaged public var data: Data
    @NSManaged public var id: String
    @NSManaged public var conversation: ChatConversation

}


extension ChatMessage: Identifiable {
    var wrapvalue: MessageToShow {
        do {
            return try JSON(data: data).dictionaryObject!.kj.model(MessageToShow.self)
        } catch {
            return .init()
        }
    }

//     AddNew
    func addNew(mod: MessageToShow) {
        data = mod.stringData
        id = mod.id
        createat = Date(timeIntervalSince1970: TimeInterval(mod.createat.int ?? 0))
        coreDataSave {} onError: {}
    }

    // AddNew
    func creatNew(mod: MessageToShow) -> ChatMessage {
        data = mod.stringData
        id = mod.id
        createat = Date(timeIntervalSince1970: TimeInterval(mod.createat.int ?? 0))
        return self
    }
}

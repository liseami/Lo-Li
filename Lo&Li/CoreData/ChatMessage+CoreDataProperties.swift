//
//  ChatMessage+CoreDataProperties.swift
//  Lo&Li
//
//  Created by 赵翔宇 on 2023/3/5.
//
//

import CoreData
import Foundation

public extension ChatMessage {
    @nonobjc class func fetchRequest() -> NSFetchRequest<ChatMessage> {
        return NSFetchRequest<ChatMessage>(entityName: "ChatMessage")
    }

    @NSManaged var createat: String
    @NSManaged var data: Data
    @NSManaged var id: String
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
        createat = mod.createat
        coreDataSave {} onError: {}
    }

    // AddNew
    func creatNew(mod: MessageToShow) -> ChatMessage {
        data = mod.stringData
        id = mod.id
        createat = mod.createat
        return self
    }
}

extension Convertible {
    var stringData: Data {
        kj.JSONString().data(using: .utf8)!
    }
}

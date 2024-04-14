//
//  ChatMessageItem+CoreDataProperties.swift
//  GeminiChat
//
//  Created by 藤治仁 on 2024/04/12.
//
//

import Foundation
import CoreData

extension ChatMessageItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatMessageItem> {
        return NSFetchRequest<ChatMessageItem>(entityName: "ChatMessageItem")
    }

    @NSManaged public var message: String?
    @NSManaged public var role: String?
    @NSManaged public var timestamp: Date?

}

extension ChatMessageItem: Identifiable {
    public var isUser: Bool {
        let role = GeminiRole(rawValue: role ?? "") ?? .user
        return role == .user
    }
}

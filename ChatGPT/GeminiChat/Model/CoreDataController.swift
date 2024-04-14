//
//  CoreDataController.swift
//  ChatGPT
//
//  Created by 藤治仁 on 2023/03/07.
//

import Foundation
import CoreData
import GoogleGenerativeAI

class CoreDataController: NSObject {
    private let viewContext = PersistenceController.shared.container.viewContext

    func fetchPreviousMessages() throws -> [ModelContent] {
        var history: [ModelContent] = []
        
        let request = NSFetchRequest<ChatMessageItem>(entityName: "ChatMessageItem")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ChatMessageItem.timestamp, ascending: true)]
        let chatMessageItems = try viewContext.fetch(request)
        
        for item in chatMessageItems {
            if let role = item.role,
               let message = item.message,
               let content = try? ModelContent(role: role, message)
            {
                history.append(content)
            }
        }
        
        return history
    }
    
    func insertMessageIntoCoreData(role: String, message: String) throws {
        let newItem = ChatMessageItem(context: viewContext)
        newItem.timestamp = Date()
        newItem.role = role
        newItem.message = message
        
        try viewContext.save()
    }
    
    func clearMessages() throws {
        let request = NSFetchRequest<ChatMessageItem>(entityName: "ChatMessageItem")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ChatMessageItem.timestamp, ascending: true)]
        let chatMessageItems = try viewContext.fetch(request)
        for chatMessageItem in chatMessageItems {
            viewContext.delete(chatMessageItem)
        }
        if viewContext.hasChanges {
            try? viewContext.save()
        }
    }
}

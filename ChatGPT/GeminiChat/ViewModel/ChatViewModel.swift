//
//  ChatViewModel.swift
//  ChatGPT
//
//  Created by 藤治仁 on 2023/03/05.
//

import Foundation
import CoreData
import GoogleGenerativeAI

class ChatViewModel: ObservableObject {
    @Published var errorMessage = ""
    private let coreDataController = CoreDataController()
    private let viewContext = PersistenceController.shared.container.viewContext
    private var geminiModel: GenerativeModel!
    private var geminiChat: Chat!
    
    init() {
        guard let apiKey = UserDefaults.standard.string(forKey: UserDefaultsKey.geminiApiKey) else {
            return
        }
        
        // 生成モデルの初期化
        geminiModel = GenerativeModel(
            name: "models/gemini-pro",
            apiKey: apiKey
        )
        
        if let history = try? coreDataController.fetchPreviousMessages() {
            // マルチターンの会話の構築（チャット）
            geminiChat = geminiModel.startChat(history: history)
            debugLog(geminiChat.history)
        }
    }
    
    @MainActor
    func send(_ message: String) async {
        do {
            let response = try await geminiChat.sendMessage(message)
            if let resposeMessage = response.text {
                debugLog(resposeMessage)
                try coreDataController.insertMessageIntoCoreData(role: GeminiRole.user.rawValue, message: message)
                try coreDataController.insertMessageIntoCoreData(role: GeminiRole.model.rawValue, message: resposeMessage)
                if errorMessage.isEmpty == false {
                    errorMessage = ""
                }
                debugLog(geminiChat.history)
            }
        } catch {
            errorLog(error)
            errorMessage = error.localizedDescription
        }
    }
}

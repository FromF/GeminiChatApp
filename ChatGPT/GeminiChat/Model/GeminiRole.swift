//
//  Role.swift
//  ChatGPT
//
//  Created by 藤治仁 on 2023/03/05.
//

import Foundation

// roleについては、マルチターンの会話の構築（チャット）にて記載があります
// https://ai.google.dev/tutorials/get_started_swift?hl=ja#multi-turn-conversations-chat
enum GeminiRole: String {
    case user = "user"
    case model = "model"
}

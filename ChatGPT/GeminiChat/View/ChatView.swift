//
//  ChatView.swift
//  ChatGPT
//
//  Created by 藤治仁 on 2023/03/05.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ChatMessageItem.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<ChatMessageItem>
    
    @StateObject private var viewModel = ChatViewModel()
    @State private var message: String = ""
    @State private var isProgress: Bool = false
    
    var body: some View {
        VStack {
            ScrollViewReader { _ in
                List {
                    ForEach(items) { item in
                        HStack {
                            if let timeStamp = item.timestamp {
                                VStack {
                                    Text(timeStamp, style: .date)
                                        .font(.caption)
                                    Text(timeStamp, style: .time)
                                        .font(.caption)
                                }
                            }
                            Image(systemName: item.isUser ? "person" : "brain")
                            if let message = item.message {
                                Text(.init(message))
                            }
                        }
                    }
                }
                
                ZStack {
                    TextField("メッセージを入力してください", text: $message)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            Task {
                                if message.isEmpty == false {
                                    isProgress = true
                                    await viewModel.send(message)
                                    message = ""
                                    isProgress = false
                                }
                            }
                        }
                    if isProgress {
                        Color.gray
                            .frame(height: 40)
                        ProgressView()
                    }
                } // ZStack
                .padding()
            } // ScrollViewReader
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

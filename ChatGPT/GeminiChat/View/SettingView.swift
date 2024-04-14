//
//  SettingView.swift
//  ChatGPT
//
//  Created by 藤治仁 on 2023/03/05.
//

import SwiftUI

struct SettingView: View {
    @AppStorage(UserDefaultsKey.geminiApiKey) private var apiKey: String = ""
    @State private var isShow = false
    @State private var isClear = false

    var body: some View {
        VStack {
            Text("Google AI Stduioサイトで\"Create API key\"を押してキーを発行して貼り付けてください")
                .padding()
            Text("https://aistudio.google.com/app/apikey")
                .padding()
            
            HStack {
                if isShow {
                    TextField("OpenAIのAPIキーを入力してください", text: $apiKey)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    SecureField("OpenAIのAPIキーを入力してください", text: $apiKey)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Button {
                    isShow.toggle()
                } label: {
                    Image(systemName: isShow ? "eye.slash.fill" : "eye.fill")
                }
            }
            .padding()

            Divider()
            
            Button {
                do {
                    try CoreDataController().clearMessages()
                } catch {
                    errorLog(error)
                }
                isClear = true
            } label: {
                Text("履歴をクリアする")
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            if isClear {
                Text("履歴をクリアしました")
                    .foregroundStyle(.gray)
                Text("アプリを再起動してください")
                    .foregroundStyle(.gray)
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

//
//  ChatTabView.swift
//  ChatGPT
//
//  Created by 藤治仁 on 2023/03/05.
//

import SwiftUI

struct ChatTabView: View {
    @State var selection = 1
    var body: some View {
        TabView {
            ChatView()
                .tabItem {
                    Label {
                        Text("Chat")
                    } icon: {
                        Image(systemName: "bubble.left.and.bubble.right")
                    }
                }
                .tag(0)
            SettingView()
                .tabItem {
                    Label {
                        Text("Setting")
                    } icon: {
                        Image(systemName: "gearshape.fill")
                    }
                }
        }
    }
}

struct ChatTabView_Previews: PreviewProvider {
    static var previews: some View {
        ChatTabView()
    }
}

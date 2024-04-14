//
//  debug.swift
//  ChatGPT
//
//  Created by 藤治仁 on 2023/03/05.
//

import UIKit

/// デバックモード設定
func debugLog(_ obj: Any?,
              file: String = #file,
              function: String = #function,
              line: Int = #line) {
    #if DEBUG
    let filename = URL(fileURLWithPath: file).lastPathComponent
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .medium
    let dateString = dateFormatter.string(from: Date())
    if let obj = obj {
        print("\(dateString)[\(filename) \(function):\(line)] : \(obj)")
    } else {
        print("\(dateString)[\(filename) \(function):\(line)]")
    }
    #endif
}

func errorLog(_ obj: Any?,
              file: String = #file,
              function: String = #function,
              line: Int = #line) {
    #if DEBUG
    let filename = URL(fileURLWithPath: file).lastPathComponent
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .medium
    let dateString = dateFormatter.string(from: Date())
    if let obj = obj {
        print("\(dateString)ERROR [\(filename) \(function):\(line)] : \(obj)")
    } else {
        print("\(dateString)ERROR [\(filename) \(function):\(line)]")
    }
    #endif
}

var isSimulator: Bool {
    #if targetEnvironment(simulator)
    // iOS simulator code
    return true
    #else
    return false
    #endif
}

// デバイス判定マクロ
/// iPadかデバイス判定
var isPad: Bool {
    return UIDevice.current.userInterfaceIdiom == .pad ? true : false
}

/// iPhoneかデバイス判定
var isPhone: Bool {
    return UIDevice.current.userInterfaceIdiom == .phone ? true : false
}

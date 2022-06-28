//
//  UserDefaults+Extension.swift
//  SourceWordCounter
//
//  Created by Ryan J. W. Kim on 2022/06/27.
//

import Foundation

enum UserDefaultsKeys: String {
    case loadText
    case saveText
}
extension UserDefaults {
    // MARK: - Save text
    func saveText(value: String) {
        setValue(value, forKey: UserDefaultsKeys.saveText.rawValue)
    }
    // MARK: - Load text
    func loadText() -> String {
        return string(forKey: UserDefaultsKeys.saveText.rawValue) ?? ""
    }
    // MARK: - Remove saved text from UserDefaults
    func removeTextFromKey() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.saveText.rawValue)
    }
}

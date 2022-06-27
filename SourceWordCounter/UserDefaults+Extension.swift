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
    func saveText(value: String) {
        setValue(value, forKey: UserDefaultsKeys.saveText.rawValue)
    }
    func loadText() -> String {
        return string(forKey: UserDefaultsKeys.saveText.rawValue) ?? ""
//        return string(forKey: key.rawValue) ?? ""
    }
    func removeTextFromKey() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.saveText.rawValue)
    }
//    func setLoggedIn(value: Bool) {
//        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
//        //synchronize()
//    }
//
//    func isLoggedIn()-> Bool {
//        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
//    }

//    //MARK: Save User Data
//    func setUserID(value: Int){
//        set(value, forKey: UserDefaultsKeys.userID.rawValue)
//        //synchronize()
//    }
//
//    //MARK: Retrieve User Data
//    func getUserID() -> Int{
//        return integer(forKey: UserDefaultsKeys.userID.rawValue)
//    }
}

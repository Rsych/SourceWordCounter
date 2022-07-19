//
//  String+Extension.swift
//  SourceWordCounter
//
//  Created by Ryan J. W. Kim on 2022/07/19.
//

import Foundation

extension String {

    static let empty: String = ""

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func localized(comment: String) -> String {
        return NSLocalizedString(self, comment: comment)
    }

}

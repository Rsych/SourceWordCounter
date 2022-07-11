//
//  NSTextView+Extension.swift
//  SourceWordCounter
//
//  Created by Ryan J. W. Kim on 2022/07/09.
//

import Foundation
import SwiftUI

extension NSTextView {
    open override var frame: CGRect {
        didSet {
            backgroundColor = .clear // <<here clear background
            drawsBackground = true
        }

    }
}

//
//  StyleEntry.swift
//  Lab7
//
//  Created by MV X01a on 2020-03-12.
//  Copyright © 2020 MV X01A. All rights reserved.
//

import UIKit

class StyleEntry: NSObject {
    //MARK: - Properties
    var styleName: String
    var isBold: Bool
    var isItalic: Bool
    var isUnderline: Bool
    
    //MARK: - Initializers
    init(styleName: String, isBold: Bool, isItalic: Bool, isUnderline: Bool) {
        self.styleName = styleName
        self.isBold = isBold
        self.isItalic = isItalic
        self.isUnderline = isUnderline
    }
}

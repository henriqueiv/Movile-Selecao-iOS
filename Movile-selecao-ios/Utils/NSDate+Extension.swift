//
//  NSDate+Extension.swift
//  Movile-selecao-ios
//
//  Created by Henrique Valcanaia on 5/25/16.
//  Copyright © 2016 Henrique Valcanaia. All rights reserved.
//

import Foundation

extension NSDate {
    
    func stringDateWithFormat(format: String = "yyyyMMdd-HHmmss") -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.stringFromDate(self)
    }
    
}

//
//  Extensions.swift
//  test-mozghovoy
//
//  Created by Sergey Mozgovoy on 22/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import Foundation
import UIKit

// MARK - String Extensions:

extension String {

}

extension UILabel {
    func setLimit() {
        let maxLength = Globals.Limits.nameRepositoryLimit
        if ((self.text?.characters.count != nil)  && (self.text?.characters.count)! > maxLength){
            let range =  self.text?.rangeOfComposedCharacterSequences(for: (self.text?.startIndex)!..<(self.text?.index((self.text?.startIndex)!, offsetBy: maxLength))!)
            let tmpValue = self.text?.substring(with: range!).appending("...")
            self.text = tmpValue
        }
    }
    
}

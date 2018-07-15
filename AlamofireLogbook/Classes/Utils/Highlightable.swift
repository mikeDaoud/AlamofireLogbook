//
//  Highlightable.swift
//  AlamofireLogbook
//
//  Created by Michael Attia on 6/1/18.
//  Copyright © 2018 Michael Attia. All rights reserved.
//

import Foundation

protocol Highlightable: class{
    func setHighlightedText(_ text: NSAttributedString)
}

extension Highlightable{
    func setHighlightedText(_ text: String, highlight: String, with color: UIColor = UIColor.yellow){
        let attrString: NSMutableAttributedString = NSMutableAttributedString(string: text)
        var ranges: [Range<String.Index>] = []
        while let range = text.range(of: highlight, options: .caseInsensitive, range: (ranges.last?.upperBound ?? text.startIndex)..<text.endIndex){
            ranges.append(range)
        }
        ranges.map{return NSRange($0, in: text)}.forEach{
            attrString.addAttributes([NSAttributedStringKey.backgroundColor: color], range: $0)
        }
        self.setHighlightedText(attrString)
    }
}

extension UILabel: Highlightable{
    func setHighlightedText(_ text: NSAttributedString) {
        self.attributedText = text
    }
}
extension UITextView: Highlightable{
    func setHighlightedText(_ text: NSAttributedString) {
        self.attributedText = text
    }
}

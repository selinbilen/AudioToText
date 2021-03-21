//
//  RecordButton.swift
//  SpeechToText
//
//  Created by selin eylül bilen on 3/20/21.
//

import UIKit
@IBDesignable
class RecordButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 30.0{
        didSet{
            setupView()
        }
    }
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
}

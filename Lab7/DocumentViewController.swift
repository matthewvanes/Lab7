//
//  DocumentViewController.swift
//  Lab7
//
//  Created by MV X01a on 2020-03-06.
//  Copyright © 2020 MV X01A. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var documentNameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var style1Button: UIButton!
    @IBOutlet weak var style2Button: UIButton!
    @IBOutlet weak var style3Button: UIButton!
    @IBOutlet weak var style4Button: UIButton!
    
    var document: Document?
    var styleData = [StyleEntry]()
    let fontSize: CGFloat = 18
    
//    let boldStyle: NSAttributedString.Key = NSAttributedString.Key("boldStyle")
//    let italicStyle: NSAttributedString.Key = NSAttributedString.Key("italicStyle")
//    let underlineStyle: NSAttributedString.Key = NSAttributedString.Key("underlineStyle")
//    let boldFont: UIFont = .systemFont(ofSize: 14, weight: .bold)
//    let italicFont: UIFont = .italicSystemFont(ofSize: 14)
//    let underlineFont: UIFont = .systemFont(ofSize: 14, weight: .bold)
//
//    var testDictionary = [ NSAttributedString.Key("boldStyle") : UIFont.systemFont(ofSize: 14, weight: .bold),
//                           NSAttributedString.Key("italicStyle") : UIFont.italicSystemFont(ofSize: 20),
//                           NSAttributedString.Key("underlineStyle") : UIFont.systemFont(ofSize: 14, weight: .bold)
//                        ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
                self.textView.attributedText = self.document?.text
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
        // These could obviously be done in a loop. Look into later
        styleData.append(StyleEntry(styleName: style1Button?.titleLabel?.text ?? "Style 1", isBold: false, isItalic: false, isUnderline: false))
        styleData.append(StyleEntry(styleName: style2Button?.titleLabel?.text ?? "Style 2", isBold: false, isItalic: false, isUnderline: false))
        styleData.append(StyleEntry(styleName: style3Button?.titleLabel?.text ?? "Style 3", isBold: false, isItalic: false , isUnderline: false))
        styleData.append(StyleEntry(styleName: style4Button?.titleLabel?.text ?? "Style 4", isBold: false, isItalic: false, isUnderline: false))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier != "ShowController" {
            return
        }
        guard let customizeViewController = segue.destination.children[0] as? CustomizeViewController else {
            fatalError("Unexpected destination \(segue.destination)")
        }
        customizeViewController.pickerData = styleData
    }
    
    //MARK: - Button Actions
    @IBAction func dismissDocumentViewController() {
        if document?.text != textView.attributedText {
            document?.text = textView.attributedText
            document?.updateChangeCount(.done)
        }
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
    
    @IBAction func unwindToDocumentViewController(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? CustomizeViewController {
            // Should be turned into for loop. Look into later.
            style1Button.setTitle(sourceViewController.pickerData[0].styleName, for: .normal)
            style2Button.setTitle(sourceViewController.pickerData[1].styleName, for: .normal)
            style3Button.setTitle(sourceViewController.pickerData[2].styleName, for: .normal)
            style4Button.setTitle(sourceViewController.pickerData[3].styleName, for: .normal)
        }
    }
    
    @IBAction func style1ButtonPressed(_ sender: UIButton) {
        let buttonIndex: Int = 0
        applyStyles(styleIndex: buttonIndex)
    }
    
    @IBAction func style2ButtonPressed(_ sender: UIButton) {
        let buttonIndex: Int = 1
        applyStyles(styleIndex: buttonIndex)
    }
    
    @IBAction func style3ButtonPressed(_ sender: UIButton) {
        let buttonIndex: Int = 2
        applyStyles(styleIndex: buttonIndex)
    }
    
    @IBAction func style4ButtonPressed(_ sender: UIButton) {
        let buttonIndex: Int = 3
        applyStyles(styleIndex: buttonIndex)
    }
    
    func applyStyles(styleIndex: Int) {
        let range = textView.selectedRange
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: textView.text)
        let selectedStyle: StyleEntry = styleData[styleIndex]
        if selectedStyle.isBold {
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: fontSize)], range: range)
        }
        if selectedStyle.isItalic {
            attributedString.addAttributes([NSAttributedString.Key.font : UIFont.italicSystemFont(ofSize: fontSize)], range: range)
        }
        if selectedStyle.isUnderline {
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        }
        textView.attributedText = attributedString
    }
    
}

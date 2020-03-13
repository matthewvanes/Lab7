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
    
    // PURPOSE:
    // Called when the "Done" button is selected in CustomizeViewController
    //
    // PARAMETERS:
    // UIStoryboardSegue: ShowController
    //
    // RETURN/SIDE EFFECTS:
    // Sets the title of the style buttons to their entry in pickerData
    //
    // NOTES:
    // N/A
    //
    @IBAction func unwindToDocumentViewController(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? CustomizeViewController {
            // Should be turned into for loop. Look into later.
            style1Button.setTitle(sourceViewController.pickerData[0].styleName, for: .normal)
            style2Button.setTitle(sourceViewController.pickerData[1].styleName, for: .normal)
            style3Button.setTitle(sourceViewController.pickerData[2].styleName, for: .normal)
            style4Button.setTitle(sourceViewController.pickerData[3].styleName, for: .normal)
        }
    }
    
    // PURPOSE:
    // Calls applyStyles function with provided "buttonIndex"
    //
    // PARAMETERS:
    // UIButton: self
    //
    // RETURN/SIDE EFFECTS:
    // Calls applyStyles function with provided "buttonIndex"
    //
    // NOTES:
    // Each of these functions are the functionally identical.
    // Difference is only the index provided when each button is pressed.
    //
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
    
    // PURPOSE:
    // Applies style(s) of selected StyleEntry to selected text.
    //
    // PARAMETERS:
    // N/A
    //
    // RETURN/SIDE EFFECTS:
    // Sets selected text to the styles of selected StyleEntry.
    //
    // NOTES:
    //
    //
    // MARK: - FIX ME
    // Currently bold and italic cannot be selected together. Fonts override each other.
    //
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

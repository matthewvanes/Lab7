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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier != "ShowController" {
            return
        }
        guard let customizeViewController = segue.destination.children[0] as? CustomizeViewController else {
            fatalError("Unexpected destination \(segue.destination)")
        }
        // These could obviously be done in a loop. Look into later
        customizeViewController.pickerData.append(style1Button?.titleLabel?.text ?? "Style 1")
        customizeViewController.pickerData.append(style2Button?.titleLabel?.text ?? "Style 2")
        customizeViewController.pickerData.append(style3Button?.titleLabel?.text ?? "Style 3")
        customizeViewController.pickerData.append(style4Button?.titleLabel?.text ?? "Style 4")
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
            // These could obviously be done in a for loop. Look into fixing later.
            style1Button.setTitle(sourceViewController.pickerData[0], for: .normal)
            style2Button.setTitle(sourceViewController.pickerData[1], for: .normal)
            style3Button.setTitle(sourceViewController.pickerData[2], for: .normal)
            style4Button.setTitle(sourceViewController.pickerData[3], for: .normal)
            print(sourceViewController.pickerData)
        }
    }
    
    @IBAction func style1ButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func style2ButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func style3ButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func style4ButtonPressed(_ sender: UIButton) {
    }
}
